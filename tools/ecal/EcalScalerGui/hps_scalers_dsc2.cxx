#include <stdio.h>
#include <stdlib.h>
#include <TCanvas.h>
#include <TH2.h>
#include <TStyle.h>
#include <TPaveText.h>
#include <TH2Poly.h>
#include <TSystem.h>
#include <TRootEmbeddedCanvas.h>
#include <TApplication.h>
#include <TGFileDialog.h>
#include <TGButton.h>
#include <TImage.h>
#include <TArrow.h>
#include <THashList.h>
#include <TTimeStamp.h>
#include <iostream>

#include "CrateMsgClient.h"

#define SCALER_UPDATE_PERIOD	1000	/* in milliseconds */

struct totalrates_t
{
    int top,bottom,left,right,total;
};

class hps_scalers_dsc2_app : public TGMainFrame
{
    private:

        bool accumulate;

        int connect_to_server();
        int read_scalers();
        int get_ch(int x, int y);
        int get_crate_map();
        int hps_crate_map[2][22];

        unsigned int hpsdsc2_crate_slot_scalers[2][22][16];
        unsigned int hpsdsc2_crate_slot_ref[2][22];

        totalrates_t get_total_rate();

        void draw_scalers();
        void normalize_scalers();

        CrateMsgClient *crate_hps[2];
        TCanvas *pTC;
        TH2I *pH;
        TRootEmbeddedCanvas *pCanvas;
    public:
        hps_scalers_dsc2_app(const TGWindow *p, UInt_t w, UInt_t h, bool accumulate=0);
        ~hps_scalers_dsc2_app();

        void DoExit();
        void button_Save();
        void button_LogEnable();
        void refresh_scalers();


        ClassDef(hps_scalers_dsc2_app, 0)
};

int hps_scalers_dsc2_app::connect_to_server()
{
    for(int i = 0; i < 2; i++)
    {
        char buf[100];
        sprintf(buf, "hps%d", 12-i);
        crate_hps[i] = new CrateMsgClient(buf, 6102);
        if(!crate_hps[i]->IsValid())
            return -1;
    }
    return 0;
}

int hps_scalers_dsc2_app::read_scalers()
{
    unsigned int *buf;
    int len;

    for(int crate = 0; crate < 2; crate++)
    {
        for(int slot = 0; slot <= 20; slot++)
        {
            if(hps_crate_map[crate][slot] == SCALER_TYPE_DSC2)
            {
                if(!crate_hps[crate]->ScalerReadBoard(slot, &buf, &len)) return -3;

                for(int ch = 0; ch < 16; ch++)
                    hpsdsc2_crate_slot_scalers[crate][slot][ch] = buf[51+ch];
                hpsdsc2_crate_slot_ref[crate][slot] = buf[68];

                delete [] buf;
            }
        }
    }
    return 0;
}

void hps_scalers_dsc2_app::normalize_scalers()
{
    float ref, scaled;

    for(int crate = 0; crate < 2; crate++)
    {
        for(int slot = 0; slot <= 20; slot++)
        {
            if(hps_crate_map[crate][slot] == SCALER_TYPE_DSC2)
            {
                if(hpsdsc2_crate_slot_ref[crate][slot] <= 0)
                {
                    printf("Error in normalize_scalers(): hpsdsc2_crate_slot_ref[%d][%d]=%d not valid\n", crate, slot, hpsdsc2_crate_slot_ref[crate][slot]);
                    ref = 1;
                }
                else
                    ref = 125.0E6f / (float)hpsdsc2_crate_slot_ref[crate][slot];

                for(int ch = 0; ch < 16; ch++)
                {
                    scaled = (float)hpsdsc2_crate_slot_scalers[crate][slot][ch] * ref / 1250;  //  NABO HARD-CODED FIX 
                    hpsdsc2_crate_slot_scalers[crate][slot][ch] = (int)scaled;
                }
            }
        }
    }
}

totalrates_t hps_scalers_dsc2_app::get_total_rate()
{
    totalrates_t rr={0,0,0,0,0};
    for (int crate=0; crate<2; crate++)
    {
        for (int slot=0; slot<=20; slot++)
        {
            for (int chan=0; chan<16; chan++)
            {
                if (slot==20 && chan>12) continue;
                const int xx=hpsdsc2_crate_slot_scalers[crate][slot][chan];
                rr.total += xx; 
                if (crate==0) rr.top += xx;
                else          rr.bottom += xx;
            }
        }
    }
    return rr;
}

