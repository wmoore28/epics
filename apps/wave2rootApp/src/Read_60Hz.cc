#include <TH1D.h>
#include <TH2D.h>
#include <TFile.h>
#include <TTree.h>
#include <TGraph.h>
#include <iostream>
#include <TCanvas.h>
#include <TTimeStamp.h>

#include <fstream>

using namespace std;

struct scaler_record
{
  Long64_t record_tsec;
  Long64_t record_nsec;
  Float_t record_data[2048];
};

int main(int argc, char** argv)
{

  string file_name;
  if( argc == 2 )
    {
      file_name = argv[1];
    }
  else
    {
      cout<<"Please specify file_name"<<endl;
      cout<<"The program is exiting"<<endl;
      exit(1);
    }

  const int n_trees = 14;  // number of trees in the file
  const int buf_size = 2048;

  TCanvas *c1 = new TCanvas("c1", "", 2000, 1000);

  TTimeStamp t_stamp;

  string tree_names_[n_trees] = {"sixtyHz_raw_0", "sixtyHz_raw_1", "sixtyHz_raw_2", "sixtyHz_raw_3", "sixtyHz_raw_6", "sixtyHz_raw_7", "sixtyHz_raw_8", "sixtyHz_raw_9", "sixtyHz_raw_10", "sixtyHz_raw_11", "sixtyHz_raw_12", "sixtyHz_raw_13", "sixtyHz_raw_14", "sixtyHz_raw_15"};

  TFile *file_in = new TFile(Form("/usr/clas12/hps/DATA/waveforms/%s", file_name.c_str()), "Read");

  // Define tree variables
  TBranch *br_record;
  Long64_t tsec, tnsec;
  double data[buf_size];

  scaler_record record;

  TTree *tr1_[n_trees];

  TGraph *gr_60Hz_[n_trees];

  // Initialize trees

  ofstream out_dat("test_log.dat"); // just test log file, will be removed, when code is defined working
  for(int i = 0; i < n_trees; i++)
    {
      cout<<"Preocessing Tree "<<i<<endl;
      tr1_[i] = (TTree*)file_in->Get(Form("%s", tree_names_[i].c_str()));
      tr1_[i]->SetBranchAddress("record", &record.record_tsec,  &br_record);
      gr_60Hz_[i] = new TGraph();

      int nev = tr1_[i]->GetEntries();   // NUmber of entries for that particular Scaler channel

      //Long64_t t0 = 0;
      Double_t t0 = 0;
      for( int jentry = 0; jentry < nev; jentry++ )
	{
	  tr1_[i]->GetEntry(jentry);
	  
	  TTimeStamp rootTS( (time_t)record.record_tsec,  (Int_t)record.record_nsec );

	  //cout<<cur_t<<endl;
	  // cout <<" at " << rootTS.AsString("lc") << endl;
	  // cout<<"nanosec "<<rootTS.GetNanoSec()<<endl;
	  // cout<<"sec = "<<rootTS.GetSec()<<endl;
	  
	  Double_t sec = rootTS.GetSec();
	  Double_t nanosec = rootTS.GetNanoSec();
	  
	  Double_t cur_t = sec + nanosec/1.e9;

	  if( jentry == 0 )
	    {
	      t0 = sec + nanosec/1.e9;
	    }

	  for( int jj = 0; jj < buf_size; jj++ )
	    {
	      gr_60Hz_[i]->SetPoint(jentry*buf_size + jj, cur_t - t0 + 4500000.*Double_t(jj)/1.e9, record.record_data[jj] ); // 10 ns is juts an arbitrary number for now
	      if( i == 13 )
		{
		  //out_dat<<record.record_data[jj]<<"   time is "<<t_stamp.AsString()<<endl;
		}
	    }
	}
    }

  gr_60Hz_[12]->SetMarkerStyle(24);
  gr_60Hz_[12]->SetMarkerColor(4);
  gr_60Hz_[12]->SetMarkerSize(0.1);
  gr_60Hz_[12]->SetTitle("sixtyHz_raw_14; t - t0 (sec); counts");
  gr_60Hz_[12]->Draw("AP");
  c1->Print("sixtyHz_raw_14_vs_time.eps");
  c1->Print("sixtyHz_raw_14_vs_time.pdf");
  c1->Print("sixtyHz_raw_14_vs_time.gif");

  return 0;
}
