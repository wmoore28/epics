/* 
 * File:   SVTwirePosition.h
 * Author: annie
 *
 * Created on March 26, 2015, 2:31 AM
 */

#ifndef SVTWIREPOSITION_H
#define	SVTWIREPOSITION_H

#include<iostream>
#include<string>

using namespace std;

class SVTwirePosition {
public:
    SVTwirePosition();
    SVTwirePosition(const SVTwirePosition& orig);
    virtual ~SVTwirePosition();
    
    SVTwirePosition(std::string arg);
    double calcXbeam(double dy);
    void setBeamYnomPos_SVT(double ynom) ;
    void setScanProp(int scanprop);
    double calcYbeam(double Y);
    
    std::string wrsysName; //name of wire system

    
private:
     
    static const double nomdy = 1.95; //nominal value of distance of 2 wires at some x_nominal

    double nomposY; //nominal position is the position of wire systems at y=0 point in stage coordinate system

    static const double beta = 8.9;
    int scan_prop;  //defines shift direction of the wire system in respect to  
                        //it's nominal position so that the shift "sign" meets Y axis directions    
};

#endif	/* SVTWIREPOSITION_H */

