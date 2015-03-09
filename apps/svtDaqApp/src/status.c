#include "status.h"
#include "commonConstants.h"
#include "febxml.h"
#include <libxml/xpath.h>




int compareXmlDump(xmlDoc* doc_cur,xmlDoc* doc_prev) {
   
   int cmpRes;
   int len;
   int len_prev;
   cmpRes = 0;
   xmlChar* buf;
   xmlChar* buf_prev;
   xmlDocDumpFormatMemory (doc_cur, &buf, &len ,0);
   xmlDocDumpFormatMemory (doc_prev, &buf_prev, &len_prev ,0);
   
   if(len>0 && len_prev>0) {
      if(buf!=NULL && buf_prev!=NULL) {
         cmpRes = xmlStrEqual(buf,buf_prev);
         if(cmpRes==0) {
            if(DEBUG>1) printf("[ compareXmlDump ] : xml dump is different than previous\n");                        
         } else {
            if(DEBUG>1) printf("[compareXmlDump ] : [ WARNING ] : xml dump is the same as previous\n");                                                   
         }
      } else {
         printf("[ compareXmlDump ] : [ ERROR ] : problem comparing buffers: cur %p prev %p \n",buf, buf_prev);                        
      }
   } else {
      printf("[ compareXmlDump ] : [ WARNING ] :  buffers have invalid lengths to compare? cur %d prev %d \n", len, len_prev);
   }
   
   // free
   if(buf_prev!=NULL)
      xmlFree(buf_prev);
   if(buf!=NULL)
      xmlFree(buf);


   return cmpRes;
   
   
}


int checkNonZeroNodes(xmlDoc* document) {
   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   xmlNodePtr node;
   xmlNodePtr children;
   int i;
   int nnonzero;
   int n;
   nnonzero=0;
   result = getFebTemps(document, "FebTemp0");
   if(result!=NULL) {
      nodeset = result->nodesetval;
      if(DEBUG>1) printf("[ checkNonZeroNodes ] : found %d results \n", nodeset->nodeNr);
      for(i=0;i<nodeset->nodeNr;++i) {
         node = nodeset->nodeTab[i];
         if(node!=NULL) {
            children = node->xmlChildrenNode;
            n++;
            if(children==NULL) {
               if(DEBUG>1) printf("[ checkNonZeroNodes ] : no children found for node %s.\n", node->name);
            } else {
               if(DEBUG>1) printf("[ checkNonZeroNodes ] : found children for node %s.\n", node->name);               
               nnonzero++;
            }
         } else {
            printf("[ checkNonZeroNodes ] : [ ERROR ] :  couldn't find node!\n");
         }
      }
   } else {
      if(DEBUG>1) printf("[ checkNonZeroNodes ] : no results found.\n");
   }
   if(DEBUG>1) printf("[ checkNonZeroNodes ] : %d/%d elements had no children\n", nnonzero,n);

   // if a single element is not empty report a '1'
   if(nnonzero>0) return 0;
   else return 1;
}




int compareNodeSets(xmlDoc* document, xmlDoc* document_prev) {
   xmlXPathObjectPtr result;
   xmlXPathObjectPtr result_prev;
   xmlNodeSetPtr nodeset;
   xmlNodeSetPtr nodeset_prev;
   xmlNodePtr node;
   xmlNodePtr node_prev;
   int i;
   int ndiff;
   xmlChar* content;
   xmlChar* content_prev;
   
   result = getFebTemps(document, "FebTemp0");
   
   if(result!=NULL) {
     nodeset = result->nodesetval;
     if(DEBUG>1) printf("[ compareNodeSets ] : found %d results \n", nodeset->nodeNr);      
   } else {
     if(DEBUG>1) printf("[ compareNodeSets ] : no results found. Cannot compare. \n");      
     return 1;
   }
   
   result_prev = getFebTemps(document_prev, "FebTemp0");
   
   if(result_prev!=NULL) {
     nodeset_prev = result_prev->nodesetval;
     if(DEBUG>1) printf("[ compareNodeSets ] : found %d results for prev \n", nodeset_prev->nodeNr);      
   } else {
     if(DEBUG>1) printf("[ compareNodeSets ] : no results_prev found. Cannot compare. \n");    
     return 1;
   }
   
   if(nodeset->nodeNr != nodeset_prev->nodeNr) {
     if(DEBUG>1) printf("[ compareNodeSets ] : different number of results.  \n");      
     return 1;
   }
   
   ndiff=0;
   
   for(i=0;i<nodeset->nodeNr;++i) {
     node = nodeset->nodeTab[i];
     node_prev = nodeset_prev->nodeTab[i];
     content = xmlNodeGetContent(node);
     content_prev = xmlNodeGetContent(node_prev);
     
     if(DEBUG>1) printf("[ compareNodeSets ] : compare node      %s: %s\n", node->name, (char*) content);
     if(DEBUG>1) printf("[ compareNodeSets ] : compare node_prev %s: %s\n", node_prev->name, (char*) content_prev);
     
     if(xmlStrEqual(content, content_prev)==0) {
       if(DEBUG>1) printf("[ compareNodeSets ] : nodes are different\n");
       ndiff++;
     } else {
       if(DEBUG>1) printf("[ compareNodeSets ] : nodes are equal\n");             
     }
     
   }
   if(DEBUG>1) printf("[ compareNodeSets ] : %d/%d nodes were different\n",ndiff,nodeset->nodeNr);
   if(ndiff>0) return 0;
   else return 1;
}
