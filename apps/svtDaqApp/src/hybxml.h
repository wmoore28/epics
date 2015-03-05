#ifndef HYBXML_H
#define HYBXML_H

#include "common.h"


void getFebCnfCmd(int feb_id, int isopentag,  char* cmd, const int MAX);

xmlXPathObjectPtr getHybVs(xmlDocPtr doc, const char* type, int hyb, const char* pos);
xmlNodePtr getHybVNode(xmlDocPtr doc, const char* type, int index, int hyb, const char* pos);
double getHybVValue(xmlDocPtr doc, const char* type, int index, int hyb, const char* pos);


xmlXPathObjectPtr getHybIs(xmlDocPtr doc, const char* type, int hyb);
xmlNodePtr getHybINode(xmlDocPtr doc, const char* type, int index, int hyb);
double getHybIValue(xmlDocPtr doc, const char* type, int index, int hyb);


xmlXPathObjectPtr getHybTs(xmlDocPtr doc, const char* type, int hyb);
xmlNodePtr getHybTNode(xmlDocPtr doc, const char* type, int index, int hyb);
double getHybTValue(xmlDocPtr doc, const char* type, int index, int hyb);


xmlXPathObjectPtr getHybSwitches(xmlDocPtr doc, int hyb);
xmlNodePtr getHybSwitchNode(xmlDocPtr doc,int index, int hyb);
double getHybSwitchValue(xmlDocPtr doc, int index, int hyb);
void getHybSwitchCmd(char* value, int feb_id, int hyb_id, char* cmd, const int MAX);


xmlXPathObjectPtr getHybTrims(xmlDocPtr doc, const char* type, int hyb);
xmlNodePtr getHybTrimNode(xmlDocPtr doc, const char* type, int index, int hyb);
int getHybTrimValue(xmlDocPtr doc, const char* type, int index, int hyb);
void getHybTrimCmd(int value, int feb_id, int hyb_id, char *ch_name, char* cmd, const int MAX);


void getHybSync(xmlDocPtr doc, int index, int datapath, char* action, char* syncStr);

int getHybSyncFromDpmValue(xmlDocPtr doc, int hyb);

int getFebFromDpmValue(xmlDocPtr doc, int hyb);
xmlXPathObjectPtr getFebFromDpm(xmlDocPtr doc);

xmlXPathObjectPtr getHybridFromDpm(xmlDocPtr doc);
void getHybridFromDpmValues(xmlDocPtr doc, int** hybrids);
xmlXPathObjectPtr getHybridFromDpm(xmlDocPtr doc);



#endif
