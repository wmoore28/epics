#include <TF1.h>
#include <TH1D.h>
#include <TH2D.h>
#include <stdio.h>
#include <TLine.h>
#include <iostream>
#include <TGraph.h>
#include <TLatex.h>
#include <TCanvas.h>
#include <TSpectrum.h>
#include <TApplication.h>
#include <SVTwirePosition.h>

using namespace std;

TH1D *Graph2Hist(TGraph *);
double* GetTopPos(double);
double* GetBotPos(double);

int main(int argc, char **argv)
{
  if( argc < 2 )
    {
      cout<<"Wrong launching command"<<endl;
      cout<<"Usage: ./analyze_svt_scan.exe filename"<<endl;
      cout<<"The program is exiting"<<endl;
      exit(1);
    }
  
  bool make_log = false;
  if(argc == 3)
    {
      make_log = atoi(argv[2]);
    }

  string file_name = argv[1];
  string file_dir = "/usr/clas12/hps/DATA/hps_svt_scans";
  string which_scan;
  //string file_name = "svt_bot_scan_0005.asc";

  bool bot_scan = false;
  bool top_scan = false;
  
  size_t scan_type = file_name.find("top");
  if( file_name.find("top") == 4 )
    {
      top_scan = true;
      which_scan = "top";
    }
  else if( file_name.find("bot") == 4 )
    {
      bot_scan = true;
      which_scan = "bot";
    }
  else
    {
      cout<<"The program wasn't able to determine whether it is an SVT bottom scan or top scan"<<endl;
      cout<<"Please make sure that filename is correct"<<endl;
      cout<<"The program is exiting"<<endl;
      exit(1);
    }

  const int n_graphs = 8; //number of graphs
  string graph_titles_[n_graphs] = {"HPS_L", "HPS_R", "HPS_T", "HPS_SC", "FCup_current", "2H02 X", "2H02 Y", "2H02 current"};

  TF1 *f_GPol0 = new TF1("f_GPol0", "[0]*TMath::Gaus(x, [1], [2]) + [3]", 0., 15);
  f_GPol0->SetParLimits(3, 0., 100000.);

  TF1 *f_Gaus = new TF1("f_Gaus", "[0]*TMath::Gaus(x, [1], [2])", 0., 20.);
  f_Gaus->SetLineStyle(2);
  f_Gaus->SetLineColor(96);
  f_Gaus->SetLineWidth(4);

  TLatex *lat1 = new TLatex();
  lat1->SetNDC();
  
  TLine *line1 = new TLine();
  line1->SetLineColor(2);

  TSpectrum *sp1 = new TSpectrum(10000);

  TApplication *app1 = new TApplication("", 0, NULL);

  TGraph *gr_[n_graphs];
  double si_pos_[n_graphs];
  double horiz_wire_pos_[n_graphs];
  double stereo_wire_pos_[n_graphs];
  double horiz_wire_pos_truncated_[n_graphs];
  double stereo_wire_pos_truncated_[n_graphs];
  double stage1_[n_graphs];
  double stage2_[n_graphs];
  double stage1_truncated_[n_graphs];
  double stage2_truncated_[n_graphs];

  gr_[0] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %lg");
  gr_[1] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %lg");
  gr_[2] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %lg");
  gr_[3] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %*s %lg");
  gr_[4] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %*s %*s %lg");
  gr_[5] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %*s %*s %*s %lg");
  gr_[6] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %*s %*s %*s %*s %lg");
  gr_[7] = new TGraph(Form("%s/%s", file_dir.c_str(), file_name.c_str()), "%*s %*s %lg %*s %*s %*s %*s %*s %*s %*s %lg");
  
  cout<<"Kuku"<<endl;
  TCanvas *c1 = new TCanvas("c1", "", 1200, 600);
  c1->Divide(4, 2);
    
  for( int i = 0; i < n_graphs; i++ )
    {
      c1->cd(i+1);
      gr_[i]->SetMarkerColor(4);
      gr_[i]->SetMarkerStyle(21);
      gr_[i]->SetMarkerSize(0.75);
      gr_[i]->SetTitle(Form("%s", graph_titles_[i].c_str()));
      
      gr_[i]->Draw("AP");
    }
  
  //c1->Modified();
  //c1->Update();
  TCanvas *c2 = new TCanvas("c2", "", 2000, 900);

  int n_points_[n_graphs];

  TH1D *h_gr_2 = Graph2Hist(gr_[2]); h_gr_2->SetName("h_gr_2"); h_gr_2->SetTitle("HPS_T; Motor pos. (mm)");
  TH1D *h_gr_3 = Graph2Hist(gr_[3]); h_gr_3->SetName("h_gr_3"); h_gr_3->SetTitle("HPS_SC; Motor pos. (mm)");
  
  sp1->Search(h_gr_2, 2, "", 0.2);
  float *peak_val_2 = sp1->GetPositionY();
  float *pos_2 = sp1->GetPositionX();
  int n_peaks2 = sp1->GetNPeaks();
  TF1 *f_fit_func2_[n_peaks2];

  sp1->Search(h_gr_3, 2, "", 0.2);
  float *peak_val_3 = sp1->GetPositionY();
  float *pos_3 = sp1->GetPositionX();
  int n_peaks3 = sp1->GetNPeaks();
  TF1 *f_fit_func3_[n_peaks3];

  c2->Clear(); //Looks like TSpectrum::Search, draws results, therefore let's clear the canvas 1st
  c2->Divide(3, 1);

  //================================================== Analyzing data from HPS_t ===========================================
  c2->cd(1)->SetLogy();
  c2->cd(1)->SetRightMargin(0.005);
  //gr_[2]->Draw("AP");
  
  double *mean_vals = new double[n_peaks2];
  double *mean_vals_truncated = new double[n_peaks2];
  for( int i_peak = 0; i_peak < n_peaks2; i_peak++ )
    {
      int mean_bin = h_gr_2->FindBin(pos_2[i_peak]);
      double fit_left_lim = h_gr_2->GetBinCenter(mean_bin - 4);
      double fit_right_lim = h_gr_2->GetBinCenter(mean_bin + 4);

      cout<<"pos2_["<<i_peak<<"]  = "<<pos_2[i_peak]<<endl;
      f_GPol0->SetParameters(peak_val_2[i_peak], pos_2[i_peak], 0.2);
      h_gr_2->Fit(f_GPol0, "eN", "", pos_2[i_peak] - 1.9, pos_2[i_peak] + 1.9 );
      f_fit_func2_[i_peak] = (TF1*)f_GPol0->Clone(Form("f_fit_func2_%d", i_peak));
      f_fit_func2_[i_peak]->SetLineColor(2 + 2*i_peak);
      double sigma = f_fit_func2_[i_peak]->GetParameter(2);
      f_fit_func2_[i_peak]->SetRange(pos_2[i_peak] - 5*sigma, pos_2[i_peak] + 5*sigma);
      mean_vals[i_peak] = f_fit_func2_[i_peak]->GetParameter(1);
      f_Gaus->SetParameters(h_gr_2->GetBinContent(mean_bin), pos_2[i_peak], 0.07);
      h_gr_2->Fit(f_Gaus, "+MeV", "", fit_left_lim, fit_right_lim);
      mean_vals_truncated[i_peak] = f_Gaus->GetParameter(1);
    }
  h_gr_2->Draw("E1");
  for( int i_peak = 0; i_peak < n_peaks2; i_peak++ )
    {
      f_fit_func2_[i_peak]->Draw("Same");
    }

  if( n_peaks2 == 2 )
    {
      if( mean_vals[0] < mean_vals[1] )
	{
	  stage1_[2] = mean_vals[0];
	  stage2_[2] = mean_vals[1];
	  stage1_truncated_[2] = mean_vals_truncated[0];
	  stage2_truncated_[2] = mean_vals_truncated[1];
	}
      else
	{
	  stage1_[2] = mean_vals[1];
	  stage2_[2] = mean_vals[0];
	  stage1_truncated_[2] = mean_vals_truncated[1];
	  stage2_truncated_[2] = mean_vals_truncated[0];

	}
    }

  delete mean_vals;
  delete mean_vals_truncated;
  //  line1->DrawLine(pos_x[0], 0., pos_x[0], 1.05*h_gr_2->GetMaximum());
  //  line1->DrawLine(pos_x[1], 0., pos_x[1], 1.05*h_gr_2->GetMaximum());
  //=======================================================================================================================

  //================================================== Analyzing data from HPS_sc ===========================================
  c2->cd(2)->SetLogy();
  c2->cd(2)->SetRightMargin(0.005);
  gr_[3]->Draw("AP");

  mean_vals = new double[n_peaks3];
  mean_vals_truncated = new double[n_peaks2];

  for( int i_peak = 0; i_peak < n_peaks3; i_peak++ )
    {
      int mean_bin = h_gr_3->FindBin(pos_3[i_peak]);
      double fit_left_lim = h_gr_3->GetBinCenter(mean_bin - 4);
      double fit_right_lim = h_gr_3->GetBinCenter(mean_bin + 4);

      cout<<"pos3_["<<i_peak<<"]  = "<<pos_3[i_peak]<<endl;
      f_GPol0->SetParameters(peak_val_3[i_peak], pos_3[i_peak], 0.2);
      h_gr_3->Fit(f_GPol0, "eN", "", pos_3[i_peak] - 1.9, pos_3[i_peak] + 1.9 );
      f_fit_func3_[i_peak] = (TF1*)f_GPol0->Clone(Form("f_fit_func3_%d", i_peak));
      f_fit_func3_[i_peak]->SetLineColor(2 + 2*i_peak);
      double sigma = f_fit_func3_[i_peak]->GetParameter(2);
      f_fit_func3_[i_peak]->SetRange(pos_3[i_peak] - 5*sigma, pos_3[i_peak] + 5*sigma);
      mean_vals[i_peak] = f_fit_func3_[i_peak]->GetParameter(1);
      f_Gaus->SetParameters(h_gr_3->GetBinContent(mean_bin), pos_3[i_peak], 0.07);
      h_gr_3->Fit(f_Gaus, "+MeV", "", fit_left_lim, fit_right_lim);
      mean_vals_truncated[i_peak] = f_Gaus->GetParameter(1);
    }
  h_gr_3->Draw("E1");
  for( int i_peak = 0; i_peak < n_peaks3; i_peak++ )
    {
      f_fit_func3_[i_peak]->Draw("Same");
    }
  
  if( n_peaks3 == 2 )
    {
      if( mean_vals[0] < mean_vals[1] )
	{
	  stage1_[3] = mean_vals[0];
	  stage2_[3] = mean_vals[1];
	  stage1_truncated_[3] = mean_vals_truncated[0];
	  stage2_truncated_[3] = mean_vals_truncated[1];
	}
      else
	{
	  stage1_[3] = mean_vals[1];
	  stage2_[3] = mean_vals[0];
	  stage1_truncated_[3] = mean_vals_truncated[1];
	  stage2_truncated_[3] = mean_vals_truncated[0];
	}
    }
  //=======================================================================================================================
  
  //=============== Now if the program found two peaks in any one of counters, then it will calculate beam paramaters ==================
  
  c2->cd(3);

  if( n_peaks2 == 2 )
    {
      double *positions_;
      double *positions2_;
      double *positions_truncated_;
      double *positions2_truncated_;
      SVTwirePosition svt_wire_pos(file_name);

      if( top_scan )
	{
	  positions_ = GetTopPos(stage1_[2]);
	  positions2_ = GetTopPos(stage2_[2]);
	  positions_truncated_ = GetTopPos(stage1_truncated_[2]);
	  positions2_truncated_ = GetTopPos(stage2_truncated_[2]);
	}
      else if( bot_scan)
	{
	  positions_ = GetBotPos(stage1_[2]);
	  positions2_ = GetBotPos(stage2_[2]);
	  positions_truncated_ = GetBotPos(stage1_truncated_[2]);
	  positions2_truncated_ = GetBotPos(stage2_truncated_[2]);
	}
      si_pos_[2] = positions_[0];
      horiz_wire_pos_[2] = positions_[1];
      stereo_wire_pos_[2] = positions2_[1];
      horiz_wire_pos_truncated_[2] = positions_truncated_[1];
      stereo_wire_pos_truncated_[2] = positions2_truncated_[1];

      double wire_dist = TMath::Abs(stereo_wire_pos_[2] - horiz_wire_pos_[2]);
      double beam_x = svt_wire_pos.calcXbeam(wire_dist);
      double wire_dist_truncated = TMath::Abs(stereo_wire_pos_truncated_[2] - horiz_wire_pos_truncated_[2]);
      double beam_x_truncated = svt_wire_pos.calcXbeam(wire_dist_truncated);

      lat1->DrawLatex(0.15, 0.975, Form("File: %s", file_name.c_str()));

      lat1->SetTextColor(4);
      lat1->DrawLatex(0.15, 0.93, "Analyze from HPS_t counter" );
      lat1->SetTextColor(64);
      lat1->DrawLatex(0.1, 0.89, Form("%s_mot_pos1 = %1.3f mm", which_scan.c_str(), stage1_[2]));
      lat1->DrawLatex(0.1, 0.85, Form("%s_mot_pos2 = %1.3f mm", which_scan.c_str(), stage2_[2]));
      //lat1->DrawLatex(0.1, 0.83, Form("%s_si_retracted_pos = %1.3f mm", which_scan.c_str(), si_pos_[2]));
      lat1->DrawLatex(0.1, 0.81, Form("%s_wire_dist = %1.3f mm", which_scan.c_str(), wire_dist));
      lat1->DrawLatex(0.1, 0.77, Form("%s_beam_Y = %1.3f mm", which_scan.c_str(), horiz_wire_pos_[2]));
      lat1->DrawLatex(0.1, 0.73, Form("%s_beam_X = %1.3f mm", which_scan.c_str(), beam_x));
      lat1->SetTextColor(96);
      lat1->DrawLatex(0.1, 0.69, Form("%s_mot_pos1 = %1.3f mm", which_scan.c_str(), stage1_truncated_[2]));
      lat1->DrawLatex(0.1, 0.65, Form("%s_mot_pos2 = %1.3f mm", which_scan.c_str(), stage2_truncated_[2]));
      //lat1->DrawLatex(0.1, 0.83, Form("%s_si_retracted_pos = %1.3f mm", which_scan.c_str(), si_pos_[2]));
      lat1->DrawLatex(0.1, 0.61, Form("%s_wire_dist = %1.3f mm", which_scan.c_str(), wire_dist_truncated));
      lat1->DrawLatex(0.1, 0.57, Form("%s_beam_Y = %1.3f mm", which_scan.c_str(), horiz_wire_pos_truncated_[2]));
      lat1->DrawLatex(0.1, 0.53, Form("%s_beam_X = %1.3f mm", which_scan.c_str(), beam_x_truncated));
    }
  
  if( n_peaks3 == 2 )
    {
      double *positions_;
      double *positions2_;
      double *positions_truncated_;
      double *positions2_truncated_;
      SVTwirePosition svt_wire_pos(file_name);

      if( top_scan )
	{
	  positions_ = GetTopPos(stage1_[3]);
	  positions2_ = GetTopPos(stage2_[3]);
	  positions_truncated_ = GetTopPos(stage1_truncated_[3]);
	  positions2_truncated_ = GetTopPos(stage2_truncated_[3]);
	}
      else if( bot_scan)
	{
	  positions_ = GetBotPos(stage1_[3]);
	  positions2_ = GetBotPos(stage2_[3]);
	  positions_truncated_ = GetBotPos(stage1_truncated_[3]);
	  positions2_truncated_ = GetBotPos(stage2_truncated_[3]);
	}
      si_pos_[3] = positions_[0];
      horiz_wire_pos_[3] = positions_[1];
      stereo_wire_pos_[3] = positions2_[1];
      horiz_wire_pos_truncated_[3] = positions_truncated_[1];
      stereo_wire_pos_truncated_[3] = positions2_truncated_[1];
      
      double wire_dist = TMath::Abs(stereo_wire_pos_[3] - horiz_wire_pos_[3]);
      double beam_x = svt_wire_pos.calcXbeam(wire_dist);
      double wire_dist_truncated = TMath::Abs(stereo_wire_pos_truncated_[3] - horiz_wire_pos_truncated_[3]);
      double beam_x_truncated = svt_wire_pos.calcXbeam(wire_dist_truncated);

      lat1->SetTextColor(4);
      lat1->DrawLatex(0.15, 0.45, "Analyze from HPS_SC counter" );
      lat1->SetTextColor(64);
      lat1->DrawLatex(0.1, 0.41, Form("%s_mot_pos1 = %1.3f mm", which_scan.c_str(), stage1_[3]));
      lat1->DrawLatex(0.1, 0.37, Form("%s_mot_pos2 = %1.3f mm", which_scan.c_str(), stage2_[3]));
      //lat1->DrawLatex(0.1, 0.33, Form("%s_si_pos = %1.3f mm", which_scan.c_str(), si_pos_[3]));
      lat1->DrawLatex(0.1, 0.33, Form("%s_wire_dist = %1.3f mm", which_scan.c_str(), wire_dist));
      lat1->DrawLatex(0.1, 0.29, Form("%s_beam_Y = %1.3f mm", which_scan.c_str(), horiz_wire_pos_[3]));
      lat1->DrawLatex(0.1, 0.25, Form("%s_beam_X = %1.3f mm", which_scan.c_str(), beam_x));
      lat1->SetTextColor(96);
      lat1->DrawLatex(0.1, 0.21, Form("%s_mot_pos1 = %1.3f mm", which_scan.c_str(), stage1_truncated_[3]));
      lat1->DrawLatex(0.1, 0.17, Form("%s_mot_pos2 = %1.3f mm", which_scan.c_str(), stage2_truncated_[3]));
      lat1->DrawLatex(0.1, 0.13, Form("%s_wire_dist = %1.3f mm", which_scan.c_str(), wire_dist_truncated));
      lat1->DrawLatex(0.1, 0.09, Form("%s_beam_Y = %1.3f mm", which_scan.c_str(), horiz_wire_pos_truncated_[3]));
      lat1->DrawLatex(0.1, 0.05, Form("%s_beam_X = %1.3f mm", which_scan.c_str(), beam_x_truncated));

      if( make_log )
	{
	  system(Form("caput HPS_SVT:SCAN:x_offset %1.4f", beam_x));
	  system(Form("caput HPS_SVT:SCAN:y_offset %1.4f", horiz_wire_pos_[3]));
	  system(Form("caput HPS_SVT:SCAN:x_offset_locfit %1.4f", beam_x_truncated));
	  system(Form("caput HPS_SVT:SCAN:y_offset_locfit %1.4f", horiz_wire_pos_truncated_[3]));
	}
    }
  
  string img_path = Form("/home/hpsrun/screenshots/Analyze_%s.gif", file_name.c_str());
  //c2->Print(Form("/home/hpsrun/screenshots/Analyze_%s.gif", file_name.c_str()));
  
  if( make_log )
    {
      c2->Print(Form("%s", img_path.c_str()));
      if( n_peaks2 == 2 || n_peaks2 == 3 )
	{
	  system(Form("/site/ace/certified/apps/bin/logentry -l HBLOG -t \"Analyse of %s \" -a %s ", file_name.c_str(), img_path.c_str()));
	  //system(Form("/site/ace/certified/apps/bin/logentry -l HBLOG -t \"Analyse of %s \" -a %s ", file_name.c_str(), img_path.c_str()));
	}
    }
  app1->Run();
}

