#include <stddef.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>

#include <epicsExport.h>
#include <iocsh.h>

#include "LVMPODCrate.h"
#include "LVMPOD.h"

int probeIPaddress(const char*ipaddress,string *IP, string *NAME){
  // test if argument is ip address or ip name
  string val(ipaddress);
  string cmd = "host "+val;
  FILE *io;
  char buff[512];
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  string res(buff);
  int n=0;
  int loc = res.find("not found");
  if (loc>0){
    n = -1;
    return n;
  }
  loc = res.find("name pointer");
  if (loc>0){
    n=1; // ipaddress is an ipddress
    res.erase(0,loc+13);
    int loc1 =  res.find(".jlab.org");
    res.erase(loc1,res.size()-1);
    *IP = val;
    *NAME = res;
  } else{
    n=0; // ipaddress is a name
    int loc1 =  res.find("has address");
    if (loc1>0) { 
      res.erase(0,loc1+12);
      res.erase(res.size()-1,res.size()-1);
      *IP = res;
      *NAME = val;
    }
  }
  return n;
}

void LVMPOD_InitCrate(const char*ipaddress){

  string IP,NAME;
  int foundCrate = probeIPaddress(ipaddress, &IP, &NAME);
  if (foundCrate>-1){
    string ip = IP;
    int i=0;
    while( (LVCrates[i]!=NULL) && (i<MAX_LVCRATES)){
      i++;
    }
    if (i<MAX_LVCRATES){
      MpodCrate *C = new MpodCrate(IP,NAME); 
      LVCrates[i] = C;
    } else{
      cout<<"Error LVMPOD_InitCrate(): Maximum number of MPOD crates exeeded"<<endl;
    }
  } else {
    cout<< "Error LVMPOD_InitCrate(): no such IP address %d"<<IP<<endl;
  }
  
}

/* Information needed by iocsh */
static const iocshArg     LVMPOD_InitCrateArg0 = {"name", iocshArgString};
static const iocshArg    *LVMPOD_InitCrateArgs[] = {&LVMPOD_InitCrateArg0};
static const iocshFuncDef LVMPOD_InitCrateFuncDef = {"LVMPOD_InitCrate", 1, LVMPOD_InitCrateArgs};

/* Wrapper called by iocsh, selects the argument types that LVMPOD_InitCrate needs */
static void LVMPOD_InitCrateCallFunc(const iocshArgBuf *args) {
    LVMPOD_InitCrate(args[0].sval);
}

/* Registration routine, runs at startup */
static void LVMPOD_InitCrateRegister(void) {
    iocshRegister(&LVMPOD_InitCrateFuncDef, LVMPOD_InitCrateCallFunc);
}

epicsExportRegistrar(LVMPOD_InitCrateRegister);

