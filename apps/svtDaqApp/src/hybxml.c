#include <string.h>
#include "hybxml.h"
#include "dpmxml.h"
#include "commonConstants.h"
#include "commonXml.h"


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
   node = getFebNode(doc, result, index, 3, (xmlChar*)"FebFpga");
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
   node = getFebNode(doc, result, index, 3,(xmlChar*)"FebFpga");
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
   node = getFebNode(doc, result, index, 3,(xmlChar*)"FebFpga");
   return node;
}

double getHybTValue(xmlDocPtr doc, const char* type, int index, int hyb) {
   double t;
   xmlNodePtr node;
   node = getHybTNode(doc,type, index, hyb);
   t = getFloatValue(doc, node);
   return t;
}






void getHybSync(xmlDocPtr doc, int index, int datapath, char* action, char* syncStr) {
  xmlXPathObjectPtr result;
  xmlNodeSetPtr nodeset;
  char tmp[256];
  //sprintf(tmp,"/system/status/ControlDpm/FebFpga/FebCore/HybridSyncStatus/SyncDetected");
  if(strcmp(action,"sync_asub")) {
     sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/HybridSyncStatus[@index=\"%d\"]/SyncDetected", index, datapath);
  }
  else if(strcmp(action,"syncbase_asub")) {
     sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/HybridSyncStatus[@index=\"%d\"]/Base0", index, datapath);
  } 
  else {
    printf("[ getHybSync ] : [ ERROR ] wrong action \"%s\"\n",action);    
  }
  
  if(DEBUG>1) 
    printf("[ getHybSync ] : xpath \"%s\"\n",tmp);
  result = getnodeset(doc, (xmlChar*) tmp);
  if(result!=NULL) {
    nodeset = result->nodesetval;
    if(DEBUG>1) 
      printf("[ getHybSync ] : got %d nodes\n", nodeset->nodeNr);
    if(nodeset->nodeNr==1) {
      getStrValue(doc,nodeset->nodeTab[0],(xmlChar*)syncStr);
    } else {
      strcpy(syncStr, "too many nodes");
    }
  } else {
    if(DEBUG>1)
      printf("[ getHybSync ] : no nodes found\n");
    strcpy(syncStr, "no results");
  }
  
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

   node = getFebNode(doc, result, index, 2,(xmlChar*)"FebFpga");

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
   node = getFebNode(doc, result, index, 2,(xmlChar*)"FebFpga");
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










xmlXPathObjectPtr getHybSyncsFromDpm(xmlDocPtr doc) {
   char tmp[256];
   sprintf(tmp,"/system/status/DataDpm/RceCore/DataPath/FebCore/DataPath/Synced");
   if(DEBUG>2) printf("[ getHybSyncsFromDpm ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}



int getHybSyncFromDpmValue(xmlDocPtr doc, int hyb) {


  
  //if(DEBUG>2) 
  printf("[ getHybSyncFromDpmValue ] : get sync for hyb %d from the dpm xml\n", hyb);
  

  int dp;
  int val_hybrid;
  int val_sync;  
  xmlXPathObjectPtr result_syncs;
  xmlXPathObjectPtr result_hybrids;
  xmlNodePtr node_hybrid;
  xmlNodePtr node_sync;
  val_sync = -9;
  result_syncs = getHybSyncsFromDpm(doc);
  result_hybrids = getHybridFromDpm(doc);
  //if(DEBUG>2) {
  if(result_syncs!=NULL)
    printf("[ getHybSyncFromDpmValue ] : got %d nodes of syncs\n", result_syncs->nodesetval->nodeNr);
  else
    printf("[ getHybSyncFromDpmValue ] : no sync nodes found\n");
  if(result_hybrids!=NULL)
    printf("[ getHybSyncFromDpmValue ] : got %d nodes of hybrids\n", result_hybrids->nodesetval->nodeNr);
  else
    printf("[ getHybSyncFromDpmValue ] : no hybrid nodes found\n");
  
  if(result_syncs!=NULL && result_hybrids!=NULL) {
    for(dp=0;dp<4;++dp) {
      //if(DEBUG>0)
      printf("[ getHybSyncFromDpmValue ] : find datapath %d\n",dp);
      node_hybrid = getFebNode(doc, result_hybrids, dp, 1, (xmlChar*) "DataPath");
      //if(DEBUG>0)
      printf("[ getHybSyncFromDpmValue ] : datapath node at  %p\n",node_hybrid);
      if(node_hybrid!=NULL) {
	val_hybrid = getIntValue(doc, node_hybrid);
	//if(DEBUG>0)
	printf("[ getHybSyncFromDpmValue ] : found hybrid %d\n",val_hybrid);
	if(val_hybrid == hyb) {
	  //if(DEBUG>0)
	  printf("[ getHybSyncFromDpmValue ] : correct hybrid!\n");
	  node_sync = getFebNode(doc, result_syncs, dp, 1, (xmlChar*) "DataPath");
	  //if(DEBUG>0)
	  printf("[ getHybSyncFromDpmValue ] : sync node at  %p\n",node_sync);
	  if(node_sync!=NULL) {
	    val_sync = getIntValue(doc, node_sync);
	    //if(DEBUG>0)
	    printf("[ getHybSyncFromDpmValue ] : sync val %d\n",val_sync);
	  } else {
	    //if(DEBUG>0)
	    printf("[ getHybSyncFromDpmValue ] : no sync node found.\n");
	  }
	} else {
	  //if(DEBUG>0)
	  printf("[ getHybSyncFromDpmValue ] : wrong hybrid, continue.\n");
	}
      } else {
	//if(DEBUG>0)
	printf("[ getHybSyncFromDpmValue ] : no hybrid node found.\n");
      }
    }
  } else {
    //if(DEBUG>0)
    printf("[ getHybSyncFromDpmValue ] : no valid results for sync and hybrids found\n");
  }
  

  return val_sync;
}




int getFebFromDpmValue(xmlDocPtr doc, int hyb) {

  
  //if(DEBUG>2) 
  printf("[ getFebFromDpmValue ] : get feb for hyb %d from the dpm xml\n", hyb);
  

  int dp;
  int val_hybrid;
  int val_sync;  
  xmlXPathObjectPtr result_syncs;
  xmlXPathObjectPtr result_hybrids;
  xmlNodePtr node_hybrid;
  xmlNodePtr node_sync;
  val_sync = -9;
  result_syncs = getFebFromDpm(doc);
  result_hybrids = getHybridFromDpm(doc);
  //if(DEBUG>2) {
  if(result_syncs!=NULL)
    printf("[ getFebFromDpmValue ] : got %d nodes of febs\n", result_syncs->nodesetval->nodeNr);
  else
    printf("[ getFebFromDpmValue ] : no feb nodes found\n");
  if(result_hybrids!=NULL)
    printf("[ getFebFromDpmValue ] : got %d nodes of hybrids\n", result_hybrids->nodesetval->nodeNr);
  else
    printf("[ getFebFromDpmValue ] : no hybrid nodes found\n");
  
  if(result_syncs!=NULL && result_hybrids!=NULL) {
    for(dp=0;dp<4;++dp) {
      //if(DEBUG>0)
      printf("[ getFebFromDpmValue ] : find datapath %d\n",dp);
      node_hybrid = getFebNode(doc, result_hybrids, dp, 1, (xmlChar*) "DataPath");
      //if(DEBUG>0)
      printf("[ getFebFromDpmValue ] : datapath node at  %p\n",node_hybrid);
      if(node_hybrid!=NULL) {
	val_hybrid = getIntValue(doc, node_hybrid);
	//if(DEBUG>0)
	printf("[ getFebFromDpmValue ] : found hybrid %d\n",val_hybrid);
	if(val_hybrid == hyb) {
	  //if(DEBUG>0)
	  printf("[ getFebFromDpmValue ] : correct hybrid!\n");
	  node_sync = getFebNode(doc, result_syncs, dp, 1, (xmlChar*) "DataPath");
	  //if(DEBUG>0)
	  printf("[ getFebFromDpmValue ] : feb node at  %p\n",node_sync);
	  if(node_sync!=NULL) {
	    val_sync = getIntValue(doc, node_sync);
	    //if(DEBUG>0)
	    printf("[ getFebFromDpmValue ] : feb val %d\n",val_sync);
	  } else {
	    //if(DEBUG>0)
	    printf("[ getFebFromDpmValue ] : no feb node found.\n");
	  }
	} else {
	  //if(DEBUG>0)
	  printf("[ getFebFromDpmValue ] : wrong hybrid, continue.\n");
	}
      } else {
	//if(DEBUG>0)
	printf("[ getFebFromDpmValue ] : no hybrid node found.\n");
      }
    }
  } else {
    //if(DEBUG>0)
    printf("[ getFebFromDpmValue ] : no valid results for febs and hybrids found\n");
  }
  

  return val_sync;
}


xmlXPathObjectPtr getHybridFromDpm(xmlDocPtr doc) {
   char tmp[256];
   strcpy(tmp,"/system/status/DataDpm/RceCore/DataPath/HybridNum");
   if(DEBUG>2) printf("[ getHybridFromDpm ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

xmlXPathObjectPtr getFebFromDpm(xmlDocPtr doc) {
   char tmp[256];
   sprintf(tmp,"/system/status/DataDpm/RceCore/DataPath/FebNum");
   if(DEBUG>2) printf("[ getFebFromDpm ] : xpath \"%s\"\n",tmp);
   return getnodeset(doc, (xmlChar*) tmp);
}

