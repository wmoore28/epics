#include <TApplication.h> 
#include <TGClient.h> 
#include <TCanvas.h>  
#include <TF1.h>
#include <TH1D.h>
#include <TMath.h>
#include <TLatex.h>
#include <TGraph.h>
#include <TGText.h>
#include <TGButton.h> 
#include <TRootEmbeddedCanvas.h>
#include <TGFrame.h>
#include <TGLabel.h>
#include <TSpectrum.h>
#include <TGComboBox.h>
#include <TGDimension.h>
#include <TGTextEntry.h>
#include <TGFileDialog.h>
#include <TGNumberEntry.h>
#include <TGTextEdit.h>
#include "Fitter.h" 

using namespace std;

const string Fitter::all_harps_dir = "/home/epics/DATA/HARP_SCANS/";

double* Calc_abalpha(double, double, double );
double Arnes_Corr(double , double );

Fitter::Fitter(const TGWindow *p,UInt_t w,UInt_t h, string fname)
{
  // Initialize Counter Names=============
  counter_names_[0] = "FCup";
  counter_names_[1] = "Upstream Left";
  counter_names_[2] = "Upstream Right";
  counter_names_[3] = "Tagger Left";
  counter_names_[4] = "Tagger Right";
  counter_names_[5] = "Tagger Top";
  counter_names_[6] = "Downstream Left";
  counter_names_[7] = "Downstream Right";
  counter_names_[8] = "Downstream Top";
  counter_names_[9] = "Downstream Bottom";
  counter_names_[10] = "HPS Left";
  counter_names_[11] = "HPS Right";
  counter_names_[12] = "HPS T";
  counter_names_[13] = "HPS SC";
  counter_names_[14] = "Empty";
  //===========================================

  //========= Allocate Momory for Fit Parameters =======

  pars_bgr_1st_peak = new double[3]; pars_A_1st_peak = new double[3]; pars_mean_1st_peak =new double[3]; pars_sigm_1st_peak = new double[3]; 
  range_1st_peak = new double[2]; 
  pars_bgr_2nd_peak = new double[3]; pars_A_2nd_peak = new double[3]; pars_mean_2nd_peak =new double[3]; pars_sigm_2nd_peak = new double[3]; 
  range_2nd_peak = new double[2]; 
  pars_bgr_3rd_peak = new double[3]; pars_A_3rd_peak = new double[3]; pars_mean_3rd_peak =new double[3]; pars_sigm_3rd_peak = new double[3]; 
  range_3rd_peak = new double[2]; 
  f_1st_peak = new TF1("f_1st_peak", "[0]*TMath::Gaus(x, [1], [2]) + [3]"); f_1st_peak->SetNpx(2500);
  f_2nd_peak = new TF1("f_2nd_peak", "[0]*TMath::Gaus(x, [1], [2]) + [3]"); f_2nd_peak->SetNpx(2500);
  f_3rd_peak = new TF1("f_3rd_peak", "[0]*TMath::Gaus(x, [1], [2]) + [3]"); f_3rd_peak->SetNpx(2500);

  preview_mode = false;

  // Create a main frame
  fMain = new TGMainFrame(p,w,h, kHorizontalFrame);
  // Create canvas widget 
  fEcanvas = new TRootEmbeddedCanvas("Ecanvas",fMain,700,900); 
  
  TGVerticalFrame *vframe = new TGVerticalFrame(fMain,200,40);
  TGTextButton *open_file = new TGTextButton(vframe, "&Choose a File");
  open_file->Connect("Clicked()", "Fitter", this, "OpenFile()");
  vframe->AddFrame(open_file, new TGLayoutHints(kLHintsCenterX,5,5,3,4));

  TGTextButton *data_view = new TGTextButton(vframe, "&View Data from All counters");
  data_view->Connect("Clicked()", "Fitter", this, "Draw_All_Counters()");
  vframe->AddFrame(data_view, new TGLayoutHints(kLHintsCenterX,5,5,3,4));

  counters_box = new TGComboBox(vframe, "Choose a counter to Fit");
  counters_box->SetSize( TGDimension( 140, 20) );
  counters_box->SetEditable(false);
  for( int i = 0; i < n_counters - 1; i++ )
    {
      counters_box->AddEntry(counter_names_[i].c_str(), i);
    }
  
  vframe->AddFrame(counters_box, new TGLayoutHints(kLHintsCenterX,1,1,1,1));

  TGTextButton *fit_data = new TGTextButton(vframe, "&Fit Data");
  fit_data->Connect("Clicked()", "Fitter", this, "FitData( =false, false )");
  vframe->AddFrame(fit_data, new TGLayoutHints(kLHintsCenterX,1,1,1,1));

  TGTextButton *to_log = new TGTextButton(vframe, "Submit to Logbook");
  to_log->Connect("Clicked()", "Fitter", this, "GetComments()");
  vframe->AddFrame(to_log, new TGLayoutHints(kLHintsCenterX,1,1,1,1));

  TGTextButton *fit_pars = new TGTextButton(vframe, "Set Fit Initial Parameters");
  fit_pars->Connect("Clicked()", "Fitter", this, "Set_Fit_Pars()");
  vframe->AddFrame(fit_pars, new TGLayoutHints(kLHintsCenterX,1,1,1,1));
  
  TGTextButton *b_to_MYA = new TGTextButton(vframe, "&Send parameters to MYA");
  b_to_MYA->Connect("Clicked()", "Fitter", this, "CAPUT()");
  vframe->AddFrame(b_to_MYA, new TGLayoutHints(kLHintsCenterX,1,1,1,1));

  TGTextButton *exit = new TGTextButton(vframe,"&Exit", "gApplication->Terminate(0)"); 
  vframe->AddFrame(exit, new TGLayoutHints(kLHintsCenterX,1,1,1,1));

  fMain->AddFrame(vframe,new TGLayoutHints(kLHintsTop,2,2,2,2) );
  fMain->AddFrame(fEcanvas, new TGLayoutHints(kLHintsExpandX| kLHintsExpandY,
                                              2,2,2,2));
  fMain->SetWindowName("Fitter Window"); 
  // Map all subwindows of main frame 
  fMain->MapSubwindows(); 
  // Initialize the layout algorithm 
  fMain->Resize(fMain->GetDefaultSize()); 
  // Map main frame 
  fMain->MapWindow();
  
  InitData( all_harps_dir+"/"+fname);
}

Fitter::~Fitter() 
{   // Clean up used widgets: frames, buttons, layouthints
  fMain->Cleanup(); 
  delete fMain;  } 

void Fitter::InitData( string fname )
{
  cout<<"Initializing Data File "<<fname<<endl;
  file_name = fname;

  fit_2c21 = false;
  fit_tagger = false;
  fit_2H02A = false;
  
  if(file_name.find("2c21") > 2 && file_name.find("2c21") < 50)
    {
      fit_2c21 = true;
      harp_name = "harp_2c21";
    }
  else if(file_name.find("tagger") > 2 && file_name.find("tagger") < 50)
    {
      fit_tagger = true;
      harp_name = "harp_tagger";
    }
  else if( file_name.find("2H02A") > 2 && file_name.find("2H02A") < 50)
    {
      fit_2H02A = true;
      harp_name = "harp_2H02A";
    }
  
  cout<<"fit_tagger = "<<fit_tagger<<endl;

  gr_[0] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %lg");
  gr_[1] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %lg");
  gr_[2] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %lg");
  gr_[3] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %lg");
  gr_[4] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %lg");
  gr_[5] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %lg");
  gr_[6] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[7] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[8] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[9] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[10] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[11] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[12] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[13] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
  gr_[14] = new TGraph(Form("%s", fname.c_str() ), "%lg %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %lg");
}

void Fitter::Draw_All_Counters()
{
  TLatex *lat1 = new TLatex();
  lat1->SetNDC();
  TCanvas *c1 = new TCanvas("c_Data_View", "", 600, 1200);
  c1->Divide(1, n_counters - 1);
  lat1->SetTextSize(0.35);
  for( int i = 0; i < n_counters - 1; i++ )
    {
      c1->cd(i+1)->SetTopMargin(0.);
      c1->cd(i+1)->SetRightMargin(0.);
      c1->cd(i+1)->SetLeftMargin(0.2);
      gr_[i]->SetMarkerStyle(23);
      gr_[i]->SetMarkerSize(0.2);
      gr_[i]->SetMarkerColor(2);
      gr_[i]->Draw("AP");
      lat1->DrawLatex(0.01, 0.45, Form("%s", counter_names_[i].c_str()));
    }
}

void Fitter::OpenFile()
{
  const char *filetypes[] = {"Text Files", "*.txt", 0, 0};
  file_info.fFileTypes = filetypes;
  file_info.fIniDir  = StrDup("/home/epics/DATA/HARP_SCANS/");

  //  cout<<"Before choosing a file, the file_name is "<<file_info.fFilename<<endl;
  TGFileDialog *dialog = new TGFileDialog(gClient->GetDefaultRoot(), gClient->GetDefaultRoot(),
					  kFDOpen, &file_info);
  // File should be already choosen here...
  //cout<<"After choosing a file, the file_name is "<<file_info.fFilename<<endl;
  //cout<<"ComboBox Selected index is "<<counters_box->GetSelected()<<endl;
  
  if( file_info.fFilename )
    {
      InitData( file_info.fFilename );
    }
}