int hps_scalers_dsc2_app::get_ch(int x, int y)
{
    int x_pos = 23;
    int y_pos = 1;
    int idx = 0;

    while(x_pos > -23)
    {
        if((x == x_pos) && (y == y_pos))
        {
            if(idx < 7*16)
                return 3*16+idx;
            else
                return 7*16+idx;
        }
        idx++;
        if(y_pos >= 5)
        {
            x_pos--;
            if((x_pos <= -1) && (x_pos >= -9))
                y_pos = 2;
            else
                y_pos = 1;
        }
        else
            y_pos++;
    }
    return -1;
}
void hps_scalers_dsc2_app::draw_scalers()
{
    static bool called=0;
    static TPaveText tt1(0.1,0.9,0.3,1.0,"NDC");
    static TPaveText tt2(0.7,0.91,0.9,0.99,"NDC");
    static TPaveText ttT(-22+13+0.05,6-5,-22+22,7-5-0.05);
    static TPaveText ttB(-22+13+0.05,4-5+0.05,-22+22,5-5);
    static TPaveText ttM(-22+0+0.05,5-5+0.05,-22+13,6-5.01);
    static TBox bb;
    static TLine ll;
    static TText tarrow(14.5,0.3,"Beam Left");
    static TArrow arrow(19,0.5,23,0.5,0.02,"|>");

    if (!called)
    {
        called=1;
        bb.SetFillStyle(1001);
        bb.SetFillColor(kWhite);
        bb.SetLineWidth(1);
        bb.SetLineColor(kBlack);
        tt1.SetBorderSize(0);
        tt2.SetBorderSize(0);
        tt1.SetFillColor(kWhite);
        tt2.SetFillColor(kWhite);
        ttT.SetBorderSize(0);
        ttB.SetBorderSize(0);
        ttT.SetFillColor(kWhite);
        ttB.SetFillColor(kWhite);
        ttM.SetBorderSize(0);
        ttM.SetFillColor(kWhite);
        ttM.SetTextColor(kRed);
        arrow.SetAngle(40);
        arrow.SetFillColor(kBlack);
        arrow.SetLineWidth(2);
    }

    unsigned int max=0;
    pH->SetMinimum(0);
    if (!accumulate) pH->Reset();
    for(int x = -23; x <= 23; x++)
    {
        for(int y = 1; y <= 5; y++)
        {
            int ch = get_ch(x, y);

            if(ch >= 0)
            {
                pH->Fill(x, y, hpsdsc2_crate_slot_scalers[0][ch/16][ch%16]);
                pH->Fill(x, -y, hpsdsc2_crate_slot_scalers[1][ch/16][ch%16]);
                //if (y<3 && (x>=-11 || x<=1))
                //{
                    if (hpsdsc2_crate_slot_scalers[0][ch/16][ch%16] > max) 
                        max=hpsdsc2_crate_slot_scalers[0][ch/16][ch%16];
                    if (hpsdsc2_crate_slot_scalers[1][ch/16][ch%16] > max) 
                        max=hpsdsc2_crate_slot_scalers[1][ch/16][ch%16];
                //}
            }
        }
    }

    bb.DrawBox(-9+0.05,-1,0,1.97);
    bb.DrawBox(-24,0,24,0.97);
    ll.DrawLine(pH->GetXaxis()->GetXmin(),pH->GetYaxis()->GetXmin(),
                pH->GetXaxis()->GetXmax(),pH->GetYaxis()->GetXmin());
    ll.DrawLine(pH->GetXaxis()->GetXmin(),pH->GetYaxis()->GetXmax(),
                pH->GetXaxis()->GetXmax(),pH->GetYaxis()->GetXmax());
    ll.DrawLine(pH->GetXaxis()->GetXmin(),pH->GetYaxis()->GetXmin(),
                pH->GetXaxis()->GetXmin(),0);
    ll.DrawLine(pH->GetXaxis()->GetXmax(),pH->GetYaxis()->GetXmin(),
                pH->GetXaxis()->GetXmax(),0);
    ll.DrawLine(pH->GetXaxis()->GetXmin(),pH->GetYaxis()->GetXmax(),
                pH->GetXaxis()->GetXmin(),1);
    ll.DrawLine(pH->GetXaxis()->GetXmax(),pH->GetYaxis()->GetXmax(),
                pH->GetXaxis()->GetXmax(),1);
    ll.DrawLine(pH->GetXaxis()->GetXmax(),0,0,0);
    ll.DrawLine(pH->GetXaxis()->GetXmax(),1,0,1);
    ll.DrawLine(pH->GetXaxis()->GetXmin(),0,-9,0);
    ll.DrawLine(pH->GetXaxis()->GetXmin(),1,-9,1);
    ll.DrawLine(-9,-1,0,-1);
    ll.DrawLine(-9,2,0,2);
    ll.DrawLine(-9,1,-9,2);
    ll.DrawLine(-9,-1,-9,0);
    ll.DrawLine(0,-1,0,0);
    ll.DrawLine(0,1,0,2);


    const totalrates_t rr=get_total_rate();
    tt1.Clear();
    tt2.Clear();
    ttT.Clear();
    ttB.Clear();
    ttM.Clear();
    tt1.AddText(Form("Total:  %.1E Hz",(float)rr.total));
    tt2.AddText(Form("Total:  %.1f kHz",(float)rr.total/1000));
    ttT.AddText(Form("%.2f kHz",(float)rr.top/1000));
    ttB.AddText(Form("%.2f kHz",(float)rr.bottom/1000));
    ttM.AddText(Form("MAX SINGLE CRYSTAL = %.2f kHz",(float)max/1000));
    tt1.Draw();
    tt2.Draw();
    ttT.Draw();
    ttB.Draw();
    ttM.Draw();

    arrow.Draw();
    tarrow.Draw();

    pCanvas->GetCanvas()->Modified();
    pCanvas->GetCanvas()->Update();
}

