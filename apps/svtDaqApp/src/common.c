#include "common.h"
#include "commonConstants.h"
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include <string.h>
#include <ctype.h>





xmlNodePtr getFebNode(xmlDocPtr doc, xmlXPathObjectPtr result, int index, int depth, xmlChar* nodeName) {
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
         //if(xmlStrcmp(p->name,(xmlChar*)"FebFpga")==0) {
         if(xmlStrcmp(p->name,nodeName)==0) {
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


