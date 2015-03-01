#include <cstring>
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include "common.h"
#include "febxml.h"
#include "hybxml.h"






int
main(int argc, char **argv) {
   
   char *docname;
   xmlDocPtr doc;
   xmlChar *xpath;// = (xmlChar*) "//AxiVersion";
   xmlNodeSetPtr nodeset;
   xmlXPathObjectPtr result;
   int i,j,k,k5;
   double t,t1,t2,t3,t4;
   xmlChar *keyword;
   
   if (argc <= 2) {
      printf("Usage: %s docname xpath\n", argv[0]);
      return(0);
   }
   
   docname = argv[1];
   xpath = (xmlChar*) argv[2];
   doc = getdoc(docname);
   result = getnodeset (doc, xpath);
   if (result) {
      nodeset = result->nodesetval;
      for (i=0; i < nodeset->nodeNr; i++) {
         //keyword = xmlNodeListGetString(doc, nodeset->nodeTab[i]->xmlChildrenNode, 0);
         //printf("keyword: %s\n", keyword);
         const xmlChar* name = nodeset->nodeTab[i]->name;
         printf("%s\n", name);         
         xmlNode* children = nodeset->nodeTab[i]->xmlChildrenNode;
         xmlNode* child = children;
         while((child = child->next)!=NULL) {
            xmlChar* index = xmlGetProp(child,(xmlChar*)"index");            
            if(index!=NULL) {
               printf("\t%s index=\"%s\"\n", child->name, index);                     
               xmlFree(index);
            }
            else {
               printf("\t%s\n", child->name);                     
            }
         }
         //xmlFree(keyword);
      }
      xmlXPathFreeObject (result);
   }



   i=0;
   for(i=0;i<10;++i) {
      t = getFebTempValue(doc,"FebFpgaTemp",i);
      t1 = getFebTempValue(doc,"FebTemp0",i);
      t2 = getFebTempValue(doc,"FebTemp1",i);
      printf("FEB %d FPGATemp %f %f %f \n",i, t, t1, t2);      
   }



   i=0;
   k=0;
   t=0.0;
   t1=0.0;
   t2=0.0;
   t3=0.0;
   t4=0.0;
   k5 =0;
   char src[40];
   xmlChar sw[40];
   for(i=0;i<10;++i) {
      printf("FEB %d:\n",i);
      for(j=0;j<4;++j) {
         printf("\tHYB %d:\n",j);
         for(k=0;k<1;++k) {
            t=0.0;
            t1 = 0.0;
            t2=0.0;
            if(k==0) strcpy(src,"AVDD");
            else if(k==1) strcpy(src,"DVDD");
            else strcpy(src,"V125");
            
            t =  getHybVValue(doc,src, i, j, "Near");
            if(k!=1) t1 =  getHybVValue(doc,src, i, j, "Sense");            
            t2 =  getHybIValue(doc,src, i, j);
            t3 = getHybTValue(doc, "ZTemp0", i, j);
            t4 = getHybTValue(doc, "ZTemp0", i, j);
            k5 = getHybTrimValue(doc, src, i, j);
            getHybSwitchValue(doc,sw, i, j);
            
            printf("\t\t%s %fV (Near) %fV (Sense) Trim %d %fA  %fC %fC %s\n", src, t, t1,k5, t2, t3, t4, sw);                  
         }
      }
   }
   

   
      
   xmlFreeDoc(doc);
   xmlCleanupParser();
   return (1);
}