void Fitter::FitData( bool manual_fit, bool preview )
{
  preview_mode = preview;
  if( counters_box->GetSelected() >= 0 )
    {
      int counter_ind = counters_box->GetSelected();
      
      bool good_parameters = true;
      if( manual_fit )
	{
	  pars_bgr_1st_peak[0] = First_peak_bgr->GetNumber(); pars_bgr_1st_peak[1] = First_peak_bgr_min->GetNumber(); pars_bgr_1st_peak[2] = First_peak_bgr_max->GetNumber();
	  pars_A_1st_peak[0] = First_peak_A->GetNumber(); pars_A_1st_peak[1] = First_peak_A_min->GetNumber(); pars_A_1st_peak[2] = First_peak_A_max->GetNumber();
	  pars_mean_1st_peak[0] = First_peak_mean->GetNumber(); pars_mean_1st_peak[1] = First_peak_mean_min->GetNumber(); pars_mean_1st_peak[2] = First_peak_mean_max->GetNumber();
	  pars_sigm_1st_peak[0] = First_peak_sigm->GetNumber(); pars_sigm_1st_peak[1] = First_peak_sigm_min->GetNumber(); pars_sigm_1st_peak[2] = First_peak_sigm_max->GetNumber();
	  range_1st_peak[0] = First_peak_range_min->GetNumber(); range_1st_peak[1] = First_peak_range_max->GetNumber();
	  
	  pars_bgr_2nd_peak[0] = Second_peak_bgr->GetNumber(); pars_bgr_2nd_peak[1] = Second_peak_bgr_min->GetNumber(); pars_bgr_2nd_peak[2] = Second_peak_bgr_max->GetNumber();
	  pars_A_2nd_peak[0] = Second_peak_A->GetNumber(); pars_A_2nd_peak[1] = Second_peak_A_min->GetNumber(); pars_A_2nd_peak[2] = Second_peak_A_max->GetNumber();
	  pars_mean_2nd_peak[0] = Second_peak_mean->GetNumber(); pars_mean_2nd_peak[1] = Second_peak_mean_min->GetNumber(); pars_mean_2nd_peak[2] = Second_peak_mean_max->GetNumber();
	  pars_sigm_2nd_peak[0] = Second_peak_sigm->GetNumber(); pars_sigm_2nd_peak[1] = Second_peak_sigm_min->GetNumber(); pars_sigm_2nd_peak[2] = Second_peak_sigm_max->GetNumber();
	  range_2nd_peak[0] = Second_peak_range_min->GetNumber(); range_2nd_peak[1] = Second_peak_range_max->GetNumber();

	  if( fit_tagger || fit_2H02A )
	    {
	      pars_bgr_3rd_peak[0] = Third_peak_bgr->GetNumber(); pars_bgr_3rd_peak[1] = Third_peak_bgr_min->GetNumber(); pars_bgr_3rd_peak[2] = Third_peak_bgr_max->GetNumber();
	      pars_A_3rd_peak[0] = Third_peak_A->GetNumber(); pars_A_3rd_peak[1] = Third_peak_A_min->GetNumber(); pars_A_3rd_peak[2] = Third_peak_A_max->GetNumber();
	      pars_mean_3rd_peak[0] = Third_peak_mean->GetNumber(); pars_mean_3rd_peak[1] = Third_peak_mean_min->GetNumber(); pars_mean_3rd_peak[2] = Third_peak_mean_max->GetNumber();
	      pars_sigm_3rd_peak[0] = Third_peak_sigm->GetNumber(); pars_sigm_3rd_peak[1] = Third_peak_sigm_min->GetNumber(); pars_sigm_3rd_peak[2] = Third_peak_sigm_max->GetNumber();
	      range_3rd_peak[0] = Third_peak_range_min->GetNumber(); range_3rd_peak[1] = Third_peak_range_max->GetNumber();
	    }
	}
      else
	{
	  if( fit_2c21 ) { good_parameters = Search_2c21_peaks( gr_[counter_ind]); }
	  else if( fit_tagger ) { good_parameters = Search_three_peaks( gr_[counter_ind]);}
	  else if( fit_2H02A )  { good_parameters = Search_three_peaks( gr_[counter_ind]);}
	}
      
      if( good_parameters )
	{
	  if( fit_2c21 )
	    {
	      Fit_2c21(gr_[counter_ind], counter_names_[counter_ind]);
	    }
	  else if( fit_tagger )
	    {
	      Fit_tagger(gr_[counter_ind], counter_names_[counter_ind]);
	    }
	  else if( fit_2H02A )
	    {
	      Fit_2H02A(gr_[counter_ind], counter_names_[counter_ind]);
	    }
	}
      else
	{
	  TCanvas *c1 = fEcanvas->GetCanvas();
	  c1->Clear();
	  c1->cd();
	  
	  gr_[counter_ind]->SetMarkerColor(2);
	  gr_[counter_ind]->SetMarkerStyle(20);
	  gr_[counter_ind]->SetMarkerSize(0.45);
	  gr_[counter_ind]->Draw("AP");
	  c1->Update();
	}
      
    }
  preview_mode = false;
}

void RunFitter( string fname )
{
  // Popup the GUI... 
  new Fitter(gClient->GetRoot(),400,400, fname);
}

int main(int argc, char **argv) {

  if( argc ==1 )
    {
      cout<<"PLease specify at least the harp_name"<<endl;
      cout<<"The program is exiting"<<endl;
      exit(1);
    }

  TApplication theApp("App",&argc,argv);
  RunFitter( argv[1]);
  theApp.Run();
  return 0;
}

void Fitter::SubmitToLogbook()
{
  TCanvas *c1 = (TCanvas*)fEcanvas->GetCanvas();
  
  comments->GetText()->Save("/usr/tmp/Log_comments.txt");

  std::size_t pos = file_name.find(harp_name);
  std::size_t pos_end = file_name.find(".txt");
  string file_endpart = file_name.substr(pos + harp_name.size() + 1, pos_end - pos - harp_name.size() - 1);
  
  string dump_img_name = "/home/hpsrun/screenshots/fit_"+file_endpart+".gif";
  
  c1->Print(Form("%s", dump_img_name.c_str()));
  
  system(Form("/site/ace/certified/apps/bin/logentry -l TLOG -t \" Scan of %s \" -a %s -b \"/usr/tmp/Log_comments.txt\" ",
	      harp_name.c_str(), dump_img_name.c_str()));
  fMain_log->CloseWindow();
}

void Fitter::GetComments()
{
  cout<<"Kuku"<<endl;
  fMain_log = new TGMainFrame(gClient->GetRoot(), 400, 150, kVerticalFrame);
  comments = new TGTextEdit(fMain_log, 400, 150);
  comments->SetText(new TGText("Comments"));
  fMain_log->AddFrame(comments, new TGLayoutHints(kLHintsExpandX| kLHintsExpandY, 2,2,2,2) );

  TGTextButton *submit = new TGTextButton(fMain_log, "&Submit");
  submit->Connect("Clicked()", "Fitter", this, "SubmitToLogbook()");
  fMain_log->AddFrame(submit, new TGLayoutHints(kLHintsBottom,2,2,2,2));

  fMain_log->SetWindowName("Sumit to Logbook"); 
  // Map all subwindows of main frame 
  fMain_log->MapSubwindows();
  // Initialize the layout algorithm 
  fMain_log->Resize(fMain_log->GetDefaultSize()); 
  // Map main frame 
  fMain_log->MapWindow();
}

