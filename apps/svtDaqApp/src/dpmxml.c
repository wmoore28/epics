#include <string.h>
#include "commonConstants.h"
#include "dpmxml.h"










/* void getHybridFromDpmValues(xmlDocPtr doc, int** hybrids) { */
/*    xmlXPathObjectPtr result; */
/*    xmlNodeSetPtr nodeset; */
/*    xmlNodePtr node; */
/*    xmlChar hexvalue[256]; */
/*    long int number; */
/*    int i; */
/*    result = getHybridFromDpm(doc); */
/*    if(result!=NULL) { */
/*    //if(DEBUG>2) { */
/*      printf("[ getHybridFromDpmValues ] : got %d nodes\n", result->nodesetval->nodeNr); */
/*      nodeset = result->nodesetval; */
/*      if( result->nodesetval->nodeNr != 4 ) { */
/*        printf("[ getHybridFromDpmValues ] : [ ERROR ]: got more than 4 hybrid nodes (%d) from the dpm\n", result->nodesetval->nodeNr); */
/*        return; */
/*      } */
/*      for(i=0;i<nodeset->nodeNr;++i) { */
/*        //if(DEBUG>2) { */
/*        printf("[ getHybridFromDpmValues ] : node i=%d\n", i);        */
/*        node = nodeset->nodeTab[i]; */
/*        printf("[ getHybridFromDpmValues ] : node i=%d at %p\n", i, node);        */
/*        if(node!=NULL) { */
/* 	 getStrValue(doc, node, hexvalue);    */
/* 	 //if(DEBUG>2) { */
/* 	 printf("[ getHybridFromDpmValues ] : i=%d hexstr %s\n", i, hexvalue); */
/* 	 number = strtol((char*)hexvalue, NULL, 0); */
/* 	 //if(DEBUG>2) { */
/* 	 printf("[ getHybridFromDpmValues ] : i=%d hexstr %s -> number %ld\n", i, hexvalue, number); */
/* 	 hybrids[i] = (int)number; */
/* 	 //if(DEBUG>2) { */
/* 	 printf("[ getHybridFromDpmValues ] : i=%d hybrid %d\n", i, (int)number); */
/*        } else { */
/* 	 //if(DEBUG>2) { */
/* 	 printf("[ getHybridFromDpmValues ] : [ WARNING ] :  node at index %d is null!\n", i);	  */
/*        } */
/*      } */
/*    } */
/*    else { */
/*      printf("[ getHybridFromDpmValues ] : no nodes found\n"); */
/*    } */
/*    return; */
/* } */
