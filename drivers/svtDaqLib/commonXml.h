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

void getSubStrFromName(char name[],const int i, char board_type[], const int MAX);

void getStringFromEpicsName(char name[], char str[], int idx);

int getIntFromEpicsName(char name[], int idx);

void getRunStateProcess(char* pname, xmlDoc* doc, char* state);

void getRunState(int idpm, xmlDoc* doc, char* state);

int getFebNumProcess(char* pname, xmlDoc* doc);

int getLinkProcess(char* pname, xmlDoc* doc);

int getEventCountProcess(char* pname, xmlDoc* doc);

void getSyncProcess(char* pname, xmlDoc* doc, char* value);

int findSystemStr(char* buf, const int MAX, char** start);

void pollDpmXmlString(int socketfd, char** xml_string_out, int* len_out);

void getDpmXmlDoc(int sockfd, int dpm, xmlDoc** dpm_doc_ptrptr);

void flushSocket(int socketfd);



#endif

