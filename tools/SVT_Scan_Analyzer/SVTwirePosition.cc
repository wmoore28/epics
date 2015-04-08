/* 
 * File:   SVTwirePosition.cpp
 * Author: annie
 * 
 * Created on March 26, 2015, 2:31 AM
 */

#include "SVTwirePosition.h"
#include <math.h>

using namespace std;

SVTwirePosition::SVTwirePosition() {
}

 
SVTwirePosition::SVTwirePosition(std::string arg){              
        
      if (arg.find("bot") >0 || arg.find("BOT") >0 ) {          
         wrsysName = "bottom wire system";
         nomposY = 2.120;  //define nominal Y position for bottom wire in stage coordinate system
         scan_prop = -1;
      } 
      else 
         if (arg.find("top") >0 || arg.find("TOP") >0 ) {
         wrsysName = "top wire system";
         nomposY = 2.706;  //define nominal Y position for top wire system in stage coordinate system
         scan_prop = 1;    
      }
         else{

           wrsysName = "initial setting"; 
           nomposY = 0.0;
           scan_prop = 0;  
             
            cout<<"*****Error*****:::::Scan type for SVT doesn't contain neither 'top' nor 'bot'.\n*****Error*****:::::Please enter valid argument.\n";
         }
   }


SVTwirePosition::SVTwirePosition(const SVTwirePosition& orig) {
}

SVTwirePosition::~SVTwirePosition() {
}

 /*
    *
    *returns x coordinate of wire system in respect to nominal position 
    */
    double SVTwirePosition::calcXbeam(double dy) {
//       cout<<"Kuku Kuku     dy = "<<dy<<endl;
//       cout<<"SVTwirePosition::nomdy = "<<(SVTwirePosition::nomdy)<<endl;
//       cout<<"SVTwirePosition::beta = "<<(SVTwirePosition::beta)<<endl;
//       cout<<"M_PI = "<<M_PI<<endl;
      //return (-1)*(fabs(dy) - SVTwirePosition::nomdy) / tan((SVTwirePosition::beta)*(M_PI/180.0));
      return (+1)*(fabs(dy) - SVTwirePosition::nomdy) / tan((SVTwirePosition::beta)*(M_PI/180.0));
      
      //(-1) is to indicate that the wire system is shifted from it's nominal position
      //dy>nomdy means shift to right - towards negative direction of X
      //dy<nomdy means shift to left - towards positive direction of X axis
      //this is why the calculation is multiplied by (-1) to have x coordinate of wire system to meet this logical directions of X axis
   }

    /*
    *to be more user friendly can be binded to user interface to change nominal values if nessecary.
    *is not implemented yet(12/march/2015)
    */
    void SVTwirePosition::setBeamYnomPos_SVT(double ynom) {
      nomposY = ynom;
   }
   
   /*
    *set scan_prop - defines shift direction of the wire system in respect to 
    *it's nominal position so that the shift "sign" meets Y axis directions
    */
   void SVTwirePosition::setScanProp(int scanprop) {
      if(scanprop!=1 || scanprop!=-1){
        cout<<"***Error****:::::Scan property setting is wrong, will be set to 0.\n ***Hint-----> set -1 for ;the botom wire system.\n ----------->  set 1 for the top wire system.\n";
         scan_prop = 0;
      }
      else
         scan_prop = scanprop;   
   }
   
   /*
   *Returns calculated position of wire system in respect to beam
   */
   double SVTwirePosition::calcYbeam(double Y) {     //Y first peak position, the one with horizontal wire, is the distance of wire from the beam
      
       cout<<"nomposY = "<<nomposY<<endl;
       return scan_prop*(Y - nomposY);
   }


