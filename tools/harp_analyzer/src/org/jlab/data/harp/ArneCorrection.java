/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.data.harp;

/**
 *
 * @author AS
 */
public class ArneCorrection {
    
    public ArneCorrection(){};
    
    public static double ApplyCorrection(double sigma_mes, double wd ){
        
        sigma_mes = Math.abs(sigma_mes)/wd;
        
        double true_sigma = sigma_mes/(1+0.025/Math.pow(sigma_mes,2.826));
        
        System.out.println(sigma_mes+" "+Math.pow(sigma_mes,2.826)+" "+(1+0.025/Math.pow(sigma_mes,2.826)));
        
        
        return true_sigma*wd;    
    }       
    
}