int hps_scalers_dsc2_app::get_crate_map()
{
    unsigned int *map;
    int len;

    for(int crate = 0; crate < 2; crate++)
    {
        if(!crate_hps[crate]->GetCrateMap(&map, &len)) return -4;
        if(len > 22) return -5;

        for(int slot = 0; slot < len; slot++)
        {
            hps_crate_map[crate][slot] = map[slot];
            printf("crate %d, slot %d, type %d\n", crate, slot, map[slot]);
        }
        delete [] map;
    }
    return 0;
}

void hps_scalers_dsc2_app::refresh_scalers()
{
    if(read_scalers() < 0) DoExit();
    normalize_scalers();
    draw_scalers();
    TTimer::SingleShot(SCALER_UPDATE_PERIOD, "hps_scalers_dsc2_app", this, "refresh_scalers()");
}

void hps_scalers_dsc2_app::DoExit()
{
    gApplication->Terminate();
}

hps_scalers_dsc2_app::~hps_scalers_dsc2_app()
{
    Cleanup();
}

void hps_scalers_dsc2_app::button_LogEnable()
{
    pCanvas->GetCanvas()->SetLogz(!pCanvas->GetCanvas()->GetLogz());
}

void hps_scalers_dsc2_app::button_Save()
{
    TClass* clGMainFrame = TClass::GetClass("TGMainFrame");
    TGWindow* win = 0;

    TTimeStamp tt;
    TString tstub=tt.AsString("lc");
    tstub.ReplaceAll(" ","_");
    gPad->SaveAs(Form("%s/screenshots/ECALSCALERS_%s.png",
                gSystem->Getenv("HOME"),tstub.Data()));
    return;

    static TString dir("printouts");
    TGFileInfo fi;
    const char *myfiletypes[] = 
    { 
        "All files","*",
        "PNG files","*.png",
        "GIF files","*.gif",
        "JPG files","*.jpg",
        0,
        0 
    };

    fi.fFileTypes = myfiletypes;
    fi.fIniDir    = StrDup(dir.Data());

    new TGFileDialog(gClient->GetRoot(), 0, kFDSave, &fi);

    if(fi.fFilename != NULL) 
    {
        TIter iWin(gClient->GetListOfWindows());
        while ((win = (TGWindow*)iWin()))
        {
            if(win->InheritsFrom(clGMainFrame))
            {
                TImage *img = TImage::Create();
                img->FromWindow(win->GetId());
                TString dog=gSystem->BaseName(fi.fFilename);
                dog.ReplaceAll(".","__"+tstub+".");
                dog=Form("%s/screenshots/EcalScalers_DSC2_%s",
                        gSystem->Getenv("HOME"),dog.Data());
                std::cout<<"Saving as:   "<<dog<<std::endl;
                img->WriteImage(dog);
                break;
            }
        }

    }
}

