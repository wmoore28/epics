#include <stdio.h>
#include <string.h>
#include <registryFunction.h>
#include <subRecord.h>
#include <aSubRecord.h>
#include <epicsExport.h>
#include "commonSocket.h"
#include "commonXml.h"
#include "commonDoc.h"
#include <libxml/parser.h>
//#include <dbAccess.h>
#include <cadef.h>


int mySubDebug = 0;
int process_order = 0;
int socketFD = -1;
char host[256];
xmlDoc* xmldoc = NULL;
char socketPollStatusStr[256];

static long subPollInit(subRecord *precord) {
  process_order++;
  if (mySubDebug>-1) {
    printf("[ subPollInit ] %d Record %s called subPollInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  
  return 0;
}


static long subPollProcess(subRecord *precord) {

  process_order++;
  if (mySubDebug>-1)
    printf("[ subPollProcess ]: %d Record %s called subPollProcess(%p)\n",process_order, precord->name, (void*) precord);

  int port;
  int idpm;
  char str0[256];
  char str1[256];  

  strcpy(socketPollStatusStr,"undefined");

  // find dpm nr
  getStringFromEpicsName(precord->name,str0,0,256);
  getStringFromEpicsName(precord->name,str1,1,256);
  if(strcmp(str0,"SVT")==0 && (strcmp(str1,"dpm")==0 || strcmp(str1,"dtm")==0)) {
    idpm = getIntFromEpicsName(precord->name,2);  
  } else {
    printf("[ subPollProcess ]: Wrong precord name to call this function?!  (%s)\n", precord->name);    
    exit(1);
  }
  
  if(strcmp(str1,"dpm")==0) {
    sprintf(host,"dpm%d",idpm);
  }
  else {
    sprintf(host,"dtm%d",idpm);    
  }

  if(xmldoc!=NULL) {
    if (mySubDebug>-1) printf("[ subPollProcess ]: dpm doc is not null(%p). Clean up.\n", xmldoc);
    xmlFreeDoc(xmldoc);
    xmlCleanupParser();      
    xmldoc = NULL;
  }


  //reset file desc
  socketFD = -1;
  // default searching start here
  port = 8090;

  while(socketFD<0 && port < 8100) {
     socketFD = open_socket(host,port);
     port++;
  }



  if(socketFD>0) {
     printf("[ subPollProcess ]: successfully opened socket at %d (port=%d)\n", socketFD, port);

     sprintf(str0,"socket opened (%s:%d)",host,port);
     strcpy(socketPollStatusStr,str0);


    if (mySubDebug>0)
      printf("[ subPollProcess ]: get the xml doc\n");
    
    getDpmXmlDoc(socketFD, idpm, &xmldoc, str1);
    
    
    if (mySubDebug>-1)
      printf("[ subPollProcess ]: found xml doc at %p\n", xmldoc);


    printf("[ subPollProcess ]: close socket %d\n", socketFD);

    socketFD = close_socket(socketFD);

        
  } else {
    printf("[ subPollProcess ]: [ WARNING ]: failed to open socket\n");

    strcpy(socketPollStatusStr,"couldn't open socket");

  }


  return 0;
}


static long subDpmStateInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmStateInit ]: %d Record %s called subDpmStateInit(%p)\n", process_order, precord->name, (void*) precord);
  }

  strcpy(precord->vala,"init...");

  return 0;
}

static long subDpmStateProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmStateProcess ]: %d Record %s called subDpmStateProcess(%p)\n",process_order, precord->name, (void*) precord);
  }

  char state[256];
  strcpy(precord->vala, "default");

  getRunStateProcess(precord->name, xmldoc, state);

  strcpy(precord->vala, state);

  
  return 0;
}


static long subDpmStatusInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmStatusInit ]: %d Record %s called subDpmStatusInit(%p)\n", process_order, precord->name, (void*) precord);
  }
/*
  strcpy(precord->vala,"init...");
  precord->valb = 99;
  strcpy(precord->vala,"init...");
*/
  return 0;
}

static long subDpmStatusProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmStatusProcess ]: %d Record %s called subDpmStatusProcess(%p)\n",process_order, precord->name, (void*) precord);
  }




  int heart_beat;
  char status[256];
  long *b;
  heart_beat = 99;
  strcpy(precord->vala, "no valid status");
  b = (long*) precord->valb;
  *b = (long) heart_beat;

  if(strlen(socketPollStatusStr)>0) {
     strcpy(precord->valc, socketPollStatusStr);
  } else {
     strcpy(precord->valc, "whatta f");
  }
  
  getDpmStatusProcess(precord->name, xmldoc, status, &heart_beat);

  strcpy(precord->vala, status);
  *b = (long) heart_beat;


  return 0;
}




static long subDpmFebNumInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmFebNumInit ]: %d Record %s called subDpmFebNumInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmFebNumProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmFebNumProcess ]: %d Record %s called subDpmFebNumProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getFebNumProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}

