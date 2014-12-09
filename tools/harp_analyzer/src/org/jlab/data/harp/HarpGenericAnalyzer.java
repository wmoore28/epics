/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.data.harp;

import java.lang.Math;
import java.awt.List;
import java.util.ArrayList;
import java.util.TreeMap;
import org.jlab.data.fitter.DataFitter;
import org.jlab.data.func.F1D;
import org.jlab.data.graph.DataSetXY;
import org.jlab.data.graph.DataTable;
import org.jlab.data.graph.DataVector;
import org.jlab.data.utils.PeakFinder;

/**
 *
 * @author gavalian
 */
public class HarpGenericAnalyzer {
   
    private ArrayList<DataSetXY>  harpData = new ArrayList<DataSetXY>();
    private ArrayList<F1D>        harpFunc = new ArrayList<F1D>();
    private String                harpName = "harp_tagger";

    private Double  graphCutSigmas  = 15.0;
    
    public HarpGenericAnalyzer(){        
    
    }
    
    public void setName(String name){
	harpName = name;
    }
    
    public void init(DataTable table, int column){
        harpData.clear();
        DataSetXY dataFull = table.getDataSet(0, column);
        
       
        DataSetXY dataNorm = dataFull.getDataSetRieman(100);
        //System.err.println(dataNorm.toString());
        //dataNorm.show();
        PeakFinder peak = new PeakFinder(2);
        peak.doClustering(dataNorm);
        
        harpData.clear();
        java.util.List<DataVector> clusters = peak.getClusters();
        for(DataVector vec : clusters){
            if(vec.getSize()>5){
                double mean = vec.getMean();
                double rms  = vec.getRMS();
                double xmin = mean - graphCutSigmas*rms;
                double xmax = mean + graphCutSigmas*rms;
                DataSetXY dataset = table.getDataSet(0, column, 0, xmin, xmax);

		if(harpName.compareTo("harp_tagger")==0){
		    if(harpData.size()>0){
			dataset.getDataX().mult(Math.sqrt(2.0)/2.0);
		    }
		}

		if(harpName.compareTo("harp_2c21")==0){
		    dataset.getDataX().mult(Math.sqrt(2.0)/2.0);
		}
                else if( harpName.compareTo("harp_2H02A")==0 )
                    {
                        dataset.getDataX().mult(10.);
                       if(harpData.size()!=2) // Size here means the wire number :-)
                       {
                           dataset.getDataX().mult(Math.sqrt(2.0)/2.0);
                       }
                    }


                harpData.add(dataset);
            }
        }
        
    }
    
    public void fitData(){

        harpFunc.clear();
        for(int loop = 0; loop < harpData.size(); loop++){
            F1D func = new F1D("gaus+p1",
                    harpData.get(loop).getDataX().getMin(),
                    harpData.get(loop).getDataX().getMax()
            );
            
            func.parameter(0).set(harpData.get(loop).getDataY().getMax(), 
                    harpData.get(loop).getDataY().getMax()*0.6, harpData.get(loop).getDataY().getMax()*1.4);            // It shouldn't be haigher than Maximum, and if bgr is not that high 
                                                                                 // min limit values shouldn't be too low 
            func.parameter(1).setValue(harpData.get(loop).getDataX().getMean());
            //func.parameter(1).set(harpData.get(loop).getDataX().getMean(), harpData.get(loop).getDataX().getMean()*0.8, 
              //      harpData.get(loop).getDataX().getMean()*1.2);
            func.parameter(2).set(harpData.get(loop).getDataX().getRMS()*0.1,
                    harpData.get(loop).getDataX().getRMS()*0.001,harpData.get(loop).getDataX().getRMS()*3);
            func.parameter(3).set(0.0, -100, 100);
            func.parameter(4).set(0.0, -100, 100);
            func.show();
            harpFunc.add(func);
        }
        
        
        for(int loop = 0; loop < harpData.size(); loop++){
            DataFitter.fit(harpData.get(loop), harpFunc.get(loop));
        }
        
        for(int loop = 0; loop < harpData.size(); loop++){
            harpFunc.get(loop).show();
        }
        
    }
    
    public ArrayList<F1D>  getHarpFuncs(){
        return harpFunc;
    }
    
