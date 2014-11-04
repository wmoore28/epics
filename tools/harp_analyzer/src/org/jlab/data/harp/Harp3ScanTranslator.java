/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.jlab.data.harp;
import static java.lang.Math.atan;
import static java.lang.Math.cos;
import static java.lang.Math.pow;
import static java.lang.Math.sin;
/**
 *
 * @author gavalian
 */
public class Harp3ScanTranslator {
    
    /**
     * @param args the command line arguments
     */
    
    private double alpha;
    private double a;
    private double b;
    
    private double sigma45;
    private double sigmax;
    private double sigmay;
    
    private static double A;
    private static double B;
    private static double C;
    
  
    
    public Harp3ScanTranslator(double scan45, double scanx, double scany){
        
        this.sigma45 = scan45;
        this.sigmax = scanx;
        this.sigmay = scany;
                      
        this.iniA();           
        this.iniB();         
        this.iniC();                           
    }
    
    private void iniA() {
        this.A = pow(this.sigmax,2);
    }
            
    private void iniB() {
        this.B = pow(this.sigmay,2);
    }
           
    private void iniC() {
        this.C = pow(this.sigma45,2);
    }
    
    public void setSigma45(double scan45){
        if(this.IsValidScan(scan45)==true){
            this.sigma45 = scan45; 
            this.iniC();                    
        }
    }
    
    public void setSigmaX(double scanx){
        if(this.IsValidScan(scanx)==true){              
            this.sigmax = scanx;
            this.iniA();   
        }
    }  
    
    public void setSigmaY(double scany){
        if(this.IsValidScan(scany)==true){                      
            this.sigmay = scany;
            this.iniB();
        }
    }
    
    
    public double getAlpha(){        
        this.Aalpha();
        this.aA();
        this.bB();        
        this.check_sols();
                
        return Math.toDegrees(this.alpha);
    }
    public double getA(){
        return this.a;
    }
     public double getB(){
        return this.b;
    }
    
    
    private boolean IsValidScan(double scan){
        if(this.IsZero(scan) == true){
            CallGvenik("Input error:::"+scan+" mesurement is pointlike.\n");
            return false;
        }
        return true;       
    }
    
    private  boolean IsValidScan()//double scan45, double scanx, double scany)
    {
        if( this.IsZero(this.sigma45) || this.IsZero(this.sigmax)  || this.IsZero(this.sigmay)) {
            System.out.print("Input error:::one of mesurements is pointlike.\n ");
            return false;
        }
        
        return true;    
    }
    
    private boolean IsSingularPoint(){

        if(this.IsZero(A-B)==true && this.IsZero(A-C)==false )        
        {
            System.out.print("Singular point:::Calling Gvenik\n \t \t alpha is 45 or -45.\n ");
            return true;                                   
        }
        return false;
    }
    
    private boolean IsA_lessthan_B(){            
        return ((A-B)<0);        
    }
    
    
    private boolean IsCircle(){
        if(this.IsZero(A-B) && this.IsZero(B-C)){                        
            System.out.print("This is a circle:::Calling Gvenik to find out the radius\n \t \t radius = "+Math.sqrt(A)+"\n");
            return true;
        }            
        return false;
    }
    
    
    private void Aalpha()            
    {
        System.out.print("A="+A+"  B="+B+"  C="+C+"\n");

        if(this.IsValidScan() == false)        {
            System.out.print("Error::::Pointlike measurements.\n");
            this.alpha = -1000;
            return;   
        }
        
        if(this.IsCircle()==true){
            this.alpha =0;
            return;
        }
        
        if(this.IsSingularPoint()==true){
            this.alpha = (double) Math.PI/4;
            return;
        }        
        
        this.alpha = 0.5*atan((2*C-A-B)/(B-A));                               
        System.out.print("that alpha = " + Math.toDegrees(this.alpha)+"\n");

        if(this.IsA_lessthan_B()==true)           
            this.alpha = this.alpha+Math.PI;        
        
    }
    
    private static boolean IsZero(double x){
        return (x<0.000012 && x>-0.000012);
    }
        
            
    private void check_sols()
    {                     
       
        System.out.print("this alpha = "+Math.toDegrees(this.alpha)+"\t"+a+"\t"+b+"\n");
        if(this.a<this.b)
        {      
            if(this.alpha>0)                              
                this.alpha = this.alpha - Math.PI/2;    
            else            
                if(this.alpha<0)                                                            
                    this.alpha = this.alpha + Math.PI/2;
             
            double temp = this.a;                    
            this.a = this.b;                
            this.b = temp;
                System.out.print("then alpha = "+Math.toDegrees(this.alpha)+"\n");

        }
    }
    
   
    
    private double singularb(){        
        return this.sigma45;        
    }
    
     private double singulara(){                            
        return Math.sqrt(2*A-C);        
    }
    
    private void bB()
    {        
        if(this.IsSingularPoint()==true)
        {
            this.b = this.singularb();
            return;
        }
      if((0.5*( A+B-(A-B)/Math.cos(2*this.alpha)))<0)
                {        
            System.out.print("Out of definition range. Have no solution for 'b' parameter. Will be set to -1.\n");
            this.b = -1;       
            return;
        }        
        this.b = Math.sqrt(0.5*( A+B-(A-B)/Math.cos(2*this.alpha)));
    }
    
    private void aA()
    {            
        if(this.IsSingularPoint()==true)
        {
            this.a = this.singulara();
            return;
        }                
        if(0.5*(A+B+(A-B)/Math.cos(2*this.alpha))<0){        
            System.out.print("Out of definition range. Have no solution for 'a' parameter. Will be set to -1.\n");
            this.a = -1;       
            return;
        }        
        
        this.a = Math.sqrt(0.5*(A+B+(A-B)/Math.cos(2*this.alpha)));   
        
    }
    
    
    
    private static void CallGvenik(String str){
        System.out.print(str+"\nHors arev pti gas Gvenik.\n");
    }
    
    public double sigmaX(double a, double b, double phi_alpha)
    {
        phi_alpha=Math.toRadians(phi_alpha);
        double A2 = pow(a*cos(phi_alpha),2) +pow(b*sin(phi_alpha),2);
                
        System.out.print(A2+" =A\n");

        return Math.sqrt(A2);
    }
    
    public double sigmaY(double a, double b, double phi_alpha)
    {
        phi_alpha=Math.toRadians(phi_alpha);

        double B2 = pow(a*sin(phi_alpha),2) +pow(b*cos(phi_alpha),2);
                System.out.print(B2+" =B\n");

        return Math.sqrt(B2);
    }
 
        
    public double sigma45(double a, double b, double phi_alpha)
    {                
        phi_alpha=Math.toRadians(phi_alpha);

        double C2 = pow(a*cos(Math.PI/4-phi_alpha),2) +pow(b*sin(Math.PI/4-phi_alpha),2);
                        System.out.print(C2+" =C\n");

        return Math.sqrt(C2);
    }
}
