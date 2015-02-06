#include "common.h"
#include "constants.h"
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include <string.h>
#include <ctype.h>


char* strToUpper( char* s )
{
    char* p = s;
    while (*p) {
        if(islower(*p)) {
            *p = toupper(*p);
        }
        p++;
    }
    return s;
}



xmlNodePtr getFebNode(xmlDocPtr doc, xmlXPathObjectPtr result, int index, int depth) {
   xmlNodeSetPtr nodeset;
   int i,d;
   xmlNodePtr node;
   xmlNode* n;
   xmlNode* p;
   xmlChar* index_test;
   int index_test_int;
   node = NULL;
   if(result) {
      nodeset = result->nodesetval;
      for(i=0;i<nodeset->nodeNr;++i) {
         n = nodeset->nodeTab[i];
         p=n;
         d = depth;
         while(d>0) {
            p = p->parent;
            d--;
         }
         if(DEBUG>2) printf("%s\n",p->name);
         if(xmlStrcmp(p->name,(xmlChar*)"FebFpga")==0) {
            index_test = xmlGetProp(p,(xmlChar*)"index");   
            if(index_test!=NULL) {
               if(DEBUG>2) printf("index_test %s\n",index_test);
               index_test_int = atoi((const char*)index_test);
               xmlFree(index_test);
               if(DEBUG>2) printf("index_test %d == %d?\n",index_test_int, index);
               if(index==index_test_int) {
                  node = n;
                  if(DEBUG>2) printf("found it! %p\n",node);
                  break;
               }           
            } 
         }
      }
   }
   return node;
}


xmlDocPtr
getdoc (char *docname) {
	xmlDocPtr doc;
	doc = xmlParseFile(docname);
	
	if (doc == NULL ) {
		fprintf(stderr,"Document not parsed successfully. \n");
		return NULL;
	}

	return doc;
}

xmlXPathObjectPtr
getnodeset (xmlDocPtr doc, xmlChar *xpath) {
	
	xmlXPathContextPtr context;
	xmlXPathObjectPtr result;

	context = xmlXPathNewContext(doc);
	if (context == NULL) {
		printf("[ getnodeset ] : [ ERROR ] :  xmlXPathNewContext\n");
		return NULL;
	}
	result = xmlXPathEvalExpression(xpath, context);
	xmlXPathFreeContext(context);
	if (result == NULL) {
		printf("[ getnodeset ] : [ ERROR ] : xmlXPathEvalExpression\n");
		return NULL;
	}
	if(xmlXPathNodeSetIsEmpty(result->nodesetval)){
		xmlXPathFreeObject(result);
        if(DEBUG>2) printf("[ getnodeset ] : [ WARNING ] :  no xmlXPath result found\n");
		return NULL;
	}
	return result;
}


double getFloatValue(xmlDocPtr doc, xmlNodePtr node) {
   double t=0.0;
   xmlChar* value;
   if(node!=NULL) {
      if(DEBUG>2) printf("%s found\n",node->name);      
      value  = xmlNodeListGetString(doc,node->children,0);
      if(value!=NULL) {
         if(DEBUG>2) printf("FEB FPGA %s \n", value);      
         t = atof((const char*)value);
         if(DEBUG>2) printf("FEB FPGA %f \n", t);      
         xmlFree(value);
      }
   }
   return t;
}

void getStrValue(xmlDocPtr doc, xmlNodePtr node, xmlChar* str) {
   xmlChar* value;
   if(node!=NULL) {
      if(DEBUG>1) printf("[ getStrValue ] : from node %s\n",node->name);      
      value = xmlNodeListGetString(doc,node->children,0);
      if(value!=NULL) {
         if(DEBUG>2) printf("[ getStrValue ] : extracted value \"%s\"\n",value);      
         strcpy((char*)str,(char*)value);
         xmlFree(value);
      }
   } else {
      if(DEBUG>1) printf("[ getStrValue ] : no node, return empty string\n");      
      strcpy((char*)str,"");
   }
}

int getIntValue(xmlDocPtr doc, xmlNodePtr node) {
   int t=0;
   xmlChar* value;
   if(node!=NULL) {
      if(DEBUG>2) printf("[ getIntValue ] : node %s \n",node->name);      
      value  = xmlNodeListGetString(doc,node->children,0);
      if(value!=NULL) {
         if(DEBUG>2) printf("[ getIntValue ] : str value %s\n",value);      
         //if( xmlStrstr(value,"0x")!=0) 
         t = (int) strtol((char*)value, NULL, 0);
         //t = atoi((const char*)value);
         if(DEBUG>2) printf("[ getIntValue ] : int value %d\n",t);      
         xmlFree(value);
      }
   }
   return t;
}
