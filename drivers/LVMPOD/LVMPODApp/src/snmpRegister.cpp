/*snmpRegister.cpp */

#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

#include "iocsh.h"

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

int epicsSnmpInit(int);

static const iocshArg epicsSnmpInitArg0 = {"value", iocshArgInt};

static const iocshArg *const epicsSnmpInitArgs[1] =
{
   &epicsSnmpInitArg0,
};

static const iocshFuncDef epicsSnmpInitDef = {"epicsSnmpInit", 1, epicsSnmpInitArgs};
static void epicsSnmpInitCall(const iocshArgBuf * args) {
	epicsSnmpInit(args[0].ival);
};

int snmpHostsShow(void);

static const iocshFuncDef snmpHostsShowDef = {"snmpHostsShow", 0, 0};
static void snmpHostsShowCall(const iocshArgBuf * args) {
	snmpHostsShow();
};

int snmpSessionsShow(void);

static const iocshFuncDef snmpSessionsShowDef = {"snmpSessionsShow", 0, 0};
static void snmpSessionsShowCall(const iocshArgBuf * args) {
	snmpSessionsShow();
};

#if	0
static const iocshFuncDef epicsSnmpInitDef =
    {"epicsSnmpInit", 0, 0};
static void epicsSnmpInitCall(const iocshArgBuf * args) {
	epicsSnmpInit();
}
#endif

/*--------------------------------------------------------------------*/
/* NSCL - Feb 2009 - J.Priller                                        */
/* added functions                                                    */
/*--------------------------------------------------------------------*/

int epicsSnmpSetSnmpVersion(char *hostName, char *versionStr);

static void iocsh_epicsSnmpSetSnmpVersion(const iocshArgBuf *args)
{
  char *host = args[0].sval;
  char *vers = args[1].sval;

  epicsSnmpSetSnmpVersion(host,vers);
}

static const iocshArg iocsh_epicsSnmpSetSnmpVersion_Arg0 = { "host", iocshArgString };
static const iocshArg iocsh_epicsSnmpSetSnmpVersion_Arg1 = { "version", iocshArgString };
static const iocshArg * const iocsh_epicsSnmpSetSnmpVersion_Args[2] =
  {&iocsh_epicsSnmpSetSnmpVersion_Arg0,
   &iocsh_epicsSnmpSetSnmpVersion_Arg1};
static const iocshFuncDef iocsh_epicsSnmpSetSnmpVersion_FuncDef = {"epicsSnmpSetSnmpVersion",2,iocsh_epicsSnmpSetSnmpVersion_Args};

/*--------------------------------------------------------------------*/

int epicsSnmpSetMaxOidsPerReq(char *hostName, int maxoids);

static void iocsh_epicsSnmpSetMaxOidsPerReq(const iocshArgBuf *args)
{
  char *host = args[0].sval;
  char max   = args[1].ival;

  epicsSnmpSetMaxOidsPerReq(host,max);
}

static const iocshArg iocsh_epicsSnmpSetMaxOidsPerReq_Arg0 = { "host", iocshArgString };
static const iocshArg iocsh_epicsSnmpSetMaxOidsPerReq_Arg1 = { "maxoids", iocshArgInt };
static const iocshArg * const iocsh_epicsSnmpSetMaxOidsPerReq_Args[2] =
  {&iocsh_epicsSnmpSetMaxOidsPerReq_Arg0,
   &iocsh_epicsSnmpSetMaxOidsPerReq_Arg1};
static const iocshFuncDef iocsh_epicsSnmpSetMaxOidsPerReq_FuncDef = {"epicsSnmpSetMaxOidsPerReq",2,iocsh_epicsSnmpSetMaxOidsPerReq_Args};

/*--------------------------------------------------------------------*/

int devSnmpSetDebug(int level);
static void iocsh_devSnmpSetDebug(const iocshArgBuf *args)
{
  int level = args[0].ival;
  devSnmpSetDebug(level);
}

static const iocshArg iocsh_devSnmpSetDebug_Arg0 = { "state", iocshArgInt };
static const iocshArg * const iocsh_devSnmpSetDebug_Args[1] =
  {&iocsh_devSnmpSetDebug_Arg0};
static const iocshFuncDef iocsh_devSnmpSetDebug_FuncDef = {"devSnmpSetDebug",1,iocsh_devSnmpSetDebug_Args};

/*--------------------------------------------------------------------*/

int snmpr(int level, char *match);
static void iocsh_snmpr(const iocshArgBuf *args)
{
  int level = args[0].ival;
  char *match = args[1].sval;

  snmpr(level,match);
}

static const iocshArg iocsh_snmpr_Arg0 = { "level", iocshArgInt };
static const iocshArg iocsh_snmpr_Arg1 = { "match", iocshArgString };
static const iocshArg * const iocsh_snmpr_Args[2] =
  {&iocsh_snmpr_Arg0,
   &iocsh_snmpr_Arg1};
static const iocshFuncDef iocsh_snmpr_FuncDef = {"snmpr",2,iocsh_snmpr_Args};

/*--------------------------------------------------------------------*/
int snmpz(void);
static void iocsh_snmpz(const iocshArgBuf *args)
{
  snmpz();
}

static const iocshFuncDef iocsh_snmpz_FuncDef = {"snmpz",0,NULL};

/*--------------------------------------------------------------------*/
int snmpzr(int level, char *match);
static void iocsh_snmpzr(const iocshArgBuf *args)
{
  int level = args[0].ival;
  char *match = args[1].sval;

  snmpzr(level,match);
}

static const iocshArg iocsh_snmpzr_Arg0 = { "level", iocshArgInt };
static const iocshArg iocsh_snmpzr_Arg1 = { "match", iocshArgString };
static const iocshArg * const iocsh_snmpzr_Args[2] =
  {&iocsh_snmpzr_Arg0,
   &iocsh_snmpzr_Arg1};
static const iocshFuncDef iocsh_snmpzr_FuncDef = {"snmpzr",2,iocsh_snmpzr_Args};

/*--------------------------------------------------------------------*/
/* end of NSCL functions                                              */
/*--------------------------------------------------------------------*/

void snmp_Register()
{
   static int firstTime = 1;

   if  (!firstTime)
      return;
   firstTime = 0;
   iocshRegister(&epicsSnmpInitDef, epicsSnmpInitCall);
   iocshRegister(&snmpSessionsShowDef, snmpSessionsShowCall);
   iocshRegister(&snmpHostsShowDef, snmpHostsShowCall);
   /* NSCL - Feb 2009 - J.Priller
      register added functions */
   iocshRegister(&iocsh_epicsSnmpSetSnmpVersion_FuncDef, iocsh_epicsSnmpSetSnmpVersion);
   iocshRegister(&iocsh_devSnmpSetDebug_FuncDef,         iocsh_devSnmpSetDebug);
   iocshRegister(&iocsh_snmpr_FuncDef,                   iocsh_snmpr);
   iocshRegister(&iocsh_snmpz_FuncDef,                   iocsh_snmpz);
   iocshRegister(&iocsh_snmpzr_FuncDef,                  iocsh_snmpzr);
   /* NSCL - Oct 2009 - J.Priller
      register added functions */
   iocshRegister(&iocsh_epicsSnmpSetMaxOidsPerReq_FuncDef, iocsh_epicsSnmpSetMaxOidsPerReq);
   /* end of NSCL functions */
}

#ifdef __cplusplus
}
#endif	/* __cplusplus */
class snmp_CommonInit {
    public:
    snmp_CommonInit() {
	snmp_Register();
    }
};
static snmp_CommonInit snmp_CommonInitObj;
