#include "string.h"
#include "febxml.h"
#include "commonConstants.h"
#include "commonXml.h"

xmlXPathObjectPtr getFebTemps(xmlDocPtr doc, const char* type) {
   char tmp[256];
   sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/SoftPowerMonitor/%s",type);
   if(DEBUG>1) printf("[ getFebTemps ] : xpath %s\n", tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getFebTempNode(xmlDocPtr doc, const char* type, int index) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getFebTemps(doc, type);
   if(DEBUG>1) printf("[ getFebTempNode ] : found result at %p\n", result);
   node = getFebNode(doc, result, index, 3, (xmlChar*) "FebFpga");
   if(DEBUG>1) printf("[ getFebTempNode ] : found node at %p\n", node);
   return node;
}

double getFebTempValue(xmlDocPtr doc, const char* type, int index) {
   double t;
   xmlNodePtr node;
   node = getFebTempNode(doc,type, index);
   if(DEBUG>1) printf("[ getFebTempValue ] : found node at %p\n", node);
   t = getFloatValue(doc, node);
   if(DEBUG>1) printf("[ getFebTempValue ] : got t %f\n",t);
   return t;
}




xmlXPathObjectPtr getFebDna(xmlDocPtr doc) {
   char tmp[256];
   //sprintf(tmp,"/system/status/ControlDpm/FebFpga/AxiVersion/DeviceDna");
   strcpy(tmp,"/system/status/ControlDpm/FebFpga/AxiVersion/DeviceDna");
   if(DEBUG>2) printf("[ getFebDna ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getFebDnaNode(xmlDocPtr doc, int index) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getFebDna(doc);
   if(result!=NULL) {
     if(DEBUG>2) 
       printf("[ getFebDnaNode ] : got %d nodes\n", result->nodesetval->nodeNr);
     node = getFebNode(doc, result, index, 2, (xmlChar*) "FebFpga");
   } else { 
     if(DEBUG>2)   
       printf("[ getFebDnaNode ] : no nodes found\n");
     node = NULL;
   }
   return node;
}

void getFebDnaValue(xmlDocPtr doc,int index, xmlChar* dna) {
  xmlNodePtr node;
  node = getFebDnaNode(doc,index);
  if(node!=NULL) {
    if(DEBUG>1)
      printf("[ getFebDnaValue ] : get str value from node %s\n", node->name);
    getStrValue(doc, node, dna);   
  } else {
    if(DEBUG>1)
      printf("[ getFebDnaValue ] : no valid xml node found\n");
    strcpy((char*) dna,"no xml node");
  }
  if(DEBUG>1)     
    printf("[ getFebDnaValue ] : got value %s\n", (char*)dna);
}
















