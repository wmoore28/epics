#ifndef COMMON_H
#define COMMON_H

#include <libxml/parser.h>
#include <libxml/xpath.h>

xmlNodePtr getFebNode(xmlDocPtr doc, xmlXPathObjectPtr result, int index, int depth);
xmlDocPtr getdoc (char *docname);
xmlXPathObjectPtr getnodeset (xmlDocPtr doc, xmlChar *xpath);
double getFloatValue(xmlDocPtr doc, xmlNodePtr node);
void getStrValue(xmlDocPtr doc, xmlNodePtr node, xmlChar* str);
int getIntValue(xmlDocPtr doc, xmlNodePtr node);

char* strToUpper( char* s );


#endif
