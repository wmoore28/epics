#ifndef STATUS_H
#define STATUS_H

#include <libxml/parser.h>

int compareXmlDump(xmlDoc* doc_cur,xmlDoc* doc_prev);
int checkNonZeroNodes(xmlDoc* document);
int compareNodeSets(xmlDoc* document, xmlDoc* document_prev);




#endif


