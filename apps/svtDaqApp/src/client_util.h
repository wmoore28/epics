#ifndef __client_util__
#define __client_util__

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <libxml/parser.h>



double extractTempValFromString(char value[]);

void getHalfFromDaqMapRecordName(char name[], char board_type[], const int MAX);
void getHybridFromDaqMapRecordName(char name[], char board_type[], const int MAX);
void error(const char *msg);
void writeReadConfig(int sockfd);
void writeReadStatus(int sockfd);


void pollXmlString(int socketfd);
//void pollDpmXmlString(int socketfd, char** xml_string_out, int* len_out);
xmlNode* retrieveElement(xmlDoc* doc, xmlNode* node, char* tag);
void retrieveValue(xmlDoc* doc, xmlNode* node, char* tags, char value[], const unsigned int MAX);
void getXmlDoc(int sockfd, int read_status, int read_config);
void getXmlDocStrFormat(char** xml_str, int * xml_str_len);
int getXmlPollStatus();
int getAllDpmXmlDocStatus();
int getDpmXmlDocStatus(int dpm);

double getFebT(int feb_id, char* ch_name);
void getFebDeviceDna(int feb_id, char* dna);
double getHybridT(int index, int hyb, const char* type);
double getHybridI(int index, int hyb, const char* type);
double getHybridV(int feb_id, int hyb_id,char ch_name[], char ch_pos[]);
double getHybridSwitch(int index, int hyb);
void writeHybridVSwitch(int sockid, int value, int feb_id, int hyb_id);
double getHybridTrim(int index, int hyb, char* type);
void writeHybridVTrim(int sockid, int value, int feb_id, int hyb_id, char *ch_name);
//double getHybridSync(int index, int hyb, int dpm);
void getHybridSync(int index, int datapath, char* action, char* syncStr);
int getDpm(int index, int hyb);
double getDatapath(int index, int hyb, int dpm);
int getDpmFromFebValue(int index, int hybrid);
int getDataDpmId(int i);
void getSync(char* pname, char* value);

#endif