TH1D *Graph2Hist(TGraph * gr)
{
  int n_points = gr->GetN();
  double *x_axis = gr->GetX();
  double *y_axis = gr->GetY();
  
  double x_varbins_[n_points + 1];
  double y_varbins_[n_points + 1];

  x_varbins_[0] = x_axis[0] - (x_axis[1] - x_axis[0])/2.;
  x_varbins_[n_points] = x_axis[n_points - 1] + (x_axis[n_points - 1] - x_axis[n_points - 2])/2.;
  
  cout<<"x_varbins ["<<0<<"] = "<<x_varbins_[0]<<endl;
  cout<<"x_varbins ["<<n_points<<"] = "<<x_varbins_[n_points]<<endl;
  for( int i = 1; i < n_points; i++ )
    {
      x_varbins_[i] = (x_axis[i-1] + x_axis[i])/2.;
      //cout<<"x_varbins ["<<i<<"] = "<<x_varbins_[i]<<endl;
      
      if( x_varbins_[i] <= x_varbins_[i - 1] )
	{
	  cout<<"               ================= Hop ============== x is decreasing ====== "<<endl;
	}
    }

  double x_low, y_low;
  double x_high, y_high;
  double bin_width = (x_high - x_low)/double(n_points - 1);

  gr->GetPoint(0, x_low, y_low);
  gr->GetPoint(n_points - 1, x_high, y_high);
  TH1D *h_gr = new TH1D("h_gr", "", n_points, x_varbins_ );

  //cout<<"xlow is "<<x_low<<"    x_high is "<<x_high<<endl;

  h_gr->FillN(n_points, x_axis, y_axis);
  h_gr->SetStats(0);
  
  return h_gr;
}

double* GetTopPos(double stage)
{
  double *top_pos = new double[2];
  top_pos[0]  = -0.391*stage + 7.542; // dtstance of Top Si. from the beam;
  top_pos[1] = -0.482*stage + 1.305; // distance of the top horizontal wire from the beam
  return top_pos;
}

double* GetBotPos(double stage)
{
  double *bot_pos = new double[2];
  bot_pos[0]  = +0.363*stage - 7.048; // dtstance of Top Si. from the beam;
  bot_pos[1] = +0.463*stage - 0.982; // distance of the top horizontal wire from the beam
  return bot_pos;
}
