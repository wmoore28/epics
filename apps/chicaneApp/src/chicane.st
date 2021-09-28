// PS = Pair Spectrometer
// MT = Mini Torus

program seqChicane ("P=a")

option -c;  // donot wait on pv connections
option -r;  // donot allow multiple instances

short hallAccessState; assign hallAccessState to "PLC_HLB";

short  abtBtn;  assign abtBtn  to "{P}:abort";  monitor abtBtn;
short  onBtn;   assign onBtn   to "{P}:start";  monitor onBtn;
short  offBtn;  assign offBtn  to "{P}:stop";   monitor offBtn;
short  calcBtn; assign calcBtn to "{P}:calc";   monitor calcBtn;
short  calcBtnCurr; assign calcBtnCurr to "{P}:calcCurr";   monitor calcBtnCurr;
//short  calcAndSetBtnCurr; assign calcAndSetBtnCurr to "${P}:calcAndSetCurr";  monitor calcAndSetBtnCurr;

float  tHoldMax; assign tHoldMax to "{P}:tHoldMax";

float  iDeltaPS;   assign iDeltaPS   to "{P}:iDeltaPS"; monitor iDeltaPS;
float  iDeltaMT;   assign iDeltaMT   to "{P}:iDeltaMT"; monitor iDeltaMT;

string stmp;
string msg;      assign msg      to "{P}:msg";

float  iCalcPS;  assign iCalcPS  to "{P}:iCalcPS";
float  iCalcMT;  assign iCalcMT  to "{P}:iCalcMT";
float  complete; assign complete to "{P}:complete";
float  energy;   assign energy   to "{P}:energy";
short  isReady;  assign isReady  to "{P}:isReady";
short  isError;  assign isError  to "{P}:isError";
short  isOff;    assign isOff    to "{P}:isOff";

float energyB;   assign energyB to "MBSY2C_energy";

// SIMULATOR:
//float  iSetPS;  assign iSetPS   to "{P}:iSetPS";    monitor iSetPS;
//float  iMonPS;  assign iMonPS   to "{P}:iMonPS";    monitor iMonPS;
//float  iSetMT;  assign iSetMT   to "{P}:iSetMT";    monitor iSetMT;
//float  iMonMT;  assign iMonMT   to "{P}:iMonMT";    monitor iMonMT;
//short powerMT;  assign powerMT  to "{P}:powerMT";  monitor powerMT;
//short powerPS;  assign powerPS  to "{P}:powerPS";  monitor powerPS;

// REAL MAGNETS:

float iMonPS;   assign iMonPS  to "PSPECIRBCK"; monitor iMonPS;
float iMonMT;   assign iMonMT  to "MTDACRBCK";  monitor iMonMT;

float iSetPS;   assign iSetPS  to "PSPECISET";
float iSetMT;   assign iSetMT  to "MTSETI";

short powerMT;  assign powerMT to "MTPSONSET";  monitor powerMT;
short powerPS;  assign powerPS to "PSPECC.B0";  monitor powerPS;

float iSetRbkPS; assign iSetRbkPS to "PSPECs"; monitor iSetRbkPS;
float iSetRbkMT; assign iSetRbkMT to "MTISETRBCK"; monitor iSetRbkMT;

int tConfirm = 5; // time to give user a chance to cancel (seconds)
float iMaxPS = 2700.0;  // saturation current to hold at (Amps)
float iMaxMT = 3500.0;  // saturation current to hold at (Amps)
float iZeroPS = 8;
float iZeroMT = 0;

float iStartPS;
float iStartMT;
int count;

// JUST FOR SIMULATOR:
int countDriver;
short  gotoZeroBtn; assign gotoZeroBtn to "{P}:gotoZero"; monitor gotoZeroBtn;
short  gotoMaxBtn;  assign gotoMaxBtn  to "{P}:gotoMax";  monitor gotoMaxBtn;
short  gotoSetBtn;  assign gotoSetBtn  to "{P}:gotoSet";  monitor gotoSetBtn;