void Fitter::Set_Fit_Pars()
{
  TGMainFrame *f_Main_FitPars = new TGMainFrame(gClient->GetRoot(), 100, 100, kVerticalFrame);
  TGCompositeFrame *f_1st_peak_bgr = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_1st_peak_bgr = new TGLabel(f_1st_peak_bgr, "1st peak, bgr:             value");
  f_1st_peak_bgr->AddFrame(lbl_1st_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_bgr = new TGNumberEntry(f_1st_peak_bgr, 1., 10);
  First_peak_bgr->SetLimitValues(0., 1.e7);
  f_1st_peak_bgr->AddFrame(First_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_1st_peak_bgr_min = new TGLabel(f_1st_peak_bgr, "       min");
  f_1st_peak_bgr->AddFrame(lbl_1st_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_bgr_min = new TGNumberEntry(f_1st_peak_bgr, 0., 10);
  f_1st_peak_bgr->AddFrame(First_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_1st_peak_bgr_max = new TGLabel(f_1st_peak_bgr, "       max");
  f_1st_peak_bgr->AddFrame(lbl_1st_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_bgr_max = new TGNumberEntry(f_1st_peak_bgr, 1000000., 10);
  f_1st_peak_bgr->AddFrame(First_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_1st_peak_A = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_1st_peak_A = new TGLabel(f_1st_peak_A, "1st peak, Amplitude:    value");
  f_1st_peak_A->AddFrame(lbl_1st_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_A = new TGNumberEntry(f_1st_peak_A, 1., 10);
  First_peak_A->SetLimitValues(0., 1.e7);
  f_1st_peak_A->AddFrame(First_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_1st_peak_A_min = new TGLabel(f_1st_peak_A, "       min");
  f_1st_peak_A->AddFrame(lbl_1st_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_A_min = new TGNumberEntry(f_1st_peak_A, 0., 10);
  f_1st_peak_A->AddFrame(First_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_1st_peak_A_max = new TGLabel(f_1st_peak_A, "       max");
  f_1st_peak_A->AddFrame(lbl_1st_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_A_max = new TGNumberEntry(f_1st_peak_A, 1000000., 10);
  f_1st_peak_A->AddFrame(First_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_1st_peak_mean = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_1st_peak_mean = new TGLabel(f_1st_peak_mean, "1st peak, mean:          value");
  f_1st_peak_mean->AddFrame(lbl_1st_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_mean = new TGNumberEntry(f_1st_peak_mean, 25., 10);
  First_peak_mean->SetLimitValues(0., 1.e7);
  f_1st_peak_mean->AddFrame(First_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_1st_peak_mean_min = new TGLabel(f_1st_peak_mean, "       min");
  f_1st_peak_mean->AddFrame(lbl_1st_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_mean_min = new TGNumberEntry(f_1st_peak_mean, 0., 10);
  f_1st_peak_mean->AddFrame(First_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_1st_peak_mean_max = new TGLabel(f_1st_peak_mean, "       max");
  f_1st_peak_mean->AddFrame(lbl_1st_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_mean_max = new TGNumberEntry(f_1st_peak_mean, 60., 10);
  f_1st_peak_mean->AddFrame(First_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));


  TGCompositeFrame *f_1st_peak_sigm = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_1st_peak_sigm = new TGLabel(f_1st_peak_sigm, "1st peak, sigm:           value");
  f_1st_peak_sigm->AddFrame(lbl_1st_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_sigm = new TGNumberEntry(f_1st_peak_sigm, 0.1, 10);
  First_peak_sigm->SetLimitValues(0., 1.e7);
  f_1st_peak_sigm->AddFrame(First_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_1st_peak_sigm_min = new TGLabel(f_1st_peak_sigm, "       min");
  f_1st_peak_sigm->AddFrame(lbl_1st_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_sigm_min = new TGNumberEntry(f_1st_peak_sigm, 0., 10);
  f_1st_peak_sigm->AddFrame(First_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_1st_peak_sigm_max = new TGLabel(f_1st_peak_sigm, "       max");
  f_1st_peak_sigm->AddFrame(lbl_1st_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  First_peak_sigm_max = new TGNumberEntry(f_1st_peak_sigm, 1., 10);
  f_1st_peak_sigm->AddFrame(First_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  //  TGHorizontalFrame *f_buttons =            new TGHorizontalFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );
  TGHorizontalFrame *f_1st_peak_Fit_Range = new TGHorizontalFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );
  TGLabel *lbl_1st_peak_Fit_Range_min = new TGLabel(f_1st_peak_Fit_Range, "1st Peak Fit Range:        min");
  f_1st_peak_Fit_Range->AddFrame(lbl_1st_peak_Fit_Range_min);
  First_peak_range_min = new TGNumberEntry(f_1st_peak_Fit_Range, 5., 10);
  f_1st_peak_Fit_Range->AddFrame(First_peak_range_min,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));

  TGLabel *lbl_1st_peak_Fit_Range_max = new TGLabel(f_1st_peak_Fit_Range, "      max:");
  f_1st_peak_Fit_Range->AddFrame(lbl_1st_peak_Fit_Range_max);
  First_peak_range_max = new TGNumberEntry(f_1st_peak_Fit_Range, 25., 10);
  f_1st_peak_Fit_Range->AddFrame(First_peak_range_max,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));
  

  TGCompositeFrame *f_2nd_peak_bgr = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_2nd_peak_bgr = new TGLabel(f_2nd_peak_bgr, "2nd peak, bgr:            value");
  f_2nd_peak_bgr->AddFrame(lbl_2nd_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_bgr = new TGNumberEntry(f_2nd_peak_bgr, 1., 10);
  Second_peak_bgr->SetLimitValues(0., 1.e7);
  f_2nd_peak_bgr->AddFrame(Second_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_2nd_peak_bgr_min = new TGLabel(f_2nd_peak_bgr, "       min");
  f_2nd_peak_bgr->AddFrame(lbl_2nd_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_bgr_min = new TGNumberEntry(f_2nd_peak_bgr, 0., 10);
  f_2nd_peak_bgr->AddFrame(Second_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_2nd_peak_bgr_max = new TGLabel(f_2nd_peak_bgr, "       max");
  f_2nd_peak_bgr->AddFrame(lbl_2nd_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_bgr_max = new TGNumberEntry(f_2nd_peak_bgr, 1000000., 10);
  f_2nd_peak_bgr->AddFrame(Second_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_2nd_peak_A = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_2nd_peak_A = new TGLabel(f_2nd_peak_A, "2nd peak, Amplitude:   value");
  f_2nd_peak_A->AddFrame(lbl_2nd_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_A = new TGNumberEntry(f_2nd_peak_A, 1., 10);
  Second_peak_A->SetLimitValues(0., 1.e7);
  f_2nd_peak_A->AddFrame(Second_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_2nd_peak_A_min = new TGLabel(f_2nd_peak_A, "       min");
  f_2nd_peak_A->AddFrame(lbl_2nd_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_A_min = new TGNumberEntry(f_2nd_peak_A, 0., 10);
  f_2nd_peak_A->AddFrame(Second_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_2nd_peak_A_max = new TGLabel(f_2nd_peak_A, "       max");
  f_2nd_peak_A->AddFrame(lbl_2nd_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_A_max = new TGNumberEntry(f_2nd_peak_A, 1000000., 10);
  f_2nd_peak_A->AddFrame(Second_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_2nd_peak_mean = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_2nd_peak_mean = new TGLabel(f_2nd_peak_mean, "2nd peak, mean:         value");
  f_2nd_peak_mean->AddFrame(lbl_2nd_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_mean = new TGNumberEntry(f_2nd_peak_mean, 45., 10);
  Second_peak_mean->SetLimitValues(0., 1.e7);
  f_2nd_peak_mean->AddFrame(Second_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_2nd_peak_mean_min = new TGLabel(f_2nd_peak_mean, "       min");
  f_2nd_peak_mean->AddFrame(lbl_2nd_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_mean_min = new TGNumberEntry(f_2nd_peak_mean, 0., 10);
  f_2nd_peak_mean->AddFrame(Second_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_2nd_peak_mean_max = new TGLabel(f_2nd_peak_mean, "       max");
  f_2nd_peak_mean->AddFrame(lbl_2nd_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_mean_max = new TGNumberEntry(f_2nd_peak_mean, 70., 10);
  f_2nd_peak_mean->AddFrame(Second_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  TGCompositeFrame *f_2nd_peak_sigm = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_2nd_peak_sigm = new TGLabel(f_2nd_peak_sigm, "2nd peak, sigm:          value");
  f_2nd_peak_sigm->AddFrame(lbl_2nd_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_sigm = new TGNumberEntry(f_2nd_peak_sigm, 0.1, 10);
  Second_peak_sigm->SetLimitValues(0., 1.e7);
  f_2nd_peak_sigm->AddFrame(Second_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_2nd_peak_sigm_min = new TGLabel(f_2nd_peak_sigm, "       min");
  f_2nd_peak_sigm->AddFrame(lbl_2nd_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_sigm_min = new TGNumberEntry(f_2nd_peak_sigm, 0., 10);
  f_2nd_peak_sigm->AddFrame(Second_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_2nd_peak_sigm_max = new TGLabel(f_2nd_peak_sigm, "       max");
  f_2nd_peak_sigm->AddFrame(lbl_2nd_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Second_peak_sigm_max = new TGNumberEntry(f_2nd_peak_sigm, 1., 10);
  f_2nd_peak_sigm->AddFrame(Second_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));


  TGHorizontalFrame *f_2nd_peak_Fit_Range = new TGHorizontalFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );
  TGLabel *lbl_2nd_peak_Fit_Range_min = new TGLabel(f_2nd_peak_Fit_Range, "2nd Peak Fit Range:        min");
  f_2nd_peak_Fit_Range->AddFrame(lbl_2nd_peak_Fit_Range_min);
  Second_peak_range_min = new TGNumberEntry(f_2nd_peak_Fit_Range, 25., 10);
  f_2nd_peak_Fit_Range->AddFrame(Second_peak_range_min,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));

  TGLabel *lbl_2nd_peak_Fit_Range_max = new TGLabel(f_2nd_peak_Fit_Range, "      max:");
  f_2nd_peak_Fit_Range->AddFrame(lbl_2nd_peak_Fit_Range_max);
  Second_peak_range_max = new TGNumberEntry(f_2nd_peak_Fit_Range, 45., 10);
  f_2nd_peak_Fit_Range->AddFrame(Second_peak_range_max,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));


  TGCompositeFrame *f_3rd_peak_bgr = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_3rd_peak_bgr = new TGLabel(f_3rd_peak_bgr, "3rd peak, bgr:            value");
  f_3rd_peak_bgr->AddFrame(lbl_3rd_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_bgr = new TGNumberEntry(f_3rd_peak_bgr, 1., 10);
  Third_peak_bgr->SetLimitValues(0., 1.e7);
  f_3rd_peak_bgr->AddFrame(Third_peak_bgr, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_3rd_peak_bgr_min = new TGLabel(f_3rd_peak_bgr, "       min");
  f_3rd_peak_bgr->AddFrame(lbl_3rd_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_bgr_min = new TGNumberEntry(f_3rd_peak_bgr, 0., 10);
  f_3rd_peak_bgr->AddFrame(Third_peak_bgr_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_3rd_peak_bgr_max = new TGLabel(f_3rd_peak_bgr, "       max");
  f_3rd_peak_bgr->AddFrame(lbl_3rd_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_bgr_max = new TGNumberEntry(f_3rd_peak_bgr, 1000000., 10);
  f_3rd_peak_bgr->AddFrame(Third_peak_bgr_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_3rd_peak_A = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_3rd_peak_A = new TGLabel(f_3rd_peak_A, "3rd peak, Amplitude:   value");
  f_3rd_peak_A->AddFrame(lbl_3rd_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_A = new TGNumberEntry(f_3rd_peak_A, 1., 10);
  Third_peak_A->SetLimitValues(0., 1.e7);
  f_3rd_peak_A->AddFrame(Third_peak_A, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_3rd_peak_A_min = new TGLabel(f_3rd_peak_A, "       min");
  f_3rd_peak_A->AddFrame(lbl_3rd_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_A_min = new TGNumberEntry(f_3rd_peak_A, 0., 10);
  f_3rd_peak_A->AddFrame(Third_peak_A_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_3rd_peak_A_max = new TGLabel(f_3rd_peak_A, "       max");
  f_3rd_peak_A->AddFrame(lbl_3rd_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_A_max = new TGNumberEntry(f_3rd_peak_A, 1000000., 10);
  f_3rd_peak_A->AddFrame(Third_peak_A_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGCompositeFrame *f_3rd_peak_mean = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_3rd_peak_mean = new TGLabel(f_3rd_peak_mean, "3rd peak, mean:         value");
  f_3rd_peak_mean->AddFrame(lbl_3rd_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_mean = new TGNumberEntry(f_3rd_peak_mean, 65., 10);
  Third_peak_mean->SetLimitValues(0., 1.e7);
  f_3rd_peak_mean->AddFrame(Third_peak_mean, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_3rd_peak_mean_min = new TGLabel(f_3rd_peak_mean, "       min");
  f_3rd_peak_mean->AddFrame(lbl_3rd_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_mean_min = new TGNumberEntry(f_3rd_peak_mean, 45., 10);
  f_3rd_peak_mean->AddFrame(Third_peak_mean_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_3rd_peak_mean_max = new TGLabel(f_3rd_peak_mean, "       max");
  f_3rd_peak_mean->AddFrame(lbl_3rd_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_mean_max = new TGNumberEntry(f_3rd_peak_mean, 95., 10);
  f_3rd_peak_mean->AddFrame(Third_peak_mean_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  TGCompositeFrame *f_3rd_peak_sigm = new TGCompositeFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGLabel *lbl_3rd_peak_sigm = new TGLabel(f_3rd_peak_sigm, "3rd peak, sigm:          value");
  f_3rd_peak_sigm->AddFrame(lbl_3rd_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_sigm = new TGNumberEntry(f_3rd_peak_sigm, 0.1, 10);
  Third_peak_sigm->SetLimitValues(0., 1.e7);
  f_3rd_peak_sigm->AddFrame(Third_peak_sigm, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  
  TGLabel *lbl_3rd_peak_sigm_min = new TGLabel(f_3rd_peak_sigm, "       min");
  f_3rd_peak_sigm->AddFrame(lbl_3rd_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_sigm_min = new TGNumberEntry(f_3rd_peak_sigm, 0., 10);
  f_3rd_peak_sigm->AddFrame(Third_peak_sigm_min, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGLabel *lbl_3rd_peak_sigm_max = new TGLabel(f_3rd_peak_sigm, "       max");
  f_3rd_peak_sigm->AddFrame(lbl_3rd_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));
  Third_peak_sigm_max = new TGNumberEntry(f_3rd_peak_sigm, 1., 10);
  f_3rd_peak_sigm->AddFrame(Third_peak_sigm_max, new TGLayoutHints(kLHintsLeft,2,2,2,2));

  TGHorizontalFrame *f_3rd_peak_Fit_Range = new TGHorizontalFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );
  TGLabel *lbl_3rd_peak_Fit_Range_min = new TGLabel(f_3rd_peak_Fit_Range, "3rd Peak Fit Range:        min");
  f_3rd_peak_Fit_Range->AddFrame(lbl_3rd_peak_Fit_Range_min);
  Third_peak_range_min = new TGNumberEntry(f_3rd_peak_Fit_Range, 5., 10);
  f_3rd_peak_Fit_Range->AddFrame(Third_peak_range_min,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));

  TGLabel *lbl_3rd_peak_Fit_Range_max = new TGLabel(f_3rd_peak_Fit_Range, "      max:");
  f_3rd_peak_Fit_Range->AddFrame(lbl_3rd_peak_Fit_Range_max);
  Third_peak_range_max = new TGNumberEntry(f_3rd_peak_Fit_Range, 25., 10);
  f_3rd_peak_Fit_Range->AddFrame(Third_peak_range_max,  new TGLayoutHints(kLHintsCenterX,2,2,2,2));


  f_Main_FitPars->AddFrame(f_1st_peak_bgr, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_1st_peak_A, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_1st_peak_mean, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_1st_peak_sigm, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_1st_peak_Fit_Range, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_2nd_peak_bgr, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_2nd_peak_A, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_2nd_peak_mean, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_2nd_peak_sigm, new TGLayoutHints(kLHintsTop,2,2,2,2));
  f_Main_FitPars->AddFrame(f_2nd_peak_Fit_Range, new TGLayoutHints(kLHintsTop,2,2,2,2));

  if( fit_tagger || fit_2H02A )
    {
      f_Main_FitPars->AddFrame(f_3rd_peak_bgr, new TGLayoutHints(kLHintsTop,2,2,2,2));
      f_Main_FitPars->AddFrame(f_3rd_peak_A, new TGLayoutHints(kLHintsTop,2,2,2,2));
      f_Main_FitPars->AddFrame(f_3rd_peak_mean, new TGLayoutHints(kLHintsTop,2,2,2,2));
      f_Main_FitPars->AddFrame(f_3rd_peak_sigm, new TGLayoutHints(kLHintsTop,2,2,2,2));
      f_Main_FitPars->AddFrame(f_3rd_peak_Fit_Range, new TGLayoutHints(kLHintsTop,2,2,2,2)); 
    }
  TGHorizontalFrame *f_buttons = new TGHorizontalFrame(f_Main_FitPars, 70, 4, kHorizontalFrame );

  TGTextButton *b_load_pars = new TGTextButton(f_buttons, "  &Load Parameters from Fit  ");
  b_load_pars->Connect("Clicked()", "Fitter", this, "Load_Fit_Pars()");
  f_buttons->AddFrame(b_load_pars, new TGLayoutHints(kLHintsCenterX,2,2,2,2));

  TGTextButton *b_Preview = new TGTextButton(f_buttons, " &Preview ");
  b_Preview->Connect("Clicked()", "Fitter", this, "FitData(=true, true)");
  f_buttons->AddFrame(b_Preview, new TGLayoutHints(kLHintsCenterX,2,2,2,2));

  TGTextButton *b_Fit = new TGTextButton(f_buttons, "    &Fit    ");
  b_Fit->Connect("Clicked()", "Fitter", this, "FitData(=true, false)");
  f_buttons->AddFrame(b_Fit, new TGLayoutHints(kLHintsCenterX,2,2,2,2));


  f_Main_FitPars->AddFrame(f_buttons, new TGLayoutHints(kLHintsCenterX,2,2,2,2));


  f_Main_FitPars->SetWindowName("Set Fit Parameters Manualy"); 
  // Map all subwindows of main frame 
  f_Main_FitPars->MapSubwindows();
  // Initialize the layout algorithm 
  f_Main_FitPars->Resize(f_Main_FitPars->GetDefaultSize()); 
  // Map main frame 
  f_Main_FitPars->MapWindow();

}

void Fitter::Load_Fit_Pars()
{
  First_peak_bgr->SetNumber(f_1st_peak->GetParameter(3));
  First_peak_A->SetNumber(f_1st_peak->GetParameter(0));
  First_peak_mean->SetNumber(f_1st_peak->GetParameter(1));
  First_peak_sigm->SetNumber(f_1st_peak->GetParameter(2));
  First_peak_range_min->SetNumber(f_1st_peak->GetParameter(1) - 2.);
  First_peak_range_max->SetNumber(f_1st_peak->GetParameter(1) + 2.);
  
  Second_peak_bgr->SetNumber(f_2nd_peak->GetParameter(3));
  Second_peak_A->SetNumber(f_2nd_peak->GetParameter(0));
  Second_peak_mean->SetNumber(f_2nd_peak->GetParameter(1));
  Second_peak_sigm->SetNumber(f_2nd_peak->GetParameter(2));
  Second_peak_range_min->SetNumber(f_2nd_peak->GetParameter(1) - 2.);
  Second_peak_range_max->SetNumber(f_2nd_peak->GetParameter(1) + 2.);

  if( fit_tagger || fit_2H02A )
    {
      Third_peak_bgr->SetNumber(f_3rd_peak->GetParameter(3));
      Third_peak_A->SetNumber(f_3rd_peak->GetParameter(0));
      Third_peak_mean->SetNumber(f_3rd_peak->GetParameter(1));
      Third_peak_sigm->SetNumber(f_3rd_peak->GetParameter(2));
      Third_peak_range_min->SetNumber(f_3rd_peak->GetParameter(1) - 2.);
      Third_peak_range_max->SetNumber(f_3rd_peak->GetParameter(1) + 2.);
    }

}

bool Fitter::Search_2c21_peaks(TGraph *gr)
{
  TH1D *h_gr = (TH1D*)Graph2Hist(gr, 1.); // 1 No need to convert to mm, motor position of 2c21 is already in mm

  h_gr->SetTitle("; motor pos (mm)");
  h_gr->Sumw2();
  int N_hist_bins = h_gr->GetNbinsX();

  TSpectrum *sp1 = new TSpectrum();
  
  sp1->Search(h_gr, 15., "", 0.09);

  float *peak_val_tmp = sp1->GetPositionY();
  float *pos_tmp = sp1->GetPositionX();
  int n_peaks = sp1->GetNPeaks();

  if( n_peaks != 2 )
    {
      sp1->Search(h_gr, 15., "", 0.1);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }
  if( n_peaks != 2 )
    {
      sp1->Search(h_gr, 15., "", 0.08);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }
  if( n_peaks != 2 )
    {
      sp1->Search(h_gr, 15., "", 0.06);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }

  int n_for_average = 5;
  double bgr_average;
  for( int i = 0; i < n_for_average; i++ )
    {
      bgr_average = bgr_average + h_gr->GetBinContent(i) + h_gr->GetBinContent(N_hist_bins - i - 5);
    }
  bgr_average = bgr_average/double(2*n_for_average);
  
  if( n_peaks == 2 )
    {
      TGraph *gr_peaks = new TGraph(n_peaks, pos_tmp, peak_val_tmp);
      gr_peaks->Sort();
      double *pos = gr_peaks->GetX();
      double *peak_val = gr_peaks->GetY();

      TH1D *h_gr_tmp = (TH1D*)h_gr->Clone("h_gr_tmp");

      double mean_x = pos[0];
      h_gr_tmp->SetAxisRange(mean_x - 0.8, mean_x + 0.8);
      double tmp_RMS = h_gr_tmp->GetRMS();
      double tmp_Ampl = h_gr_tmp->GetMaximum() - bgr_average;
      
      pars_bgr_1st_peak[0] = bgr_average; pars_bgr_1st_peak[1] = 0.; pars_bgr_1st_peak[2] = 10*bgr_average;
      pars_A_1st_peak[0] = tmp_Ampl; pars_A_1st_peak[1] = 0.1*tmp_Ampl; pars_A_1st_peak[2] = 1.5 *tmp_Ampl;
      pars_mean_1st_peak[0] = mean_x; pars_mean_1st_peak[1] = mean_x - 2; pars_mean_1st_peak[2] = mean_x + 2.;
      pars_sigm_1st_peak[0] = tmp_RMS; pars_sigm_1st_peak[1] = 0.001*tmp_RMS; pars_sigm_1st_peak[2] = 100*tmp_RMS;
      range_1st_peak[0] = mean_x - 3.5; range_1st_peak[1] = mean_x + 3.5;

      mean_x = pos[1];
      h_gr_tmp->SetAxisRange(mean_x - 0.8, mean_x + 0.8);
      tmp_RMS = h_gr_tmp->GetRMS();
      tmp_Ampl = h_gr_tmp->GetMaximum() - bgr_average;
      
      pars_bgr_2nd_peak[0] = bgr_average; pars_bgr_2nd_peak[1] = 0.; pars_bgr_2nd_peak[2] = 10*bgr_average;
      pars_A_2nd_peak[0] = tmp_Ampl; pars_A_2nd_peak[1] = 0.1*tmp_Ampl; pars_A_2nd_peak[2] = 1.5 *tmp_Ampl;
      pars_mean_2nd_peak[0] = mean_x; pars_mean_2nd_peak[1] = mean_x - 2; pars_mean_2nd_peak[2] = mean_x + 2.;
      pars_sigm_2nd_peak[0] = tmp_RMS; pars_sigm_2nd_peak[1] = 0.001*tmp_RMS; pars_sigm_2nd_peak[2] = 100*tmp_RMS;
      range_2nd_peak[0] = mean_x - 3.5; range_2nd_peak[1] = mean_x + 3.5;

      return true;
      
      delete h_gr_tmp;
    }
  else
    {
      return false;
    }

}


bool Fitter::Search_three_peaks(TGraph *gr)
{
  
    TH1D *h_gr;
    
    if( fit_tagger )
      {
	h_gr = (TH1D*)Graph2Hist(gr, 1.); // 1 No need to convert to mm, motor position of 2c21 is already in mm
      }
    else if( fit_2H02A )
      {
	h_gr = (TH1D*)Graph2Hist(gr, 10.); // 10 is because 2H02A has motor position im cm, it should be converted into mm
      }


  h_gr->SetTitle("; motor pos (mm)");
  h_gr->Sumw2();
  int N_hist_bins = h_gr->GetNbinsX();

  TSpectrum *sp1 = new TSpectrum();
  
  sp1->Search(h_gr, 15., "", 0.09);

  float *peak_val_tmp = sp1->GetPositionY();
  float *pos_tmp = sp1->GetPositionX();
  int n_peaks = sp1->GetNPeaks();

  if( n_peaks != 3 )
    {
      sp1->Search(h_gr, 15., "", 0.1);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }
  if( n_peaks != 3 )
    {
      sp1->Search(h_gr, 15., "", 0.08);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }
  if( n_peaks != 3 )
    {
      sp1->Search(h_gr, 15., "", 0.06);
      peak_val_tmp = sp1->GetPositionY();
      pos_tmp = sp1->GetPositionX();
      n_peaks = sp1->GetNPeaks();
    }

  int n_for_average = 5;
  double bgr_average;
  for( int i = 0; i < n_for_average; i++ )
    {
      bgr_average = bgr_average + h_gr->GetBinContent(i) + h_gr->GetBinContent(N_hist_bins - i - 5);
    }
  bgr_average = bgr_average/double(2*n_for_average);
  
  if( n_peaks == 3 )
    {
      TGraph *gr_peaks = new TGraph(n_peaks, pos_tmp, peak_val_tmp);
      gr_peaks->Sort();
      double *pos = gr_peaks->GetX();
      double *peak_val = gr_peaks->GetY();

      TH1D *h_gr_tmp = (TH1D*)h_gr->Clone("h_gr_tmp");

      double mean_x = pos[0];
      h_gr_tmp->SetAxisRange(mean_x - 0.8, mean_x + 0.8);
      double tmp_RMS = h_gr_tmp->GetRMS();
      double tmp_Ampl = h_gr_tmp->GetMaximum() - bgr_average;
      
      pars_bgr_1st_peak[0] = bgr_average; pars_bgr_1st_peak[1] = 0.; pars_bgr_1st_peak[2] = 10*bgr_average;
      pars_A_1st_peak[0] = tmp_Ampl; pars_A_1st_peak[1] = 0.1*tmp_Ampl; pars_A_1st_peak[2] = 1.5 *tmp_Ampl;
      pars_mean_1st_peak[0] = mean_x; pars_mean_1st_peak[1] = mean_x - 2; pars_mean_1st_peak[2] = mean_x + 2.;
      pars_sigm_1st_peak[0] = tmp_RMS; pars_sigm_1st_peak[1] = 0.001*tmp_RMS; pars_sigm_1st_peak[2] = 100*tmp_RMS;
      range_1st_peak[0] = mean_x - 3.5; range_1st_peak[1] = mean_x + 3.5;

      mean_x = pos[1];
      h_gr_tmp->SetAxisRange(mean_x - 0.8, mean_x + 0.8);
      tmp_RMS = h_gr_tmp->GetRMS();
      tmp_Ampl = h_gr_tmp->GetMaximum() - bgr_average;
      
      pars_bgr_2nd_peak[0] = bgr_average; pars_bgr_2nd_peak[1] = 0.; pars_bgr_2nd_peak[2] = 10*bgr_average;
      pars_A_2nd_peak[0] = tmp_Ampl; pars_A_2nd_peak[1] = 0.1*tmp_Ampl; pars_A_2nd_peak[2] = 1.5 *tmp_Ampl;
      pars_mean_2nd_peak[0] = mean_x; pars_mean_2nd_peak[1] = mean_x - 2; pars_mean_2nd_peak[2] = mean_x + 2.;
      pars_sigm_2nd_peak[0] = tmp_RMS; pars_sigm_2nd_peak[1] = 0.001*tmp_RMS; pars_sigm_2nd_peak[2] = 100*tmp_RMS;
      range_2nd_peak[0] = mean_x - 3.5; range_2nd_peak[1] = mean_x + 3.5;

      mean_x = pos[2];
      h_gr_tmp->SetAxisRange(mean_x - 0.8, mean_x + 0.8);
      tmp_RMS = h_gr_tmp->GetRMS();
      tmp_Ampl = h_gr_tmp->GetMaximum() - bgr_average;
      
      pars_bgr_3rd_peak[0] = bgr_average; pars_bgr_3rd_peak[1] = 0.; pars_bgr_3rd_peak[2] = 10*bgr_average;
      pars_A_3rd_peak[0] = tmp_Ampl; pars_A_3rd_peak[1] = 0.1*tmp_Ampl; pars_A_3rd_peak[2] = 1.5 *tmp_Ampl;
      pars_mean_3rd_peak[0] = mean_x; pars_mean_3rd_peak[1] = mean_x - 2; pars_mean_3rd_peak[2] = mean_x + 2.;
      pars_sigm_3rd_peak[0] = tmp_RMS; pars_sigm_3rd_peak[1] = 0.001*tmp_RMS; pars_sigm_3rd_peak[2] = 100*tmp_RMS;
      range_3rd_peak[0] = mean_x - 3.5; range_3rd_peak[1] = mean_x + 3.5;
      
      return true;
      
      delete h_gr_tmp;
    }
  else
    {
      return false;
    }

}

bool Fitter::Fit_2c21(TGraph *gr, string counter_name)
{
  TLatex *lat1 = new TLatex();
  lat1->SetNDC();
  
  TCanvas *c1 = fEcanvas->GetCanvas();
  c1->Clear();

  h_1st_peak = (TH1D*)Graph2Hist(gr, 1.); // 1 No need to convert to mm, motor position of 2c21 is already in mm
  h_1st_peak->SetTitle("; motor pos (mm)");
  h_1st_peak->Sumw2();

  h_2nd_peak = (TH1D*)h_1st_peak->Clone("h_2nd_peak");
    
  h_1st_peak->SetAxisRange(range_1st_peak[0], range_1st_peak[1], "X");
  f_1st_peak->SetParLimits(0, pars_A_1st_peak[1], pars_A_1st_peak[2]);
  f_1st_peak->SetParLimits(1, pars_mean_1st_peak[1], pars_mean_1st_peak[2]);
  f_1st_peak->SetParLimits(2, pars_sigm_1st_peak[1], pars_sigm_1st_peak[2]);
  f_1st_peak->SetParLimits(3, pars_bgr_1st_peak[1], pars_bgr_1st_peak[2]);
  f_1st_peak->SetParameters(pars_A_1st_peak[0], pars_mean_1st_peak[0], pars_sigm_1st_peak[0], pars_bgr_1st_peak[0]);
  
  h_2nd_peak->SetAxisRange(range_2nd_peak[0], range_2nd_peak[1], "X");
  f_2nd_peak->SetParLimits(0, pars_A_2nd_peak[1], pars_A_2nd_peak[2]);
  f_2nd_peak->SetParLimits(1, pars_mean_2nd_peak[1], pars_mean_2nd_peak[2]);
  f_2nd_peak->SetParLimits(2, pars_sigm_2nd_peak[1], pars_sigm_2nd_peak[2]);
  f_2nd_peak->SetParLimits(3, pars_bgr_2nd_peak[1], pars_bgr_2nd_peak[2]);
  f_2nd_peak->SetParameters(pars_A_2nd_peak[0], pars_mean_2nd_peak[0], pars_sigm_2nd_peak[0], pars_bgr_2nd_peak[0]);

  int n_peaks = 2;
  cout<<"Npeaks = "<<n_peaks<<endl;

  if( n_peaks == 2 )
    {
      c1->Clear();
      c1->Divide(1, n_peaks);
       
      string wire_names_[2] = {"x", "y"};
      double mean_[n_peaks];
      double sigm_[n_peaks];
      double bgr_[n_peaks];
      double peak_val_[n_peaks];
      
      c1->cd(1)->SetLogy();
      
      if( preview_mode )
	{
	  h_1st_peak->Draw();
	  f_1st_peak->SetRange(range_1st_peak[0], range_1st_peak[1]);
	  f_1st_peak->Draw("Same");
	}
      else
	{
	  h_1st_peak->Fit(f_1st_peak, "+MeV", "", range_1st_peak[0], range_1st_peak[1]);
	  
	  mean_[0] = f_1st_peak->GetParameter(1)/sqrt(2.);
	  sigm_[0] = f_1st_peak->GetParameter(2)/sqrt(2.);
	  sigm_[0] = sigm_[0]/Arnes_Corr(sigm_[0], 0.025);
	  
	  bgr_[0] = f_1st_peak->GetParameter(3);
	  peak_val_[0] = f_1st_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: 2c21   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[0].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[0]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[0]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[0]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[0]/peak_val_[0]));
	}


      c1->cd(2)->SetLogy();
      
      if( preview_mode )
	{
	  h_2nd_peak->Draw();
	  f_2nd_peak->SetRange(range_2nd_peak[0], range_2nd_peak[1]);
	  f_2nd_peak->Draw("Same");
	}
      else
	{
	  h_2nd_peak->Fit(f_2nd_peak, "+MeV", "", range_2nd_peak[0], range_2nd_peak[1]);
	  
	  mean_[1] = f_2nd_peak->GetParameter(1)/sqrt(2.);
	  sigm_[1] = f_2nd_peak->GetParameter(2)/sqrt(2.);
	  sigm_[1] = sigm_[1]/Arnes_Corr(sigm_[1], 0.025);
	  
	  bgr_[1] = f_2nd_peak->GetParameter(3);
	  peak_val_[1] = f_2nd_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: 2c21   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[1].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[1]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[1]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[1]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[1]/peak_val_[1]));
	}

      //f_GPol0_[i]->DrawCopy("Same");
      
      
      
      //  Usually data from this counter is better, data from this counter wil go into MYA
// 	  if( counter_name == "Upstream_Left" )
// 	    {
// 	      system(Form("caput HB_BEAM:SCAN:2c21:mean_%s %1.5f", wire_names_[i].c_str(), mean_[i]));
// 	      system(Form("caput HB_BEAM:SCAN:2c21:sigma_%s %1.5f", wire_names_[i].c_str(), sigm_[i]));
// 	      system(Form("caput HB_BEAM:SCAN:2c21:bgr_peak_ratio_%s %1.7f", wire_names_[i].c_str(), bgr_[i]/peak_val[i]));
// 	      system(Form("caput HB_BEAM:SCAN:2c21:peak_%s %1.5f", wire_names_[i].c_str(), peak_val[i]));
// 	    }
	
      c1->Update();
      c1->cd(1);
      lat1->SetTextSize(0.03);
      //lat1->DrawLatex(0.02, 0.97, Form("%s/%s", all_harp_dir.c_str(), glob_filename.c_str()));

      return true;
    }

}

bool Fitter::Fit_tagger(TGraph *gr, string counter_name)
{
  TLatex *lat1 = new TLatex();
  lat1->SetNDC();
  
  TCanvas *c1 = fEcanvas->GetCanvas();
  c1->Clear();

  h_1st_peak = (TH1D*)Graph2Hist(gr, 1.); // 1 No need to convert to mm, motor position of 2c21 is already in mm
  h_1st_peak->SetTitle("; motor pos (mm)");
  h_1st_peak->Sumw2();

  h_2nd_peak = (TH1D*)h_1st_peak->Clone("h_2nd_peak");
  h_3rd_peak = (TH1D*)h_1st_peak->Clone("h_3nd_peak");
    
  h_1st_peak->SetAxisRange(range_1st_peak[0], range_1st_peak[1], "X");
  f_1st_peak->SetParLimits(0, pars_A_1st_peak[1], pars_A_1st_peak[2]);
  f_1st_peak->SetParLimits(1, pars_mean_1st_peak[1], pars_mean_1st_peak[2]);
  f_1st_peak->SetParLimits(2, pars_sigm_1st_peak[1], pars_sigm_1st_peak[2]);
  f_1st_peak->SetParLimits(3, pars_bgr_1st_peak[1], pars_bgr_1st_peak[2]);
  f_1st_peak->SetParameters(pars_A_1st_peak[0], pars_mean_1st_peak[0], pars_sigm_1st_peak[0], pars_bgr_1st_peak[0]);
  
  h_2nd_peak->SetAxisRange(range_2nd_peak[0], range_2nd_peak[1], "X");
  f_2nd_peak->SetParLimits(0, pars_A_2nd_peak[1], pars_A_2nd_peak[2]);
  f_2nd_peak->SetParLimits(1, pars_mean_2nd_peak[1], pars_mean_2nd_peak[2]);
  f_2nd_peak->SetParLimits(2, pars_sigm_2nd_peak[1], pars_sigm_2nd_peak[2]);
  f_2nd_peak->SetParLimits(3, pars_bgr_2nd_peak[1], pars_bgr_2nd_peak[2]);
  f_2nd_peak->SetParameters(pars_A_2nd_peak[0], pars_mean_2nd_peak[0], pars_sigm_2nd_peak[0], pars_bgr_2nd_peak[0]);
  
  h_3rd_peak->SetAxisRange(range_3rd_peak[0], range_3rd_peak[1], "X");
  f_3rd_peak->SetParLimits(0, pars_A_3rd_peak[1], pars_A_3rd_peak[2]);
  f_3rd_peak->SetParLimits(1, pars_mean_3rd_peak[1], pars_mean_3rd_peak[2]);
  f_3rd_peak->SetParLimits(2, pars_sigm_3rd_peak[1], pars_sigm_3rd_peak[2]);
  f_3rd_peak->SetParLimits(3, pars_bgr_3rd_peak[1], pars_bgr_3rd_peak[2]);
  f_3rd_peak->SetParameters(pars_A_3rd_peak[0], pars_mean_3rd_peak[0], pars_sigm_3rd_peak[0], pars_bgr_3rd_peak[0]);
  
  int n_peaks = 3;

  cout<<"Npeaks = "<<n_peaks<<endl;

  if( n_peaks == 3 )
    {

      c1->Clear();
      c1->Divide(1, n_peaks);
       
      string wire_names_[3] = {"45", "y", "x"};
      double mean_[n_peaks];
      double sigm_[n_peaks];
      double bgr_[n_peaks];
      double peak_val_[n_peaks];
      
      c1->cd(1)->SetLogy();

      if( preview_mode )
	{
	  h_1st_peak->Draw();
	  f_1st_peak->SetRange(range_1st_peak[0], range_1st_peak[1]);
	  f_1st_peak->Draw("Same");
	}
      else
	{
	  h_1st_peak->Fit(f_1st_peak, "+MeV", "", range_1st_peak[0], range_1st_peak[1]);
	  
	  mean_[0] = f_1st_peak->GetParameter(1);
	  sigm_[0] = f_1st_peak->GetParameter(2);
	  sigm_[0] = sigm_[0]/Arnes_Corr(sigm_[0], 0.025);
	  
	  bgr_[0] = f_1st_peak->GetParameter(3);
	  peak_val_[0] = f_1st_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: tagger   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[0].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[0]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[0]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[0]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[0]/peak_val_[0]));
	}


      c1->cd(2)->SetLogy();
      
      if( preview_mode )
	{
	  h_2nd_peak->Draw();
	  f_2nd_peak->SetRange(range_2nd_peak[0], range_2nd_peak[1]);
	  f_2nd_peak->Draw("Same");
	}
      else
	{
	  h_2nd_peak->Fit(f_2nd_peak, "+MeV", "", range_2nd_peak[0], range_2nd_peak[1]);
	  
	  mean_[1] = f_2nd_peak->GetParameter(1)/sqrt(2.);
	  sigm_[1] = f_2nd_peak->GetParameter(2)/sqrt(2.);
	  sigm_[1] = sigm_[1]/Arnes_Corr(sigm_[1], 0.025);
	  
	  bgr_[1] = f_2nd_peak->GetParameter(3);
	  peak_val_[1] = f_2nd_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: tagger   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[1].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[1]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[1]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[1]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[1]/peak_val_[1]));
	}


      c1->cd(3)->SetLogy();
      
      if( preview_mode )
	{
	  h_3rd_peak->Draw();
	  f_3rd_peak->SetRange(range_3rd_peak[0], range_3rd_peak[1]);
	  f_3rd_peak->Draw("Same");
	}
      else
	{
	  h_3rd_peak->Fit(f_3rd_peak, "+MeV", "", range_3rd_peak[0], range_3rd_peak[1]);
	  
	  mean_[2] = f_3rd_peak->GetParameter(1)/sqrt(2.);
	  sigm_[2] = f_3rd_peak->GetParameter(2)/sqrt(2.);
	  sigm_[2] = sigm_[2]/Arnes_Corr(sigm_[2], 0.025);
	  
	  bgr_[2] = f_3rd_peak->GetParameter(3);
	  peak_val_[2] = f_3rd_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: tagger   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[2].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[2]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[2]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[2]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[2]/peak_val_[2]));
	}

      double *alpha_a_b = Calc_abalpha(sigm_[0], sigm_[2]*TMath::Sqrt(2.), sigm_[1]*TMath::Sqrt(2.));
      
      alpha = alpha_a_b[0];
      aa = alpha_a_b[1]/TMath::Sqrt(2.);
      bb = alpha_a_b[2]/TMath::Sqrt(2.);

      c1->cd(1);
      lat1->DrawLatex(0.7, 0.85, Form("#alpha = %1.2f deg", alpha));
      lat1->DrawLatex(0.7, 0.8, Form("a = %1.2f", aa));
      lat1->DrawLatex(0.7, 0.75, Form("b = %1.2f", bb));
      lat1->SetTextSize(0.04);
      lat1->DrawLatex(0.1, 0.97, Form("%s", file_name.c_str()));
      
      c1->cd();
      c1->Update();

//       if( counter_name == "tagger_right" )
// 	{
// 	  system(Form("caput HB_BEAM:SCAN:tagger:alpha %1.5f", alpha));
// 	  system(Form("caput HB_BEAM:SCAN:tagger:a %1.5f", aa));
// 	  system(Form("caput HB_BEAM:SCAN:tagger:b %1.7f", bb));
// 	}

      // ============= Now Let's Save the file for the Log Entry ===============
      
      return true;
    }
  
}

bool Fitter::Fit_2H02A(TGraph *gr, string counter_name)
{
  TLatex *lat1 = new TLatex();
  lat1->SetNDC();
  
  TCanvas *c1 = fEcanvas->GetCanvas();
  c1->Clear();

  h_1st_peak = (TH1D*)Graph2Hist(gr, 10.); // 10 is because 2H02A has motor position in cm, it should be converted into mm
  h_1st_peak->SetTitle("; motor pos (mm)");
  h_1st_peak->Sumw2();

  h_2nd_peak = (TH1D*)h_1st_peak->Clone("h_2nd_peak");
  h_3rd_peak = (TH1D*)h_1st_peak->Clone("h_3nd_peak");
    
  h_1st_peak->SetAxisRange(range_1st_peak[0], range_1st_peak[1], "X");
  f_1st_peak->SetParLimits(0, pars_A_1st_peak[1], pars_A_1st_peak[2]);
  f_1st_peak->SetParLimits(1, pars_mean_1st_peak[1], pars_mean_1st_peak[2]);
  f_1st_peak->SetParLimits(2, pars_sigm_1st_peak[1], pars_sigm_1st_peak[2]);
  f_1st_peak->SetParLimits(3, pars_bgr_1st_peak[1], pars_bgr_1st_peak[2]);
  f_1st_peak->SetParameters(pars_A_1st_peak[0], pars_mean_1st_peak[0], pars_sigm_1st_peak[0], pars_bgr_1st_peak[0]);
  
  h_2nd_peak->SetAxisRange(range_2nd_peak[0], range_2nd_peak[1], "X");
  f_2nd_peak->SetParLimits(0, pars_A_2nd_peak[1], pars_A_2nd_peak[2]);
  f_2nd_peak->SetParLimits(1, pars_mean_2nd_peak[1], pars_mean_2nd_peak[2]);
  f_2nd_peak->SetParLimits(2, pars_sigm_2nd_peak[1], pars_sigm_2nd_peak[2]);
  f_2nd_peak->SetParLimits(3, pars_bgr_2nd_peak[1], pars_bgr_2nd_peak[2]);
  f_2nd_peak->SetParameters(pars_A_2nd_peak[0], pars_mean_2nd_peak[0], pars_sigm_2nd_peak[0], pars_bgr_2nd_peak[0]);
  
  h_3rd_peak->SetAxisRange(range_3rd_peak[0], range_3rd_peak[1], "X");
  f_3rd_peak->SetParLimits(0, pars_A_3rd_peak[1], pars_A_3rd_peak[2]);
  f_3rd_peak->SetParLimits(1, pars_mean_3rd_peak[1], pars_mean_3rd_peak[2]);
  f_3rd_peak->SetParLimits(2, pars_sigm_3rd_peak[1], pars_sigm_3rd_peak[2]);
  f_3rd_peak->SetParLimits(3, pars_bgr_3rd_peak[1], pars_bgr_3rd_peak[2]);
  f_3rd_peak->SetParameters(pars_A_3rd_peak[0], pars_mean_3rd_peak[0], pars_sigm_3rd_peak[0], pars_bgr_3rd_peak[0]);
  
  int n_peaks = 3;

  cout<<"Npeaks = "<<n_peaks<<endl;

  if( n_peaks == 3 )
    {

      c1->Clear();
      c1->Divide(1, n_peaks);
       
      string wire_names_[3] = {"x", "y", "45"};
      double mean_[n_peaks];
      double sigm_[n_peaks];
      double bgr_[n_peaks];
      double peak_val_[n_peaks];
      
      c1->cd(1)->SetLogy();

      if( preview_mode )
	{
	  h_1st_peak->Draw();
	  f_1st_peak->SetRange(range_1st_peak[0], range_1st_peak[1]);
	  f_1st_peak->Draw("Same");
	}
      else
	{
	  h_1st_peak->Fit(f_1st_peak, "+MeV", "", range_1st_peak[0], range_1st_peak[1]);
	  
	  mean_[0] = f_1st_peak->GetParameter(1)/sqrt(2.);
	  sigm_[0] = f_1st_peak->GetParameter(2)/sqrt(2.);
	  sigm_[0] = sigm_[0]/Arnes_Corr(sigm_[0], 0.025);
	  
	  bgr_[0] = f_1st_peak->GetParameter(3);
	  peak_val_[0] = f_1st_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: 2H02A   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[0].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[0]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[0]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[0]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[0]/peak_val_[0]));
	}


      c1->cd(2)->SetLogy();
      
      if( preview_mode )
	{
	  h_2nd_peak->Draw();
	  f_2nd_peak->SetRange(range_2nd_peak[0], range_2nd_peak[1]);
	  f_2nd_peak->Draw("Same");
	}
      else
	{
	  h_2nd_peak->Fit(f_2nd_peak, "+MeV", "", range_2nd_peak[0], range_2nd_peak[1]);
	  
	  mean_[1] = f_2nd_peak->GetParameter(1)/sqrt(2.);
	  sigm_[1] = f_2nd_peak->GetParameter(2)/sqrt(2.);
	  sigm_[1] = sigm_[1]/Arnes_Corr(sigm_[1], 0.025);
	  
	  bgr_[1] = f_2nd_peak->GetParameter(3);
	  peak_val_[1] = f_2nd_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: 2H02A   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[1].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[1]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[1]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[1]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[1]/peak_val_[1]));
	}


      c1->cd(3)->SetLogy();
      
      if( preview_mode )
	{
	  h_3rd_peak->Draw();
	  f_3rd_peak->SetRange(range_3rd_peak[0], range_3rd_peak[1]);
	  f_3rd_peak->Draw("Same");
	}
      else
	{
	  h_3rd_peak->Fit(f_3rd_peak, "+MeV", "", range_3rd_peak[0], range_3rd_peak[1]);
	  
	  mean_[2] = f_3rd_peak->GetParameter(1);
	  sigm_[2] = f_3rd_peak->GetParameter(2);
	  sigm_[2] = sigm_[2]/Arnes_Corr(sigm_[2], 0.025);
	  
	  bgr_[2] = f_3rd_peak->GetParameter(3);
	  peak_val_[2] = f_3rd_peak->GetParameter(0);
	  
	  lat1->DrawLatex(0.15, 0.91, Form("Harp: 2H02A   Counter: %s  Wire %s ", counter_name.c_str(), wire_names_[2].c_str()));
	  lat1->DrawLatex(0.12, 0.85, Form("#mu = %1.4f mm", mean_[2]));
	  lat1->DrawLatex(0.12, 0.80, Form("#sigma = %1.4f mm", sigm_[2]));
	  lat1->DrawLatex(0.12, 0.75, Form("peak_val = %1.0f", peak_val_[2]));
	  lat1->DrawLatex(0.12, 0.70, Form("bgr/peak = %1.1e", bgr_[2]/peak_val_[2]));
	}


      double *alpha_a_b = Calc_abalpha(sigm_[2], sigm_[0]*TMath::Sqrt(2.), sigm_[1]*TMath::Sqrt(2.));
      
      alpha = alpha_a_b[0];
      aa = alpha_a_b[1]/TMath::Sqrt(2.);
      bb = alpha_a_b[2]/TMath::Sqrt(2.);

      c1->cd(1);
      lat1->DrawLatex(0.7, 0.85, Form("#alpha = %1.2f deg", alpha));
      lat1->DrawLatex(0.7, 0.8, Form("a = %1.2f", aa));
      lat1->DrawLatex(0.7, 0.75, Form("b = %1.2f", bb));
      lat1->SetTextSize(0.04);
      lat1->DrawLatex(0.1, 0.97, Form("%s", file_name.c_str()));
      
      c1->cd();
      c1->Update();

//       if( counter_name == "tagger_right" )
// 	{
// 	  system(Form("caput HB_BEAM:SCAN:tagger:alpha %1.5f", alpha));
// 	  system(Form("caput HB_BEAM:SCAN:tagger:a %1.5f", aa));
// 	  system(Form("caput HB_BEAM:SCAN:tagger:b %1.7f", bb));
// 	}

      // ============= Now Let's Save the file for the Log Entry ===============
      
      return true;
    }
  
}

TH1D* Fitter::Graph2Hist(TGraph * gr, double scale)
{
  gr->Sort();
  int n_points = gr->GetN();
  double *x_axis_tmp = gr->GetX();
  
  cout<<"n_points before "<<n_points<<endl;
  for( int i = 1; i < n_points; i++ )
    {
      //cout<<"     ================= Hop ============== x is decreasing ====== i = "<<i<<"    x = "<<x_axis_tmp[i]<<endl;
       if( x_axis_tmp[i] == x_axis_tmp[i - 1] )
 	{
 	  gr->RemovePoint(i);
 	}
    }

  n_points = gr->GetN();
  double *x_axis = gr->GetX();
  double *y_axis = gr->GetY();
  double x_axis2[n_points];
  double y_axis2[n_points];

  for( int i = 0; i < n_points; i++ )
    {
      x_axis2[i] = scale*x_axis[i];
      y_axis2[i] = y_axis[i];
    }

  double x_varbins_[n_points + 1];
  double y_varbins_[n_points + 1];
  
  cout<<"n_points after rearrangement "<<n_points<<endl;
  for( int i = 1; i < n_points; i++ )
    {
      x_varbins_[i] = (x_axis2[i-1] + x_axis2[i])/2.;
      //cout<<"x_varbins ["<<i<<"] = "<<x_varbins_[i]<<endl;
      
      if( x_varbins_[i] <= x_varbins_[i - 1] )
	{
	  cout<<"  ================= Hop ============== x is decreasing ====== i = "<<i<<"    x = "<<x_varbins_[i]<<endl;
	}
    }

  x_varbins_[0] = (x_axis2[0] - (x_axis2[1] - x_axis2[0])/2.);
  x_varbins_[n_points] = (x_axis2[n_points - 1] + (x_axis2[n_points - 1] - x_axis2[n_points - 2])/2.);
  
  cout<<"x_varbins ["<<0<<"] = "<<x_varbins_[0]<<endl;
  cout<<"x_varbins ["<<n_points<<"] = "<<x_varbins_[n_points]<<endl;

  double x_low, y_low;
  double x_high, y_high;
  double bin_width = (x_high - x_low)/double(n_points - 1);

  gr->GetPoint(0, x_low, y_low);
  gr->GetPoint(n_points - 1, x_high, y_high);

  delete h_gr_tmp;
  h_gr_tmp = new TH1D("h_gr", "", n_points , x_varbins_ );
  //TH1D *h_gr = new TH1D("h_gr", "", n_points , x_varbins_ );

  //cout<<"xlow is "<<x_low<<"    x_high is "<<x_high<<endl;

  h_gr_tmp->FillN(n_points, x_axis2, y_axis);
  h_gr_tmp->SetStats(0);
  cout<<"NbinsX = "<<h_gr_tmp->GetNbinsX()<<endl;
  
  return h_gr_tmp;
}

void Fitter::CAPUT()
{
  if( fit_2c21 )
    {
      int n_wires = 2;
      string wire_names_[2] = {"x", "y"};
      double mean_[n_wires];
      double sigm_[n_wires];
      double bgr_[n_wires];
      double peak_val_[n_wires];

      mean_[0] = f_1st_peak->GetParameter(1)/TMath::Sqrt(2.); mean_[1] = f_2nd_peak->GetParameter(1)/TMath::Sqrt(2.);
      sigm_[0] = f_1st_peak->GetParameter(2)/TMath::Sqrt(2.); sigm_[1] = f_2nd_peak->GetParameter(2)/TMath::Sqrt(2.);
      bgr_[0] = f_1st_peak->GetParameter(3); bgr_[1] = f_2nd_peak->GetParameter(3);
      peak_val_[0] = f_1st_peak->GetParameter(0); peak_val_[1] = f_2nd_peak->GetParameter(0);
      
      for( int i = 0; i < n_wires; i++ )
	{
	  system(Form("caput HB_BEAM:SCAN:2c21:mean_%s %1.5f", wire_names_[i].c_str(), mean_[i]));
	  system(Form("caput HB_BEAM:SCAN:2c21:sigma_%s %1.5f", wire_names_[i].c_str(), sigm_[i]));
	  system(Form("caput HB_BEAM:SCAN:2c21:bgr_peak_ratio_%s %1.7f", wire_names_[i].c_str(), bgr_[i]/peak_val_[i]));
	  system(Form("caput HB_BEAM:SCAN:2c21:peak_%s %1.5f", wire_names_[i].c_str(), peak_val_[i]));
	}
    }
  else if( fit_tagger )
    {
      int n_wires = 3;
      string wire_names_[3] = {"45", "y", "x"};
      double mean_[n_wires];
      double sigm_[n_wires];
      double bgr_[n_wires];
      double peak_val_[n_wires];

      mean_[0] = f_1st_peak->GetParameter(1); mean_[1] = f_2nd_peak->GetParameter(1)/TMath::Sqrt(2.); mean_[2] = f_3rd_peak->GetParameter(1)/TMath::Sqrt(2.);
      sigm_[0] = f_1st_peak->GetParameter(2); sigm_[1] = f_2nd_peak->GetParameter(2)/TMath::Sqrt(2.); sigm_[2] = f_3rd_peak->GetParameter(2)/TMath::Sqrt(2.);
      bgr_[0] = f_1st_peak->GetParameter(3); bgr_[1] = f_2nd_peak->GetParameter(3); bgr_[2] = f_3rd_peak->GetParameter(3); 
      peak_val_[0] = f_1st_peak->GetParameter(0); peak_val_[1] = f_2nd_peak->GetParameter(0); peak_val_[2] = f_3rd_peak->GetParameter(0);

      for( int i = 0; i < n_wires; i++ )
	{
	  system(Form("caput HB_BEAM:SCAN:tagger:mean_%s %1.5f", wire_names_[i].c_str(), mean_[i]));
	  system(Form("caput HB_BEAM:SCAN:tagger:sigma_%s %1.5f", wire_names_[i].c_str(), sigm_[i]));
	  system(Form("caput HB_BEAM:SCAN:tagger:bgr_peak_ratio_%s %1.7f", wire_names_[i].c_str(), bgr_[i]/peak_val_[i]));
	  system(Form("caput HB_BEAM:SCAN:tagger:peak_%s %1.5f", wire_names_[i].c_str(), peak_val_[i]));
	}
      
      system(Form("caput HB_BEAM:SCAN:tagger:alpha %1.5f", alpha));
      system(Form("caput HB_BEAM:SCAN:tagger:a %1.5f", aa));
      system(Form("caput HB_BEAM:SCAN:tagger:b %1.7f", bb));

    }
  else if( fit_2H02A )
    {
      int n_wires = 3;
      string wire_names_[3] = {"x", "y", "45"};
      double mean_[n_wires];
      double sigm_[n_wires];
      double bgr_[n_wires];
      double peak_val_[n_wires];

      mean_[0] = f_1st_peak->GetParameter(1)/TMath::Sqrt(2.); mean_[1] = f_2nd_peak->GetParameter(1)/TMath::Sqrt(2.); mean_[2] = f_3rd_peak->GetParameter(1);
      sigm_[0] = f_1st_peak->GetParameter(2)/TMath::Sqrt(2.); sigm_[1] = f_2nd_peak->GetParameter(2)/TMath::Sqrt(2.); sigm_[2] = f_3rd_peak->GetParameter(2);
      bgr_[0] = f_1st_peak->GetParameter(3); bgr_[1] = f_2nd_peak->GetParameter(3); bgr_[2] = f_3rd_peak->GetParameter(3); 
      peak_val_[0] = f_1st_peak->GetParameter(0); peak_val_[1] = f_2nd_peak->GetParameter(0); peak_val_[2] = f_3rd_peak->GetParameter(0);

      for( int i = 0; i < n_wires; i++ )
	{
	  system(Form("caput HB_BEAM:SCAN:2H02A:mean_%s %1.5f", wire_names_[i].c_str(), mean_[i]));
	  system(Form("caput HB_BEAM:SCAN:2H02A:sigma_%s %1.5f", wire_names_[i].c_str(), sigm_[i]));
	  system(Form("caput HB_BEAM:SCAN:2H02A:bgr_peak_ratio_%s %1.7f", wire_names_[i].c_str(), bgr_[i]/peak_val_[i]));
	  system(Form("caput HB_BEAM:SCAN:2H02A:peak_%s %1.5f", wire_names_[i].c_str(), peak_val_[i]));
	}
	  system(Form("caput HB_BEAM:SCAN:2H02A:alpha %1.5f", alpha));
	  system(Form("caput HB_BEAM:SCAN:2H02A:a %1.5f", aa));
	  system(Form("caput HB_BEAM:SCAN:2H02A:b %1.7f", bb));
    }

}

double* Calc_abalpha(double sigm45, double sigm_x, double sigm_y)
{
  const double radian = 57.2957795130823229;
  const double PI = 3.14159265358979312;
  double A = sigm_x*sigm_x;
  double B = sigm_y*sigm_y;
  double C = sigm45*sigm45;

  double alpha = 0.5*atan((2*C-A-B)/(B-A));
  if( A < B )
    {
      alpha = alpha + PI;
    }
  double a;
  double b;
  
  if( 0.5*(A+B+(A-B)/cos(2*alpha))<0 )
    {
      b = -1.;
    }
  else
    {
      b = sqrt(0.5*( A+B-(A-B)/cos(2*alpha)));
    }

  if( 0.5*(A+B+(A-B)/cos(2*alpha))<0 )
    {
      a = -1.;
    }
  else
    {
      a = sqrt(0.5*(A+B+(A-B)/cos(2*alpha)));
    }
  
  if( a < b )
    {
      if( alpha > 0 ) {alpha = alpha - PI/2.;}
      else {alpha = alpha + PI/2.;}

      double tmp = a;
      a = b;
      b = tmp;
    }
  
  alpha = alpha*radian;
  double alpha_a_b[3];
  alpha_a_b[0] = alpha;
  alpha_a_b[1] = a;
  alpha_a_b[2] = b;
  double *ret_values = alpha_a_b;
  
  return ret_values;
 }


double Arnes_Corr(double sigm, double wd)
{
  double corr = 1 + 0.025/TMath::Power(sigm/wd, 2.826);
  return corr;
}