    public ArrayList<DataSetXY>  getHarpData(){
        return harpData;
    }
    
    
    public String[] getLegend(int index, String harp_name){
        
 
        int n_wire = harpData.size();
        
        String[] wireName = new String[n_wire];
        
        int n_leg_entries = 0;
        if( n_wire == 2 )
        {
           wireName[0] = "Wire X";
           wireName[1] = "Wire Y";
           n_leg_entries = 5;               // It was 4 before
        }
        else if( n_wire == 3 )
        {
            if( harp_name.compareTo("harp_tagger") == 0 )
            {
             wireName[0] = " 45 deg";
             wireName[1] = " Y";
             wireName[2] = " X";
              
            }
            else if( harp_name.compareTo("harp_2H02A") == 0 )
            {
            wireName[0] = "Wire X";
            wireName[1] = "Wire Y";
            wireName[2] = "Wire 45 deg";
            }
           n_leg_entries = 6;
        }
        
        String[] legend = new String[n_leg_entries];
        
        legend[0] = String.format("Wire         %-10s", wireName[index]);
        legend[1] = String.format("%-12s %8.5f", "mean", 
                harpFunc.get(index).parameter(1).value());
        legend[2] = String.format("%-12s %8.5f", "sigma", 
                harpFunc.get(index).parameter(2).value());
        legend[3] = String.format("%-12s %8.5f", "chi2",
                harpFunc.get(index).getChiSquare(harpData.get(index))/
                harpFunc.get(index).getNDF(harpData.get(index))
                );
        
        double pol0 = harpFunc.get(index).parameter(3).value();
        double pol1 = harpFunc.get(index).parameter(4).value();
        double bgr_val = pol0 + pol1*harpFunc.get(index).parameter(1).value();      // Bgr value at under the peak
        double peak_val = harpFunc.get(index).parameter(0).value();
        legend[4] = String.format("bgr/peak    %2.3e", bgr_val/peak_val);
                
        if( n_wire == 3 )
        {
            legend[5] = String.format("bgr/peak    %2.3e", bgr_val/peak_val);
            if( harp_name.compareTo("harp_tagger") == 0 )
            {
                if(index == 1)
                {
                 legend[4] = String.format("Motor pos    %8.5f", harpFunc.get(index).parameter(1).value()*Math.sqrt(2.));
                }
                else if(index == 2)
                {
                    legend[4] = String.format("Motor pos     %8.5f", harpFunc.get(index).parameter(1).value()*Math.sqrt(2.));
                }
                else
                {
                legend[4] = "";
                }
            }
            else if( harp_name.compareTo("harp_2H02A") == 0 )
            {
                if(index == 0)
                {
                 legend[4] = String.format("Motor pos    %8.5f", harpFunc.get(index).parameter(1).value()*Math.sqrt(2.));
                }
                else if(index == 1)
                {
                    legend[4] = String.format("Motor pos    %8.5f", harpFunc.get(index).parameter(1).value()*Math.sqrt(2.));
                }
                else
                {
                legend[4] = "";
                }              
            }
        }
        return legend;
    }
    
    public String[] getLegendAlphaAB(String harp_name)
    {
       String[] legend = new String[3];
       double sigma_X, sigma_Y, sigma_45;
       
       if( harp_name.compareTo("harp_tagger") == 0 )
       {
             sigma_X = harpFunc.get(2).parameter(2).value();
             sigma_Y = harpFunc.get(1).parameter(2).value();
             sigma_45 = harpFunc.get(0).parameter(2).value();
       }
       else if( harp_name.compareTo("harp_2H02A") == 0 )
       {
             sigma_X = harpFunc.get(0).parameter(2).value();
             sigma_Y = harpFunc.get(1).parameter(2).value();
             sigma_45 = harpFunc.get(2).parameter(2).value();
        }
       else
       {
           legend[0] = "";
           return legend;
       }
       
       Harp3ScanTranslator translate = new Harp3ScanTranslator( sigma_45, sigma_X*Math.sqrt(2.), sigma_Y*Math.sqrt(2.));
      // Harp3ScanTranslator translate = new Harp3ScanTranslator( sigma_45, sigma_X*Math.sqrt(2.), sigma_Y*Math.sqrt(2.));
//Harp3ScanTranslator translate = new Harp3ScanTranslator( 0.18360, 0.15867, 0.28318);

       legend[0] = String.format( "%-12s  %8.5f", "Alpha", translate.getAlpha() );
       legend[1] = String.format( "%-12s  %8.5f", "A", translate.getA()/Math.sqrt(2.));
       legend[2] = String.format( "%-12s  %8.5f", "B", translate.getB()/Math.sqrt(2.));
       
       return legend;
    }
    
    public String[] getBeamXY_legend(String harp_name)
    {
        String[] legend = new String[2];
        double x_nominal_2H02A = 45.33/Math.sqrt(2.);
        double y_nominal_2H02A = 68.92/Math.sqrt(2.);
        double x_nominal_tagger = 52.37/Math.sqrt(2.);
        double y_nominal_tagger = 31.67/Math.sqrt(2.);
        
        
        if( harp_name.compareTo("harp_tagger") == 0 )
        {
            double x_from_scan = harpFunc.get(2).parameter(1).value();
            double y_from_scan = harpFunc.get(1).parameter(1).value();
            double x_beam = x_from_scan - x_nominal_tagger;
            double y_beam = y_nominal_tagger - y_from_scan;
            legend[0] = String.format("%-12s  %4.5f mm", "beam X", x_beam);
            legend[1] = String.format("%-12s  %4.5f mm", "beam Y", y_beam);
        }
        else if(harp_name.compareTo("harp_2H02A") == 0)
        {
            double x_from_scan = harpFunc.get(0).parameter(1).value();
            double y_from_scan = harpFunc.get(1).parameter(1).value();
            double x_beam = x_nominal_2H02A - x_from_scan;
            double y_beam = y_nominal_2H02A - y_from_scan;
            legend[0] = String.format("%-12s  %4.5f mm", "beam X", x_beam);
            legend[1] = String.format("%-12s  %4.5f mm", "beam Y", y_beam);
        }
               
        
        return legend;
    }
    
}
