/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jlab.data.harp;

/**
 *
 * @author annie
 * 
 *calculate SVT wire system positions in respect to beam 
 */

public class SVTwireSysPosition {
    
   public String wrsysName = "initial setting"; //name of wire system

   private static final double nomdy = 1.98; //nominal value of distance of 2 wires at some x_nominal

   private double nomposY = 0.0; //nominal position is the position of wire systems at y=0 point in stage coordinate system

   private static final double beta = 8.904;
   private int scan_prop = 0;  //defines shift direction of the wire system in respect to  
                               //it's nominal position so that the shift "sign" meets Y axis directions

   //default constructer, don't use unless all initial settings(nomposY and scan_prop) will be set after
   public SVTwireSysPosition(){
   }

   
    
    public SVTwireSysPosition(String arg) {              
        
      if (arg.contains("bot") == true ) {          
         this.wrsysName = "bottom wire system";
         nomposY = 2.120;  //define nominal Y position for bottom wire in stage coordinate system
         scan_prop = -1;
      } 
      else 
         if (arg.contains("top") == true ) {
         this.wrsysName = "top wire system";
         nomposY = 2.706;  //define nominal Y position for top wire system in stage coordinate system
         scan_prop = 1;    
      }
         else if(scan_prop==0){
            System.err.println("*****Error*****:::::Scan type for SVT doesn't contain neither 'top' nor 'bot'.\n*****Error*****:::::Please enter valid argument.");
         }
   }

   
    
    /*
    *
    *returns x coordinate of wire system in respect to nominal position 
    */
    public double calcXbeam(double dy) {
      
      return (-1)*(Math.abs(dy) - SVTwireSysPosition.nomdy) / Math.tan(Math.toRadians((SVTwireSysPosition.beta)));
      
      //(-1) is to indicate that the wire system is shifted from it's nominal position
      //dy>nomdy means shift to right - towards negative direction of X
      //dy<nomdy means shift to left - towards positive direction of X axis
      //this is why the calculation is multiplied by (-1) to have x coordinate of wire system to meet this logical directions of X axis
   }

    /*
    *to be more user friendly can be binded to user interface to change nominal values if neccessary.
    *is not implemented yet(12/march/2015)
    */
   public void setBeamYnomPos_SVT(double ynom) {
      nomposY = ynom;
   }
   
   /*
    *set scan_prop - defines shift direction of the wire system in respect to 
    *it's nominal position so that the shift "sign" meets Y axis directions
    */
   public void setScanProp(int scanprop) {
      if(scanprop!=1 || scanprop!=1){
         System.err.println("***Error****:::::Scan property setting is wrong, will be set to 0.\n ***Hint-----> set -1 for ;the botom wire system.\n ----------->  set 1 for the top wire system.");
         scan_prop = 0;
      }
      else
         scan_prop = scanprop;   
   }
   
   /*
   *Returns calculated position of wire system in respect to beam
   */
   public double calcYbeam(double Y) {     //Y first peack position, the one with horizontal wire, is the distance of wire from the beam
      return scan_prop*(Y - nomposY);
   }

   
}