hps_scalers_dsc2_app::hps_scalers_dsc2_app(const TGWindow *p, UInt_t w, UInt_t h, bool accumulate) : TGMainFrame(p, w, h) 
{
    this->accumulate=accumulate;

    printf("hps_scalers_dsc2_app started...\n");

    SetCleanup(kDeepCleanup);

    Connect("CloseWindow()", "hps_scalers_dsc2_app", this, "DoExit()");
    DontCallClose();

    TGCompositeFrame *pTF;
    TGTextButton *pB;

    AddFrame(pTF= new TGHorizontalFrame(this), new TGLayoutHints(kLHintsExpandX));
    pTF->AddFrame(pB = new TGTextButton(pTF, new TGHotString("LogToggle")), new TGLayoutHints(kLHintsLeft | kLHintsCenterX));
    pB->Connect("Clicked()", "hps_scalers_dsc2_app", this, "button_LogEnable()");
    pTF->AddFrame(pB = new TGTextButton(pTF, new TGHotString("Save")), new TGLayoutHints(kLHintsLeft | kLHintsCenterX));
    pB->Connect("Clicked()", "hps_scalers_dsc2_app", this, "button_Save()");
    pTF->AddFrame(pB = new TGTextButton(pTF, new TGHotString("Exit")), new TGLayoutHints(kLHintsLeft | kLHintsCenterX));
    pB->Connect("Clicked()", "hps_scalers_dsc2_app", this, "DoExit()");
    AddFrame(pTF = new TGVerticalFrame(this), new TGLayoutHints(kLHintsExpandX | kLHintsExpandY));
    pTF->AddFrame(pCanvas = new TRootEmbeddedCanvas("c1", pTF, w, h), new TGLayoutHints(kLHintsExpandX | kLHintsExpandY));

    pCanvas->GetCanvas()->SetBorderMode(0);
    pCanvas->GetCanvas()->cd();

    pH = new TH2I("HPS DSC2 Scalers", ";X;Y", 46, -22.0, 24.0, 11, -5.0, 6.0);
    pH->SetStats(0);
    pH->GetXaxis()->CenterLabels();
    pH->GetXaxis()->SetNdivisions(46, kFALSE);
    pH->GetXaxis()->SetTickLength(0);
    pH->GetYaxis()->CenterLabels();
    pH->GetYaxis()->SetNdivisions(11, kFALSE);
    pH->GetYaxis()->SetTickLength(0);
    pH->GetYaxis()->SetTitleOffset(0.5);
    pH->Draw("COLZTEXT");
    TText tt;
    tt.SetTextColor(kBlack);
    tt.SetTextAngle(90);
    tt.DrawText(25.2,0,"Hz");
    tt.SetTextAngle(0);
    tt.SetTextColor(kRed);
    tt.SetTextSize(0.08);
    tt.DrawTextNDC(0.41,0.92,"DISC SCALERS");

    gPad->SetLogz(1);
    gPad->SetGrid(1,1);
    gPad->SetLeftMargin(0.05);
    gStyle->SetGridStyle(1);
    gStyle->SetGridColor(kGray);

    int x = -23;
    for(int n = 1; n <= 46; n++)
    {
        pH->GetXaxis()->SetBinLabel(n,Form("%d", x));
        x++;
        if(x == 0) x++;
    }

    memset(hpsdsc2_crate_slot_scalers, 0, sizeof(hpsdsc2_crate_slot_scalers));
    memset(hpsdsc2_crate_slot_ref, 0xFF, sizeof(hpsdsc2_crate_slot_ref));

    if(connect_to_server() < 0) DoExit();
    if(get_crate_map() < 0) DoExit();

    SetWindowName("ECAL DSC2 SCALERS");
    MapSubwindows();
    Resize();
    MapWindow();

    TTimer::SingleShot(SCALER_UPDATE_PERIOD, "hps_scalers_dsc2_app", this, "refresh_scalers()");
}

void hps_scalers_dsc2_app_run(bool accumulate=0)
{
    new hps_scalers_dsc2_app(gClient->GetRoot(), 1500, 500, accumulate);
}

