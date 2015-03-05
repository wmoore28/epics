#ifndef FEBXML_H
#define FEBXML_H

#include "common.h"

xmlXPathObjectPtr getFebTemps(xmlDocPtr doc, const char* type);
xmlNodePtr getFebTempNode(xmlDocPtr doc, const char* type, int index);
double getFebTempValue(xmlDocPtr doc, const char* type, int index);
xmlXPathObjectPtr getFebDna(xmlDocPtr doc);
xmlNodePtr getFebDnaNode(xmlDocPtr doc, int index);
void getFebDnaValue(xmlDocPtr doc,int index, xmlChar* dna);


#endif
