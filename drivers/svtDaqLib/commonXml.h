#ifndef COMMONXML_H
#define COMMONXML_H

#include <sys/ioctl.h>
#include <libxml/parser.h>
#include <libxml/xpath.h>

#include "commonConstants.h"

char* strToUpper( char* s );

void getStrValue(xmlDocPtr doc, xmlNodePtr node, xmlChar* str);

int getIntValue(xmlDocPtr doc, xmlNodePtr node);

xmlXPathObjectPtr getnodeset (xmlDocPtr doc, xmlChar *xpath);

void getNodeVal(xmlDoc* document, const char* xpath, char* value);

void getSubStrFromName(const char *name,const int i, char *board_type, const int MAX);

void getStringFromEpicsName(const char *name, char *str, const int idx, const int MAX);

int getIntFromEpicsName(const char *name, const int idx);

void getRunStateProcess(char* pname, xmlDoc* doc, char* state);

void getDpmStatusProcess(char* pname, xmlDoc* doc, char* status, int* heart_beat);

void getRunState(int idpm, xmlDoc* doc, char* state);

int getFebNumProcess(char* pname, xmlDoc* doc);

int getLinkProcess(char* pname, xmlDoc* doc);

void getSystemStateProcess(char* pname, xmlDoc* doc, char* value);

int getEventStateProcess(char* pname, xmlDoc* doc);

int getEventCountProcess(char* pname, xmlDoc* doc);

int getBlockCountProcess(char* pname, xmlDoc* doc);

int getTrigCountProcess(char* pname, xmlDoc* doc);

int getDtmTrigCountProcess(char* pname, xmlDoc* doc);

int getDtmReadCountProcess(char* pname, xmlDoc* doc);

int getDtmAckCountProcess(char* pname, xmlDoc* doc);

void getSyncProcess(char* pname, xmlDoc* doc, char* value);

void getHybSync(char* pname, xmlDocPtr doc, char* syncStr);

int findSystemStr(char* buf, const int MAX, char** start);

void pollDpmXmlString(int socketfd, char** xml_string_out, int* len_out);

void getDpmXmlDoc(int sockfd, int dpm, xmlDoc** dpm_doc_ptrptr, char* nodeTypeStr);

void flushSocket(int socketfd);

void writeHybridSwitchProcess(const char* pname, const int value, const int socket, const char* layer);

void getFebCnfCmd(int feb_id, int isopentag,  char* cmd, const int MAX);

int checkNonZeroNodes(xmlDoc* document, const char* xpath);


#endif

