/* snmpMain.cpp */
/* Author:  Marty Kraimer Date:    17MAR2000 */

#include <stddef.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <epicsStdioRedirect.h>

/* NSCL - Feb 2009 - J.Priller
   R3.14.6 doesn't define epicsExit(), include dummy func if detected */
#include "epicsVersion.h"
#if (EPICS_VERSION>=3) && (EPICS_REVISION>=14) && (EPICS_MODIFICATION>=7)
#include "epicsExit.h"
#else
static void epicsExit(int code)
{
  /* dummy function, do nothing */
}
#endif

#include "epicsThread.h"
#include "iocsh.h"

int main(int argc,char *argv[])
{
    if(argc>=2) {
        iocsh(argv[1]);
        epicsThreadSleep(.2);
    }
    iocsh(NULL);
    epicsExit(0);
    return(0);
}
