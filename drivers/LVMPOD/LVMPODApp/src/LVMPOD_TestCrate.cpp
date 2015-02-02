#include "LVMPODCrate.h"

#include <epicsExport.h>
#include <iocsh.h>

int testipaddress(const char*ipaddress,string *IP, string *NAME){
  // test if argument is ip address or ip name
  string val(ipaddress);
  string cmd = "host "+val;
  FILE *io;
  char buff[512];
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  string res(buff);
  int n=0;
  int loc = res.find("name pointer");
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
    res.erase(0,loc1+12);
    res.erase(res.size()-1,res.size()-1);
    *IP = res;
    *NAME = val;
  }
  return n;
}

void LVMPOD_TestCrate(const char*ipaddress){
  
  string IP,NAME;
  int res = testipaddress(ipaddress, &IP, &NAME);
  if (res>-1){
    MpodCrate Crate1(IP,NAME);
  }
}


/* Information needed by iocsh */
static const iocshArg      LVMPOD_TestCrateArg0 = {"ipaddress", iocshArgString};
static const iocshArg    * LVMPOD_TestCrateArgs[] = {&LVMPOD_TestCrateArg0};
static const iocshFuncDef  LVMPOD_TestCrateFuncDef = {"LVMPOD_TestCrate", 1, LVMPOD_TestCrateArgs};

/* Wrapper called by iocsh, selects the argument types that LVMPOD_TestCrate needs */
static void LVMPOD_TestCrateCallFunc(const iocshArgBuf *args) {
    LVMPOD_TestCrate(args[0].sval);
}

/* Registration routine, runs at startup */
static void LVMPOD_TestCrateRegister(void) {
    iocshRegister(&LVMPOD_TestCrateFuncDef, LVMPOD_TestCrateCallFunc);
}
epicsExportRegistrar(LVMPOD_TestCrateRegister);