%{
//#include "math.h"
float getCurrentPS(float ee) {
    ee/=1e3; // convert from MeV to GeV
    return 0.22727*0.1537*1e4*ee + 0.6657;
}
float getCurrentMT(float ee) {
    return getCurrentPS(ee) / 0.5228;
}
int isSimilar(float x1,float x2,float dx) {
    return fabs(x1-x2)<dx;
}
int isSimilar2(float x1,float x2,float dx, float y1,float y2,float dy) {
    return isSimilar(x1,x2,dx) && isSimilar(y1,y2,dy);
}
float minComplete(float x0,float x1,float x2,float y0,float y1,float y2) {
    const float cx = (x1-x0) / (x2-x0);
    const float cy = (y1-y0) / (y2-y0);
    return cx<cy ? cx : cy;
}

// JUST FOR SIMULATOR:
float getRampCurrent(int step,int nstep,float i0,float i1) {
    return i0 + (float)step/nstep*(i1-i0);
}
}%

ss seqChicane {

    state init {

     	when (pvConnectCount() < pvChannelCount()) {
            sprintf(msg,"Waiting for PVs (%d/%d)",pvConnectCount(),pvChannelCount());
            pvPut(msg);
        } state init
        
        when () {
            abtBtn=0;
            offBtn=0;
            onBtn=0;
            pvPut(abtBtn);
            pvPut(offBtn);
            pvPut(onBtn);
            isOff=0;
            isReady=0;
            pvPut(isOff);
            pvPut(isReady);
            pvGet(energy);
            pvGet(iSetPS);
            pvGet(iSetMT);
            pvGet(iCalcPS);
            pvGet(iCalcMT);
            sprintf(msg,"Initialized");
            epicsThreadSleep(2);
            pvPut(msg);
        } state postinit
    }

    state postinit {

        // Chicane ready when IOC was restarted:
        when (energy > 0 &&
                isSimilar2(iSetPS,iMonPS, iDeltaPS, iSetMT,iMonMT, iDeltaMT) && 
                isSimilar2(iSetPS,iCalcPS,iDeltaPS, iSetMT,iCalcMT,iDeltaMT)) {
        } state ready

        // Chicane off when IOC was restarted:
        when (isSimilar2(iSetRbkPS,iZeroPS,iDeltaPS,iSetRbkMT,0,iDeltaMT) &&
              isSimilar2(iMonPS,iZeroPS,iDeltaPS,iMonMT,0,iDeltaMT) ) { 
            isOff=1;
            sprintf(msg,"OFF");
            pvPut(isOff);
            pvPut(msg);
        } state idle

        when () {} state idle
    }

    state idle {

        option -e; // execute entry even if previous state was the same

        entry {
            pvGet(hallAccessState);
        }

        when (pvConnectCount() < pvChannelCount() ) {} state init

        when (offBtn) {
            offBtn = 0;
            pvPut(offBtn);
        } state rampOff

        when (onBtn && hallAccessState<5) {
            sprintf(stmp,msg);
            sprintf(msg,"Beam Permit Required!");
            pvPut(msg);
            onBtn = 0;
            pvPut(onBtn);
            epicsThreadSleep(5);
            sprintf(msg,stmp);
            pvPut(msg);
        } state idle

        when (abtBtn) {
            abtBtn=0;
            pvPut(abtBtn);
        } state idle

        when (onBtn) {
            onBtn = 0;
            pvPut(onBtn);
        } state pauseBeforeRampToMax

        when (calcBtn) {
            calcBtn=0;
            pvPut(calcBtn);
        } state calculate
        
        when (calcBtnCurr) {
            calcBtnCurr=0;
            pvPut(calcBtnCurr);
        } state calculateCurrents

        // Setpoints donot match zeros, must be controlled externally to this IOC: 
        when (!isSimilar2(iSetPS,iZeroPS,iDeltaPS,iSetMT,0,iDeltaMT) ||
              !isSimilar2(iMonPS,iZeroPS,iDeltaPS,iMonMT,0,iDeltaMT)) {
        } state external

        when () {} state external
    }

    state calculate {
        when () {
            pvGet(energyB);
            energy=energyB;
            pvPut(energy);
            pvGet(energy);
            sprintf(msg,"MCC Beam Energy Retrieved:  %.2f",energy);
            pvPut(msg);
            epicsThreadSleep(2);
            sprintf(msg,"Currents Recalculated");
            pvPut(msg);
            iCalcPS=getCurrentPS(energy);
            iCalcMT=getCurrentMT(energy);
            pvPut(iCalcPS);
            pvPut(iCalcMT);
            epicsThreadSleep(2);
            sprintf(msg,"OFF");
            pvPut(msg);
        } state idle
    }
    
    state calculateCurrents {
        when () {
            pvGet(energy);
            sprintf(msg,"Using Beam Energy:  %.2f",energy);
            pvPut(msg);
            epicsThreadSleep(2);
            iCalcPS=getCurrentPS(energy);
            iCalcMT=getCurrentMT(energy);
            pvPut(iCalcPS);
            pvPut(iCalcMT);
            sprintf(msg,"Currents Recalculated");
            pvPut(msg);
            epicsThreadSleep(2);
            sprintf(msg,"OFF");
            pvPut(msg);
        } state idle
    }

    state external {
        when () {
            isOff=0;
            sprintf(msg,"External Control");
            pvPut(isOff);
            pvPut(msg);
        } state idle
    }

    state rampOff {
        
        entry {
            sprintf(msg,"Ramping to Zero");
            iSetPS = iZeroPS;
            iSetMT = 0;
            complete = 0;
            pvPut(msg);
            pvPut(iSetPS);
            pvPut(iSetMT);
            pvPut(complete);
            iStartPS=iMonPS;
            iStartMT=iMonMT;
        }

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (isSimilar2(iMonPS,iZeroPS,iDeltaPS,iMonMT,0,iDeltaMT)) {
            sprintf(msg,"Turning MiniTorus OFF.");
            pvPut(msg);
            powerMT=0;
            pvPut(powerMT);
            epicsThreadSleep(5);
            
            sprintf(msg,"Turning PairSpec OFF.");
            pvPut(msg);
            powerPS=0;
            pvPut(powerPS);
            epicsThreadSleep(5);
            iSetPS=0;
            pvPut(iSetPS);

            complete = 0;
            isOff = 1;
            pvPut(isOff);
            pvPut(complete);
            sprintf(msg,"OFF");
            pvPut(msg);
        } state idle 

        when () {
            complete = 1-minComplete(iStartPS,iMonPS,0,iStartMT,iMonMT,0);
            pvPut(complete);
        } state rampOff
    }
    
    state ready {

        option -e; // execute entry even if previous state was the same

        entry {
            if (isOff) {
                isOff=0;
                pvPut(isOff);
            }
            if (!isReady) {
                isReady=1;
                sprintf(msg,"Chicane Ready");
                pvPut(isReady);
                pvPut(msg);
            }
        }
        
        when (pvConnectCount() < pvChannelCount() ) {} state init

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (offBtn) {
            offBtn=0;
            pvPut(offBtn);
        } state rampOff

        when (calcBtn) {
            calcBtn=0;
            pvPut(calcBtn);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(2);
            sprintf(msg,"Chicane Ready");
            pvPut(msg);
        } state ready
        
        when (calcBtnCurr) {
            calcBtnCurr=0;
            pvPut(calcBtnCurr);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(2);
            sprintf(msg,"Chicane Ready");
            pvPut(msg);
        } state ready
        
        when (onBtn) {
            onBtn=0;
            pvPut(onBtn);
            sprintf(msg,"Chicane already ON");
            pvPut(msg);
            epicsThreadSleep(2);
            sprintf(msg,"Chicane Ready");
            pvPut(msg);
        } state ready

        when (!isSimilar2(iCalcPS,iSetPS,iDeltaPS,iCalcMT,iSetMT,iDeltaMT)) {
        } state external

        when (!isSimilar2(iMonPS,iSetPS,iDeltaPS,iMonMT,iSetMT,iDeltaMT)) {
            sprintf(msg,"Current NOT at spec!");
            pvPut(msg);
            isError=1;
            complete=0;
            pvPut(complete);
            pvPut(isError);
        } state ready
	
        when (isSimilar2(iMonPS,iSetPS,iDeltaPS,iMonMT,iSetMT,iDeltaMT)) {
            sprintf(msg,"Chicane Ready");
            pvPut(msg);
            complete=1;
            isError=0;
            pvPut(complete);
            pvPut(isError);
        } state ready

        exit {
            complete=0;
            isReady=0;
            pvPut(complete);
            pvPut(isReady);
        }
    }

    state pauseBeforeRampToMax {
        
	option -t; // only reset delay timer if previous state was different
       
        entry {
            count = 0;
            complete = 0;
            pvPut(complete);
            sprintf(msg,"Ramping Up to Max in %d seconds",tConfirm);
            pvPut(msg);
        }

        when (offBtn) {
            offBtn=0;
            pvPut(offBtn);
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (delay(tConfirm)) {
            complete = 0;
            pvPut(complete);
        } state turnSupplyOn

        when () {
            %% complete = (float)(count) / tConfirm;
            pvPut(complete);
            sprintf(msg,"Initiating ON Procedure in %d seconds",tConfirm-count);
            pvPut(msg);
            epicsThreadSleep(1);
            count++;
        } state pauseBeforeRampToMax
    }

    state turnSupplyOn {
        
        entry {
            sprintf(msg,"Turning power supplies ON.");
            pvPut(msg);
        }

        when (pvConnectCount() < pvChannelCount() ) {} state init

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (powerMT==0) {
            powerMT=1;
            pvPut(powerMT);
            sprintf(msg,"Turning MiniTorus ON.");
            pvPut(msg);
            epicsThreadSleep(5);
        } state turnSupplyOn

        when (powerPS==0) {
            powerPS=1;
            pvPut(powerPS);
            sprintf(msg,"Turning PairSpec ON.");
            pvPut(msg);
            epicsThreadSleep(5);
        } state turnSupplyOn

        when (powerMT==1 && powerPS==1) {} state rampToMax 
    }

    state rampToMax {

        entry {
            iSetPS = iMaxPS;
            iSetMT = iMaxMT;
            pvPut(iSetPS);
            pvPut(iSetMT);
            isOff=0;
            pvPut(isOff);
            sprintf(msg,"Ramping Up to Max");
            pvPut(msg);
            count=0;
        }

        when (offBtn) {
            offBtn=0;
            pvPut(offBtn);
        } state rampOff

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (pvConnectCount() < pvChannelCount() ) {} state init
        
        when ( isSimilar(iSetPS,iMonPS,iDeltaPS) && isSimilar(iSetMT,iMonMT,iDeltaMT) ) {} state holdAtMax
	
        when (calcBtn) {
            calcBtn=0;
            pvPut(calcBtn);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
        } state rampToMax

        when (calcBtnCurr) {
            calcBtnCurr=0;
            pvPut(calcBtnCurr);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
        } state rampToMax

        when (count > 20) {
            isError=1;
            pvPut(isError);
            sprintf(msg,"Failed to set PS/MT current.  Aborting ...");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (!isSimilar(iSetRbkPS,iSetPS,1.0)) {
            sprintf(msg,"Failed to set PS current.  Retrying ...");
            pvPut(iSetPS);
            pvPut(msg);
            epicsThreadSleep(3);
            count++;
        } state rampToMax

        when (!isSimilar(iSetRbkMT,iSetMT,1.0)) {
            sprintf(msg,"Failed to set MT current.  Retrying ...");
            pvPut(iSetMT);
            pvPut(msg);
            epicsThreadSleep(3);
            count++;
        } state rampToMax

        when () {
            complete = minComplete(0,iMonPS,iSetPS,0,iMonMT,iSetMT);
            pvPut(complete);
            sprintf(msg,"Ramping Up to Max");
            pvPut(msg);
            epicsThreadSleep(1);
        } state rampToMax
    }

    state holdAtMax {

	//option -t; // only reset delay timer if previous state was a different state
	
        entry {
            count = 0;
            complete = 0;
            pvGet(tHoldMax);
            sprintf(msg,"Saturating PairSpec for %.1f minutes",tHoldMax);
            pvPut(msg);
            pvPut(complete);
        }

        when (offBtn) {
            offBtn=0;
            pvPut(offBtn);
        } state rampOff
        
        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (pvConnectCount() < pvChannelCount() ) {} state init

        when (count>=60*tHoldMax && isSimilar2(iMonPS,iSetPS,iDeltaPS,iMonMT,iSetMT,iDeltaMT)) {
            complete = 0;
            pvPut(complete);
        } state rampToSetpoint

        when (count>=60*tHoldMax && !isSimilar2(iMonPS,iSetPS,iDeltaPS,iMonMT,iSetMT,iDeltaMT)) {
            count--;
            sprintf(msg,"Waiting, current NOT at Max.");
            pvPut(msg);
        } state holdAtMax

        when (calcBtn) {
            calcBtn=0;
            pvPut(calcBtn);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
        } state holdAtMax
        
        when (calcBtnCurr) {
            calcBtnCurr=0;
            pvPut(calcBtnCurr);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
        } state holdAtMax
	
        when (delay(1.0)) {
            %% complete = (float)(count) / (60*tHoldMax);
            pvPut(complete);
            sprintf(msg,"Holding at Max for %ds",(int)(60*tHoldMax-count));
            pvPut(msg);
            count++;
        } state holdAtMax
    }

    state rampToSetpoint {

        entry {
            complete = 1;
            pvGet(energy);
            iStartPS = iMonPS;
            iStartMT = iMonMT;
            pvGet(iCalcPS);
            pvGet(iCalcMT);
            iSetPS = iCalcPS;
            iSetMT = iCalcMT;
            sprintf(msg,"Ramping Down to Setpoint");
            pvPut(iSetPS);
            pvPut(iSetMT);
            pvPut(msg);
            pvPut(complete);
        }
        
        when (offBtn) {
            offBtn=0;
            pvPut(offBtn);
        } state rampOff

        when (abtBtn) {
            sprintf(msg,"Sequence Aborted");
            pvPut(msg);
            epicsThreadSleep(5);
        } state idle

        when (pvConnectCount() < pvChannelCount() ) {} state init

        when ( isSimilar2(iSetPS,iMonPS,iDeltaPS,iSetMT,iMonMT,iDeltaMT) ) {
            complete=1;
            pvPut(complete);
        } state ready
        
        when (calcBtn) {
            calcBtn=0;
            pvPut(calcBtn);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
            sprintf(msg,"Ramping Down to Setpoint");
            pvPut(msg);
            count++;
        } state rampToSetpoint

        when (calcBtnCurr) {
            calcBtnCurr=0;
            pvPut(calcBtnCurr);
            sprintf(msg,"Must turn OFF to Recalculate");
            pvPut(msg);
            epicsThreadSleep(1);
            sprintf(msg,"Ramping Down to Setpoint");
            pvPut(msg);
            count++;
        } state rampToSetpoint
	
        when () {
            complete = 1-minComplete(iStartPS,iMonPS,iSetPS,iStartMT,iMonMT,iSetMT);
            pvPut(complete);
        } state rampToSetpoint
    }
}






ss seqChicaneDrive {
    
    state init {
        when (pvConnectCount() == pvChannelCount()) {} state idle
    }

    state idle {
        
        when (gotoMaxBtn) {
            gotoMaxBtn=0;
            pvPut(gotoMaxBtn);
            iStartPS=iMonPS;
            iStartMT=iMonMT;
            for (countDriver=1; countDriver<=10; ++countDriver) {
                iMonPS = getRampCurrent(countDriver,10,iStartPS,iMaxPS);
                iMonMT = getRampCurrent(countDriver,10,iStartMT,iMaxMT);
                pvPut(iMonPS);
                pvPut(iMonMT);
                epicsThreadSleep(0.3);
            }
            iMonPS=iMaxPS;
            iMonMT=iMaxMT;
            pvPut(iMonPS);
            pvPut(iMonMT);
        } state idle
    
        when (gotoSetBtn) {
            gotoSetBtn=0;
            pvPut(gotoSetBtn);
            iStartPS=iMonPS;
            iStartMT=iMonMT;
            for (countDriver=1; countDriver<=10; ++countDriver) {
                iMonPS = getRampCurrent(countDriver,10,iStartPS,iSetPS);
                iMonMT = getRampCurrent(countDriver,10,iStartMT,iSetMT);
                pvPut(iMonPS);
                pvPut(iMonMT);
                epicsThreadSleep(0.3);
            }
            iMonPS=iSetPS;
            iMonMT=iSetMT;
            pvPut(iMonPS);
            pvPut(iMonMT);
        } state idle
        
        when (gotoZeroBtn) {
            gotoZeroBtn=0;
            pvPut(gotoZeroBtn);
            iStartPS=iMonPS;
            iStartMT=iMonMT;
            for (countDriver=1; countDriver<=10; ++countDriver) {
                iMonPS=getRampCurrent(countDriver,10,iStartPS,0);
                iMonMT=getRampCurrent(countDriver,10,iStartMT,0);
                pvPut(iMonPS);
                pvPut(iMonMT);
                epicsThreadSleep(0.3);
            }
            iMonPS=0;
            iMonMT=0;
            pvPut(iMonPS);
            pvPut(iMonMT);
        } state idle
    }
}