static long subDpmLinkInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmLinkInit ]: %d Record %s called subDpmLinkInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmLinkProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmLinkProcess ]: %d Record %s called subDpmLinkProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getLinkProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDpmEventCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subEventCountInit ]: %d Record %s called subDpmEventCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmEventCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmEventCountProcess ]: %d Record %s called subDpmEventCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getEventCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}

static long subDpmBurnCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subBurnCountInit ]: %d Record %s called subDpmBurnCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmBurnCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmBurnCountProcess ]: %d Record %s called subDpmBurnCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getBurnCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDpmBlockCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subBlockCountInit ]: %d Record %s called subDpmBlockCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmBlockCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmBlockCountProcess ]: %d Record %s called subDpmBlockCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getBlockCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDpmEventStateInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subEventStateInit ]: %d Record %s called subDpmEventStateInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmEventStateProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmEventStateProcess ]: %d Record %s called subDpmEventStateProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getEventStateProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDpmSystemStateInit(aSubRecord *precord) {
   process_order++;
   if (mySubDebug) {
      printf("[ subSystemStateInit ]: %d Record %s called subDpmSystemStateInit(%p)\n", process_order, precord->name, (void*) precord);
   }
   return 0;
}

static long subDpmSystemStateProcess(aSubRecord *precord) {
   process_order++;
   if (mySubDebug) {
      printf("[ subDpmSystemStateProcess ]: %d Record %s called subDpmSystemStateProcess(%p)\n",process_order, precord->name, (void*) precord);
   }
   char val[256];
   
   getSystemStateProcess(precord->name, xmldoc, val);
   
   char* a;
   
   a = (char*) precord->vala;
   strcpy(a, val);
   
   
   return 0;
}



static long subDpmTrigCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subTrigCountInit ]: %d Record %s called subDpmTrigCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDpmTrigCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDpmTrigCountProcess ]: %d Record %s called subDpmTrigCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getTrigCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDtmTrigCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subTrigCountInit ]: %d Record %s called subDtmTrigCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDtmTrigCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDtmTrigCountProcess ]: %d Record %s called subDtmTrigCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getDtmTrigCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subDtmReadCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subReadCountInit ]: %d Record %s called subDtmReadCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDtmReadCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDtmReadCountProcess ]: %d Record %s called subDtmReadCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getDtmReadCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}



static long subDtmAckCountInit(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDtmAckCountInit ]: %d Record %s called subDtmAckCountInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDtmAckCountProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subDtmAckCountProcess ]: %d Record %s called subDtmAckCountProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getDtmAckCountProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}

static long subDtmMinTrigPeriodInit(subRecord *precord) {
  process_order++;
  if (mySubDebug>-1) {
    printf("[ subDtmMinTrigPeriodInit ]: %d Record %s called subDtmMinTrigPeriodInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subDtmMinTrigPeriodProcess(subRecord *precord) {
  process_order++;
  if (mySubDebug-1) {
    printf("[ subDtmMinTrigPeriodProcess ]: %d Record %s called subDtmMinTrigPeriodProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int val = -1;

  val = getDtmMinTrigPeriodProcess(precord->name, xmldoc);

  precord->val = val;

  
  return 0;
}


static long subHybridSwitchInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subTrigCountInit ]: %d Record %s called subHybridSwitchInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}

static long subHybridSwitchProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subHybridSwitchProcess ]: %d Record %s called subHybridSwitchProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  int socket;
  int p;
  char hostname[EPICS_STRING_SIZE];


  if (mySubDebug) printf("[ subHybridSwitchProcess ]: find the FEB layer\n");

  // ---
  // find the layer in order to manage existing hybrids on the FEB's  
  
  const char* layer = (char*)precord->a;

  if (mySubDebug) printf("[ subHybridSwitchProcess ]: got \"%s\" at %p\n",layer,layer);


  // ---
  

  // ---
  // open socket
  socket = -1;
  p = 8089;
  strcpy(hostname,"dpm7");
  while(socket<0 && p < 8100) {
     p++;
     socket = open_socket(hostname,p);
  }
  // ---

  
  
  if(socket>0) {
     printf("[ subHybridSwitchProcess ]: successfully opened socket at %d (port=%d)\n", socket, p);
     
     if (mySubDebug) printf("[ subHybridSwitchProcess ] : Flush socket.\n");
     
     flushSocket(socket);
     
     if (mySubDebug) printf("[ subHybridSwitchProcess ] : Done flushing socket.\n");

     writeHybridSwitchProcess(precord->name, precord->val, socket, layer);

     if (mySubDebug) printf("[ subHybridSwitchProcess ] : Flush socket after writing.\n");
     
     flushSocket(socket);

     if (mySubDebug) printf("[ subHybridSwitchProcess ]: close socket %d\n", socketFD);
     
     socket = close_socket(socket);
     
        
  } else {
    printf("[ subHybridSwitchProcess ]: [ WARNING ]: failed to open socket\n");
  }
  
  
  return 0;
}

static long subSyncInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subSyncInit ]: %d Record %s called subSyncInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}


