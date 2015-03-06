#include <stdio.h>
#include <registryFunction.h>
#include <subRecord.h>
#include <aSubRecord.h>
#include <epicsExport.h>
#include "commonSocket.h"
#include "commonXml.h"
#include "commonDoc.h"
#include <libxml/parser.h>


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

  strcpy(socketPollStatusStr,"undefined");

  // find dpm nr
  int idpm;
  char str0[256];
  char str1[256];  
  getStringFromEpicsName(precord->name,str0,0);
  getStringFromEpicsName(precord->name,str1,1);
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
    printf("[ subPollProcess ]: dpm doc is not null(%p). Clean up.\n", xmldoc);
    xmlFreeDoc(xmldoc);
    xmlCleanupParser();      
    xmldoc = NULL;
  }



  socketFD = open_socket(host,8090);




  if(socketFD>0) {
    printf("[ subPollProcess ]: successfully opened socket at %d\n", socketFD);

    strcpy(socketPollStatusStr,"socket opened");


    if (mySubDebug>-1)
      printf("[ subPollProcess ]: get the xml doc\n");
    
    getDpmXmlDoc(socketFD, idpm, &xmldoc, str1);
    
    
    if (mySubDebug>-1)
      printf("[ subPollProcess ]: found xml doc at %p\n", xmldoc);
        
  } else {
    printf("[ subPollProcess ]: [ WARNING ]: failed to open socket\n");

    strcpy(socketPollStatusStr,"couldnt open socket");

  }



  if(socketFD>0) {
    printf("[ subPollProcess ]: close socket %d\n", socketFD);
    socketFD = close_socket(socketFD);
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
