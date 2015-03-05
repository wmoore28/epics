#ifndef COMMON_H
#define COMMON_H

#include <libxml/parser.h>
#include <libxml/xpath.h>

xmlNodePtr getFebNode(xmlDocPtr doc, xmlXPathObjectPtr result, int index, int depth, xmlChar* nodeName);
xmlDocPtr getdoc (char *docname);
double getFloatValue(xmlDocPtr doc, xmlNodePtr node);



#endif