static long subSyncProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subSyncProcess ]: %d Record %s called subSyncProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  
  char val[256];
  int number;
  long *a;

  if (mySubDebug)
     printf("[ subSyncProcess ]: get sync string from xml at %p\n", xmldoc);

  
  getHybSync(precord->name, xmldoc, val);

  if (mySubDebug)
     printf("[ subSyncProcess ]: got sync string \"%s\"\n", val);
  
  number = (int) strtol(val,NULL,0); // string rep begins with 0x so use base=0 instead of 16

  if (mySubDebug)
     printf("[ subSyncProcess ]: got sync number \"%d\"\n", number);

  
  a = (long*) precord->vala;
  *a = (long) number;
  
  
  return 0;
}

static long subSyncBaseInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subSyncBaseInit ]: %d Record %s called subSyncBaseInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}


static long subSyncBaseProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subSyncBaseProcess ]: %d Record %s called subSyncBaseProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  
  char val[256];
  int number;
  long *a;
  
  if (mySubDebug)
     printf("[ subSyncProcess ]: get sync string from xml at %p\n", xmldoc);

  getSyncProcess(precord->name, xmldoc, val);
  
  if (mySubDebug)
     printf("[ subSyncBaseProcess ]: got sync string \"%s\"\n", val);
  
  number = (int) strtol(val,NULL,0); // string rep begins with 0x so use base=0 instead of 16

  if (mySubDebug)
     printf("[ subSyncProcess ]: got sync number \"%d\"\n", number);

  
  a = (long*) precord->vala;
  *a = (long) number;


  return 0;
}


static long subInsertedFramesInit(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subInsertedFramesInit ]: %d Record %s called subInsertedFramesInit(%p)\n", process_order, precord->name, (void*) precord);
  }
  return 0;
}


static long subInsertedFramesProcess(aSubRecord *precord) {
  process_order++;
  if (mySubDebug) {
    printf("[ subInsertedFramesProcess ]: %d Record %s called subInsertedFramesProcess(%p)\n",process_order, precord->name, (void*) precord);
  }
  
  char val[256];
  int number;
  long *a;
  
  if (mySubDebug)
     printf("[ subSyncProcess ]: get string from xml at %p\n", xmldoc);

  getInsertedFramesProcess(precord->name, xmldoc, val);
  
  if (mySubDebug)
     printf("[ subInsertedFramesProcess ]: got sync string \"%s\"\n", val);
  
  number = (int) strtol(val,NULL,0); // string rep begins with 0x so use base=0 instead of 16

  if (mySubDebug)
     printf("[ subSyncProcess ]: got sync number \"%d\"\n", number);

  
  a = (long*) precord->vala;
  *a = (long) number;


  return 0;
}





/* Register these symbols for use by IOC code: */

epicsExportAddress(int, mySubDebug);
epicsRegisterFunction(subPollInit);
epicsRegisterFunction(subPollProcess);
epicsRegisterFunction(subDpmStateInit);
epicsRegisterFunction(subDpmStateProcess);
epicsRegisterFunction(subDpmStatusInit);
epicsRegisterFunction(subDpmStatusProcess);
epicsRegisterFunction(subDpmFebNumInit);
epicsRegisterFunction(subDpmFebNumProcess);
epicsRegisterFunction(subDpmLinkInit);
epicsRegisterFunction(subDpmLinkProcess);
epicsRegisterFunction(subDpmEventCountInit);
epicsRegisterFunction(subDpmEventCountProcess);
epicsRegisterFunction(subDpmTrigCountInit);
epicsRegisterFunction(subDpmTrigCountProcess);
epicsRegisterFunction(subDtmTrigCountInit);
epicsRegisterFunction(subDtmTrigCountProcess);
epicsRegisterFunction(subDtmReadCountInit);
epicsRegisterFunction(subDtmReadCountProcess);
epicsRegisterFunction(subDtmAckCountInit);
epicsRegisterFunction(subDtmAckCountProcess);
epicsRegisterFunction(subDpmEventStateInit);
epicsRegisterFunction(subDpmEventStateProcess);
epicsRegisterFunction(subDpmBlockCountInit);
epicsRegisterFunction(subDpmBlockCountProcess);
epicsRegisterFunction(subDpmSystemStateInit);
epicsRegisterFunction(subDpmSystemStateProcess);
epicsRegisterFunction(subHybridSwitchInit);
epicsRegisterFunction(subHybridSwitchProcess);
epicsRegisterFunction(subSyncInit);
epicsRegisterFunction(subSyncProcess);
epicsRegisterFunction(subSyncBaseInit);
epicsRegisterFunction(subSyncBaseProcess);
epicsRegisterFunction(subDpmBurnCountInit);
epicsRegisterFunction(subDpmBurnCountProcess);
epicsRegisterFunction(subDtmMinTrigPeriodInit);
epicsRegisterFunction(subDtmMinTrigPeriodProcess);
epicsRegisterFunction(subInsertedFramesInit);
epicsRegisterFunction(subInsertedFramesProcess);

