#include <string.h>
#include "hybxml.h"
#include "constants.h"


void getFebCnfCmd(int feb_id, int isopentag,  char* cmd, const int MAX) {
   char tmp[256];
   if(isopentag==0) 
      sprintf(tmp,"</FebCore></FebFpga></ControlDpm></config></system>");
   else
      sprintf(tmp,"<system><config><ControlDpm><FebFpga index=\"%d\"><FebCore>",feb_id);
   strcpy(cmd,tmp);
}






xmlXPathObjectPtr getHybVs(xmlDocPtr doc, const char* type, int hyb, const char* pos) {
   char tmp[256];
   sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/SoftPowerMonitor/Hybrid%d_%s_%s",hyb,type,pos);
   if(DEBUG>2) printf("[ getHybVs ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}


xmlNodePtr getHybVNode(xmlDocPtr doc, const char* type, int index, int hyb, const char* pos) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getHybVs(doc, type, hyb, pos);
   if(DEBUG>2) {
      if(result!=NULL)
         printf("[ getHybVNode ] : got %d nodes\n", result->nodesetval->nodeNr);
    else
       printf("[ getHybVNode ] : no nodes found\n");
   }
   node = getFebNode(doc, result, index, 3);
   if(DEBUG>2) {
      if(node!=NULL)
         printf("[ getHybVNode ] : found node %s for index %d\n",node->name, index);
      else
         printf("[ getHybVNode ] : no node found\n");
   }
   return node;
}



double getHybVValue(xmlDocPtr doc, const char* type, int index, int hyb, const char* pos) {
   double t;
   xmlNodePtr node;
   node = getHybVNode(doc,type, index, hyb, pos);
   t = getFloatValue(doc, node);
   return t;
}



xmlXPathObjectPtr getHybIs(xmlDocPtr doc, const char* type, int hyb) {
   char tmp[256];
   sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/SoftPowerMonitor/Hybrid%d_%s_Current",hyb,type);
   if(DEBUG>2) printf("[ getHybIs ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getHybINode(xmlDocPtr doc, const char* type, int index, int hyb) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getHybIs(doc, type, hyb);
   node = getFebNode(doc, result, index, 3);
   return node;
}

double getHybIValue(xmlDocPtr doc, const char* type, int index, int hyb) {
   double t;
   xmlNodePtr node;
   node = getHybINode(doc,type, index, hyb);
   t = getFloatValue(doc, node);
   return t;
}




xmlXPathObjectPtr getHybTs(xmlDocPtr doc, const char* type, int hyb) {
   char tmp[256];
   sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/PowerMonitor/Hybrid%d_%s",hyb,type);
   if(DEBUG>2) printf("[ getHybTs ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getHybTNode(xmlDocPtr doc, const char* type, int index, int hyb) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getHybTs(doc, type, hyb);
   node = getFebNode(doc, result, index, 3);
   return node;
}

double getHybTValue(xmlDocPtr doc, const char* type, int index, int hyb) {
   double t;
   xmlNodePtr node;
   node = getHybTNode(doc,type, index, hyb);
   t = getFloatValue(doc, node);
   return t;
}





xmlXPathObjectPtr getHybSwitches(xmlDocPtr doc, int hyb) {
   char tmp[256];
   sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/Hybrid%dPwrOn",hyb);
   if(DEBUG>1) printf("[ getHybSwitches ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getHybSwitchNode(xmlDocPtr doc, int index, int hyb) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getHybSwitches(doc, hyb);
   if(DEBUG>1) {
      if(result!=NULL)
         printf("[ getHybSwitchNode ] : got %d nodes\n", result->nodesetval->nodeNr);
      else
         printf("[ getHybSwitchNode ] : no nodes found\n");
   }

   node = getFebNode(doc, result, index, 2);

   if(DEBUG>1) {
      if(node!=NULL)
         printf("[ getHybSwitchNode ] : found node %s for index %d\n",node->name, index);
      else
         printf("[ getHybSwitchNode ] : no node found\n");
   }

   return node;
}

double getHybSwitchValue(xmlDocPtr doc, int index, int hyb) {
   double v;
   xmlNodePtr node;
   xmlChar value[256];
   char* tmp;
   v = 0.0;
   node = getHybSwitchNode(doc,index, hyb);
   getStrValue(doc, node, value);   
   if(value!=NULL) {
      if(xmlStrlen(value)>0) {      
         tmp = (char*) value;
         strToUpper(tmp);
         if(strcmp(tmp,"FALSE")==0) v = 0.0;
         else if(strcmp(tmp,"TRUE")==0) v = 1.0;
         else {
            printf("[ getHybSwitchValue ] : [ ERROR ] : the switch value is invalid: \"%s\"\n",tmp);
         }
      }
   } else {
      printf("[ getHybSwitchValue ] : [ WARNING ] : no switch value was found for feb %d and hyb %d\n", index, hyb);
      v=-2.0;
   }
   return v;
}



void getHybSwitchCmd(char* value, int feb_id, int hyb_id, char* cmd, const int MAX) {
   char open_tag[256];
   char close_tag[256];
   char hyb_tag[256];
   char tmp[256];
   getFebCnfCmd(feb_id,1,open_tag,256);
   getFebCnfCmd(feb_id,0,close_tag,256);
   sprintf(hyb_tag,"Hybrid%dPwrEn",hyb_id);
   sprintf(tmp,"%s<%s>%s</%s>%s\f",open_tag,hyb_tag,value,hyb_tag,close_tag);
   strcpy(cmd,tmp);
   
}













xmlXPathObjectPtr getHybTrims(xmlDocPtr doc, const char* type, int hyb) {
   char tmp[256];
   sprintf(tmp,"/system/config/ControlDpm/FebFpga/FebCore/Hybrid%d%sTrim",hyb, type);
   if(DEBUG>2) printf("[ getHybTrims ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlNodePtr getHybTrimNode(xmlDocPtr doc, const char* type, int index, int hyb) {
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   result = getHybTrims(doc, type, hyb);
   if(DEBUG>2) {
      if(result!=NULL)
         printf("[ getHybTrimNode ] : got %d nodes\n", result->nodesetval->nodeNr);
      else
      printf("[ getHybTrimNode ] : no nodes found\n");
   }
   node = getFebNode(doc, result, index, 2);
   return node;
}

int getHybTrimValue(xmlDocPtr doc, const char* type, int index, int hyb) {
   int t;
   xmlNodePtr node;
   node = getHybTrimNode(doc,type, index, hyb);
   t = getIntValue(doc, node);
   return t;
}


void getHybTrimCmd(int value, int feb_id, int hyb_id, char *ch_name, char* cmd, const int MAX) {
   char open_tag[256];
   char close_tag[256];
   char hyb_tag[256];
   char tmp[256];
   getFebCnfCmd(feb_id,1,open_tag,256);
   getFebCnfCmd(feb_id,0,close_tag,256);
   sprintf(hyb_tag,"<Hybrid%d%sTrim>",hyb_id,ch_name);
   sprintf(hyb_tag,"Hybrid%dPwrEn",hyb_id);
   sprintf(tmp,"%s<%s>%d</%s>%s\f",open_tag,hyb_tag,value,hyb_tag,close_tag);
   strcpy(cmd,tmp);
}


