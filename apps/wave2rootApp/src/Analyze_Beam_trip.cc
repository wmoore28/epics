#include <TH1D.h>
#include <TH2D.h>
#include <TFile.h>
#include <TTree.h>
#include <TMath.h>
#include <TMath.h>
#include <TGraph.h>
#include <iostream>
#include <TCanvas.h>
#include <TRandom.h>
#include <TTimeStamp.h>

#include <fstream>

using namespace std;

struct scaler_record
{
  Long64_t record_tsec;
  Long64_t record_nsec;
  //Float_t record_data[2048];
  Float_t record_data[60000];
};

int main( int argc, char** argv )
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


  const int n_trees = 4;  // number of trees in the file
  const int n_max_graphi_points = 200000; 
  const int buf_size = 60000;
  const int n_train_groups = n_max_graphi_points/60000;
  const int n_for_averaging = 200; // Will calculate average rates of the 1st n_for_averaging events
  const int NSA = 200; // number of buffer readings befor the suspecious event
  const int NSB = 200; // number of buffer readings after the suspecious event
  const double dwel = 15000./1.e9;
  const double min_av_rate = 10; // We assume that average rate on counters should be higher than this number

  TRandom *rand1 = new TRandom();

  TTimeStamp t_stamp;

  string tree_names_[n_trees] = {"struckDaq_copy_0", "struckDaq_copy_1", "struckDaq_copy_2", "struckDaq_copy_3"};

  TFile *file_in = new TFile(Form("/usr/clas12/hps/DATA/waveforms/%s", file_name.c_str()), "Read");
  TFile *file_out = new TFile(Form("skim_%s",file_name.c_str() ), "Recreate");

    // Define tree variables
  TBranch *br_record;
  Long64_t tsec, tnsec;
  double data[buf_size];

  scaler_record record;

  TTree *tr1_[n_trees];

  
  // Lets loop over trees, one tree is one channel of Struk Scaler
  for( int i = 0; i < n_trees; i++ )
    {
      cout<<"Preocessing Tree "<<i<<endl;
      tr1_[i] = (TTree*)file_in->Get(Form("%s", tree_names_[i].c_str()));
      tr1_[i]->SetBranchAddress("record", &record.record_tsec,  &br_record);

      int nev = tr1_[i]->GetEntries();   // Number of entries for that particular Scaler channel
                                         // One tree event represent one Buffer (train) with a size buf_size
      
      double average_rate = 0;
      double average_sigma = 0;
      for( int jentry = 0; jentry < nev; jentry++ )
	{
	  tr1_[i]->GetEntry(jentry);
	  
	  TTimeStamp rootTS( (time_t)record.record_tsec,  (Int_t)record.record_nsec );
	  
	  Double_t sec = rootTS.GetSec();
	  Double_t nanosec = rootTS.GetNanoSec();
	  
	  // =============== Simulate Beam trip ===================
	  if( i == 2 && jentry < 10 )
	  {
	    cout<<"Simulating Beam tripp for event "<<jentry<<endl;
	    for( int i_buf = 0; i_buf < buf_size; i_buf++ )
	      {
		double mc_count = rand1->Gaus(45, sqrt(45.));
		if( i_buf > 4125 && i_buf <  4130)
		  {
		    mc_count = rand1->Gaus((45. + 45*(i_buf - 4125)), sqrt(45.));
		  }
		else if (i_buf > 9915 && i_buf < 15120)
		  {
		    mc_count = 0.;
		  }
		record.record_data[i_buf] = mc_count;
	      }
	  }
	  
	  
	  // get Average rate using 1st n_for_averaging events
	  if( jentry%500 == 0 || jentry == 10) // Rafresh average rate values every 500 events
	    {
	      for( int ii_av = 0; ii_av < n_for_averaging; ii_av++ )
		{
		  // To make sure that there is a beam, consecuently there will be some counts
		  if( record.record_data[ii_av] > 2 )
		    {
		      average_rate = average_rate + record.record_data[ii_av];
		    }
		}
	      average_rate = average_rate/double(n_for_averaging);
	      average_sigma = sqrt(average_rate);
	    }
	  

	  int i_trip = 0; // just a counter that will calculate trpis in the this train
	  // ========== Loop over the buffer ==================
	  for( int i_buf = 0; i_buf < buf_size; i_buf++ )
	    {
	      double counts = record.record_data[i_buf];
	      double counts_1bef = record.record_data[TMath::Max(0, i_buf - 1)];  // counts of previous index in the buffer
	      double counts_2bef = record.record_data[TMath::Max(0, i_buf - 2)];  // counts of 2 index before in the buffer
	      double counts_1aft = record.record_data[TMath::Min(buf_size - 1, i_buf + 1)];  // counts of previous index in the buffer
	      double counts_2aft = record.record_data[TMath::Min(buf_size - 1, i_buf + 2)];  // counts of 2 index before in the buffer

	      //if (i == 2 && jentry < 10) {cout<<"counts = "<<counts<<endl;}
	      // =========== This is suspeciouse events, Wee can write events from i_buf - NSB to i_buf + NSB
	      if(average_rate > min_av_rate)
		{
		  
		  if( (counts < (average_rate - 4*average_sigma) || counts > (average_rate + 4*average_sigma)) && 
		      ( counts_1bef > (average_rate - 4*average_sigma) && counts_1bef < (average_rate + 4*average_sigma) ) &&
		      ( counts_2bef > (average_rate - 4*average_sigma) && counts_2bef < (average_rate + 4*average_sigma) ) )
		    {
		      cout<<" Potential Beam trip:   Average rate = "<<average_rate<<"   counts = "<<counts<<"   buffer index = "<<i_buf<<"    jentry = "<<jentry<<"    i = "<<i<<endl;
		      cout<<"counts 1 bef = "<<counts_1bef<<"   counts 2bef = "<<counts_2bef<<endl;
		      TGraph *gr1 = new TGraph();
		      gr1->SetMarkerStyle(24);
		      gr1->SetMarkerSize(0.15);
		      gr1->SetMarkerColor(4);
		      int i_point = 0;
		      for( int i_skim = TMath::Max(0, i_buf - NSB); i_skim < TMath::Min(buf_size, i_buf + NSA); i_skim++ )
			{
			  gr1->SetPoint(i_point, sec + nanosec + dwel*i_skim, record.record_data[i_skim] );
			  i_point = i_point + 1;
			}
		      gr1->Write(Form("gr_%d_%d_%d", i, jentry, i_trip)); // The scaler channel, buffer number, and the trip number in the current buffer
		      i_trip = i_trip + 1;
		      i_buf = i_buf + NSA + 1;
		    }
		}
	      else  // Some potential scenario when 1st counts are close to 0, but during the beam trip these counters show high rates
		{
		  if( counts > min_av_rate )
		    {
		      TGraph *gr1 = new TGraph();
		      int i_point = 0;
		      for( int i_skim = TMath::Max(0, i_buf - NSB); i_skim < TMath::Min(0, i_buf + NSA); i_skim++ )
			{
			  gr1->SetPoint(i_point, sec + nanosec + dwel*i_skim, record.record_data[i_skim] );
			}
		      gr1->Write(Form("gr_%d_%d_%d", i, jentry, i_trip)); // The scaler channel, buffer number, and the trip number in the current buffer*
		      i_trip = i_trip + 1;
		    }
		}
	    }
	}
      
    }
}
