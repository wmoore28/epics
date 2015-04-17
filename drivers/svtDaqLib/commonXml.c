#include "commonXml.h"
#include "commonConstants.h"

#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <libxml/parser.h>
#include <libxml/xpath.h>


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



void getSubStrFromName(const char* name,const int i, char* str, const int MAX) {
   char buf[MAX];
   if(strlen(name)>MAX) {
      printf("[ getSubStrFromName ] : [ ERROR ] : name is too long!\n");
      exit(1);
   } 
   strcpy(buf,name);
   strcpy(str,"");
   int idx;
   char* pch;
   memset(str,'\0',MAX);
   pch = strtok(buf,":");
   idx=0;
   while(pch!=NULL) {
      if(idx==i) {
         if(strlen(pch)>MAX) {
            printf("ERROR pch string is too long!\n");	
         } else {
            strcpy(str,pch);
            break;
         }
      }
      idx++;    
      pch = strtok(NULL,":");
   }  
   if(DEBUG>3) 
      printf("[ getSubStrFromName ] : got \"%s\" from name \"%s\"\n",str,name);
   return;
}

void getStringFromEpicsName(const char *name, char *str, const int idx, const int MAX) {   
   if(DEBUG>3) printf("[ getStringFromEpicsName ] : idx %d from name \"%s\"\n",idx, name);
   getSubStrFromName(name,idx,str,MAX);
   if(DEBUG>3) printf("[ getStringFromEpicsName ] : got \"%s\" on idx %d from name \"%s\"\n",str,idx, name);
}

int getIntFromEpicsName(const char* name, const int idx) {   
   const int MAX = BUF_SIZE;
   char str[MAX];
   if(DEBUG>2) 
      printf("[ getIntFromEpicsName ] : name %s idx %d\n", name, idx);
   getSubStrFromName(name,idx,str,MAX);
   char* p_end = str;
   int id = (int) strtol(str,&p_end,0);
   if(p_end==str) {
      printf("[ getIntFromEpicsName ]: [ ERROR ]: invalid convertion of this feb id %s\n",str);
      return -1;      
   }
   if(DEBUG>2) 
      printf("[ getIntFromEpicsName ] : got %d\n", id);
   return id;
}



void getRunStateProcess(char* pname, xmlDoc* doc, char* state) {

   int idpm;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);
   if(strcmp(str1,"daq")==0 && (strcmp(str2,"dtm")==0 ||strcmp(str2,"dpm")==0 || strcmp(str2,"controldpm")==0)) {
      idpm = getIntFromEpicsName(pname,3);  
      if(strcmp(str2,"controldpm")==0)
         getStringFromEpicsName(pname,action,5,BUF_SIZE);    
      else
         getStringFromEpicsName(pname,action,4,BUF_SIZE);    
      if(strcmp(action,"state_asub")==0) {           
         getRunState(idpm, doc, state);
         if(DEBUG>0) printf("[ getRunStateProcess ]: got state %s.\n",state);      
      } else {
         printf("[ getRunStateProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      }     
   } else {
      printf("[ getRunStateProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
  
}

void getDpmStatusProcess(char* pname, xmlDoc* doc, char* status, int* heart_beat) {

   int dpm;
   int nonZeroStatus;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);
   if(strcmp(str1,"daq")==0 && (strcmp(str2,"dtm")==0 ||strcmp(str2,"dpm")==0 ||strcmp(str2,"controldpm")==0)) {
      dpm = getIntFromEpicsName(pname,3);  

      if(strcmp(str2,"controldpm")==0)
         getStringFromEpicsName(pname,action,5,BUF_SIZE);    
      else
         getStringFromEpicsName(pname,action,4,BUF_SIZE);    


      if(strcmp(action,"status_asub")==0) {           
         
         xmlXPathObjectPtr result;
         xmlNodePtr node;
         char tmp[BUF_SIZE];
         strcpy((char*)status, "undef");
         *heart_beat = 98;
         if(DEBUG>0)
            printf("[ getDpmStatusProcess ] : get status of dpm %d dpm_doc at %p\n", dpm, doc);
         if(doc!=NULL) {      
            if(DEBUG>0)
               printf("[ getDpmStatusProcess ]: dpm %d xml ok\n", dpm);    
            sprintf(tmp,"/system/status");
            if(DEBUG>2) printf("[ getDpmStatusProcessDpm ] : xpath \"%s\"\n",tmp);
            result =  getnodeset(doc, (xmlChar*) tmp);
            if(result!=NULL) {
               if(DEBUG>2) 
                  printf("[ getDpmStatusProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  if(DEBUG>2) 
                     printf("[ getDpmStatusProcess ] : got system tags\n");
                  
                  //free results
                  xmlXPathFreeObject(result);
                  
                  if(strcmp(str2,"dtm")==0) {                     
                     nonZeroStatus = checkNonZeroNodes(doc,"/system/status/TiDtm/RceDtmTiming/TxCount1");
                     //check for dummy value
                     if(nonZeroStatus==0) {
                        char value[256];
                        getNodeVal(doc, "/system/status/TiDtm/RceDtmTiming/TxCount1",value);
                        if(strcmp(value,"0x0")==0) {
                           nonZeroStatus=1;
                        }
                     }
                  } else {
                     if(dpm==7) {
                        nonZeroStatus = checkNonZeroNodes(doc,"/system/status/ControlDpm/RceDpmTiming/RxCount1");
                     } else {
                        nonZeroStatus = checkNonZeroNodes(doc,"/system/status/DataDpm/RceDpmTiming/RxCount1");
                        //nonZeroStatus = checkNonZeroNodes(doc,"/system/status");
                     }
                  }
                  if(DEBUG>2) 
                     printf("[ getDpmStatusProcess ] : nonZeroStatus %d \n",nonZeroStatus);
                  
                  if(nonZeroStatus==0) {
                     
                     // checkl softpower monitor stuff for dpm7
                     if(dpm==7) {
                        nonZeroStatus = checkNonZeroNodes(doc,"/system/status/ControlDpm/FebFpga/FebCore/SoftPowerMonitor/FebTemp0");                                          
                        if(nonZeroStatus==0) {
                           strcpy((char*)status, "Seems OK");
                           *heart_beat = -1;
                        } else {
                           printf("[ getDpmStatusProcess ] : [ WARNING ] SoftPowerMonitor temps were empty!?\n");
                           strcpy((char*)status,"XML content: empty <SoftPowerMonitor tags>, FEB power&link ok?");
                           *heart_beat = 8;                     
                        }                        
                     } else {
                        strcpy((char*)status, "Seems OK");
                        *heart_beat = -1;
                     }
                  } else {
                     printf("[ getDpmStatusProcess ] : [ WARNING ] Tx/RxCounts were empty\n");
                     strcpy((char*)status,"XML content: empty tags");
                     *heart_beat = 7;                     
                  }
               } else {
                  printf("[ getDpmStatusProcess ] : [ WARNING ] %d status nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
                  strcpy((char*)status,"XML content: wrong nr of <system> tags");
                  *heart_beat = 6;
                  xmlXPathFreeObject(result);
               }
               
            } else {
               printf("[ getDpmStatusProcess ] : [ WARNING ] no results found\n");
               strcpy((char*)status, "XML content: <status> tag missing");
               *heart_beat = 5;
            }  
         } else {
            if(DEBUG>0) 
               printf("[ getDpmStatusProcess ]: [ WARNING ]: the dpm %d xml doc status is invalid\n",dpm);
            strcpy(status,"No XML doc built. ");
            *heart_beat = 4;
         }
         if(DEBUG>0) printf("[ getDpmStatusProcess ]: got status %s.\n",status);      
      } else {
         printf("[ getDpmStatusProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
         strcpy((char*)status, "wrong action!?");
         *heart_beat = 3;
      }     
   } else {
      printf("[ getDpmStatusProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
      strcpy((char*)status, "wrong record name!?");
      *heart_beat = 2;
   }

}


int getFebNumProcess(char* pname, xmlDoc* doc) {
   int val;
   int idpm;
   int idp;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   char tmp[BUF_SIZE];
   val = -1;
   idpm = -1;
   idp = -1;
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);

   if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
      idpm = getIntFromEpicsName(pname,3);  
      idp = getIntFromEpicsName(pname,4);  
        
      getStringFromEpicsName(pname,action,5,BUF_SIZE);    
    
      if(DEBUG>2)  printf("[ getFebNumProcess ] : get %s from dpm xml\n", action);
      if(strcmp(action,"febnum_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/RceCore/DataPath[@index=\"%d\"]/FebNum",idp);
      } 
      else if( strcmp(action,"hybnum_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/RceCore/DataPath[@index=\"%d\"]/HybridNum",idp);
      }
      else {
         strcpy(tmp,"");
      }
    
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) printf("[ getFebNumProcess ] : xpath \"%s\"\n",tmp);
         result =  getnodeset(doc, (xmlChar*) tmp);
         if(result!=NULL) {
            if(DEBUG>2) printf("[ getFebNumProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
            if(result->nodesetval->nodeNr==1) {
               node = result->nodesetval->nodeTab[0];
               if(node!=NULL) {
                  val = getIntValue(doc, node);
                  if(DEBUG>0) printf("[ getFebNumProcess ]: got val %d.\n",val);      
               } else {
                  printf("[ getFebNumProcess ] : [ WARNING ] no FebNum nodes found\n");
               }
            } else {
               printf("[ getFebNumProcess ] : [ WARNING ] %d FebNum nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
            }
            xmlXPathFreeObject(result);
         } else {
            if(DEBUG>0) printf("[ getFebNumProcess ] : [ WARNING ] no results found\n");
         }  
      } else {
         printf("[ getFebNumProcess ] : [ WARNING ] wrong action (%s) \n",action);      
      }
   } else {
      printf("[ getFebNumProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
   return val;
}


int getLinkProcess(char* pname, xmlDoc* doc) {
   int val;
   int idpm;
   int idp;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   idpm = -1;
   idp = -1;
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);

   if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
      idpm = getIntFromEpicsName(pname,3);  
      idp = getIntFromEpicsName(pname,4);  
    
      getStringFromEpicsName(pname,action,5,BUF_SIZE);    
    
      if(strcmp(action,"rxphyready_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxPhyReady",idp);
      } 
      else if(strcmp(action,"rxframecount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxFrameCount",idp);
      } 
      else if(strcmp(action,"rxframeerrorcount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxFrameErrorCount",idp);
      } 
      else if(strcmp(action,"rxcellerrorcount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxCellErrorCount",idp);
      } 
      else if(strcmp(action,"rxlinkerrorcount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxLinkErrorCount",idp);
      } 
      else if(strcmp(action,"rxlinkdowncount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/Pgp2bAxi[@index=\"%d\"]/RxLinkDownCount",idp);
      } else {
         strcpy(tmp,""); 
      }

      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) printf("[ getLinkDpm ] : xpath \"%s\"\n",tmp);
         result =  getnodeset(doc, (xmlChar*) tmp);
         if(result!=NULL) {
            if(DEBUG>0) printf("[ getLinkProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
            if(result->nodesetval->nodeNr==1) {
               node = result->nodesetval->nodeTab[0];
               if(node!=NULL) {
                  if(strcmp(action,"rxphyready")==0) {
                     char tmp2[BUF_SIZE];
                     getStrValue(doc,node,tmp2);
                     if(strcmp(strToUpper(tmp2),"FALSE")==0) 
                        val = 0;
                     else if(strcmp(strToUpper(tmp2),"TRUE")==0) 
                        val = 1;
                     else {
                        printf("[ getLinkProcess ] : [ ERROR ] wrong boolean string %s\n",tmp2);
                        val = -2;
                     }
                  } else {
                     val = getIntValue(doc, node);
                  }
                  if(DEBUG>0) printf("[ getLinkProcess ]: got val %d.\n",val);      
               } else {
                  printf("[ getLinkProcess ] : [ WARNING ] no Link nodes found\n");
               }
            } else {
               printf("[ getLinkProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
            }
            xmlXPathFreeObject(result);        
         } else {
            if(DEBUG>0) printf("[ getLinkProcess ] : [ WARNING ] no results found\n");
         }  
      } else {
         printf("[ getLinkProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      }     
   } else {
      printf("[ getLinkProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
   return val;
}



int getBurnCountProcess(char* pname, xmlDoc* doc) {
   int val;
   int idpm;
   int idp;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   idpm = -1;
   idp = -1;
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);

   if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
      idpm = getIntFromEpicsName(pname,3);  
   
      //cross-check
      if(idpm<0 && idpm>14) {
         printf("[ getBurnCountProcess ] : [ ERROR ] : idpm invalid for \"%s\"?!\n",pname);
         exit(1);
      }

      getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
      if(strcmp(action,"burncount_sub")==0) {
         sprintf(tmp,"/system/status/DataDpm/RceCore/EventBuilder/BurnCount");
      } else {
         strcpy(tmp,""); 
      }
      
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) printf("[ getBurnCountProcess ] : xpath \"%s\"\n",tmp);
         result =  getnodeset(doc, (xmlChar*) tmp);
         if(result!=NULL) {
            if(DEBUG>0) printf("[ getBurnCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
            if(result->nodesetval->nodeNr==1) {
               node = result->nodesetval->nodeTab[0];
               if(node!=NULL) {
                  val = getIntValue(doc, node);
                  if(DEBUG>0) printf("[ getBurnCountProcess ]: got val %d.\n",val);      
               } else {
                  printf("[ getBurnCountProcess ] : [ WARNING ] no Link nodes found\n");
               }
            } else {
               printf("[ getBurnCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
            }
            xmlXPathFreeObject(result);        
         } else {
            if(DEBUG>0) printf("[ getBurnCountProcess ] : [ WARNING ] no results found\n");
         }  
      } else {
         printf("[ getBurnCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      }     
   } else {
      printf("[ getBurnCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
   return val;
}





int getEventCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"eventcount_sub")==0) {
      strcpy(tmp,"/system/status/DataDpm/EventCount");
    } else {
      strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
      if(DEBUG>2) printf("[ getEventCountProcess ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
        if(DEBUG>0) printf("[ getEventCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
        if(result->nodesetval->nodeNr==1) {
          node = result->nodesetval->nodeTab[0];
          if(node!=NULL) {
            if(strcmp(action,"rxphyready")==0) {
              char tmp2[BUF_SIZE];
              getStrValue(doc,node,tmp2);
              if(strcmp(strToUpper(tmp2),"FALSE")==0) 
                val = 0;
              else if(strcmp(strToUpper(tmp2),"TRUE")==0) 
                val = 1;
              else {
                printf("[ getEventCountProcess ] : [ ERROR ] wrong boolean string %s\n",tmp2);
                val = -2;
              }
            } else {
              val = getIntValue(doc, node);
            }
            if(DEBUG>0) printf("[ getEventCountProcess ]: got val %d.\n",val);      
          } else {
            printf("[ getEventCountProcess ] : [ WARNING ] no Link nodes found\n");
          }
        } else {
          printf("[ getEventCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
        }
        xmlXPathFreeObject(result);        
      } else {
        if(DEBUG>0) printf("[ getEventCountProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getEventCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getEventCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}




int getBlockCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"blockcount_sub")==0) {
      strcpy(tmp,"/system/status/DataDpm/BlockCount");
    } else {
      strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
      if(DEBUG>2) printf("[ getBlockCountProcess ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
        if(DEBUG>0) printf("[ getBlockCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
        if(result->nodesetval->nodeNr==1) {
          node = result->nodesetval->nodeTab[0];
          if(node!=NULL) {
            if(strcmp(action,"rxphyready")==0) {
              char tmp2[BUF_SIZE];
              getStrValue(doc,node,tmp2);
              if(strcmp(strToUpper(tmp2),"FALSE")==0) 
                val = 0;
              else if(strcmp(strToUpper(tmp2),"TRUE")==0) 
                val = 1;
              else {
                printf("[ getBlockCountProcess ] : [ ERROR ] wrong boolean string %s\n",tmp2);
                val = -2;
              }
            } else {
              val = getIntValue(doc, node);
            }
            if(DEBUG>0) printf("[ getBlockCountProcess ]: got val %d.\n",val);      
          } else {
            printf("[ getBlockCountProcess ] : [ WARNING ] no Link nodes found\n");
          }
        } else {
          printf("[ getBlockCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
        }
        xmlXPathFreeObject(result);        
      } else {
        if(DEBUG>0) printf("[ getBlockCountProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getBlockCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getBlockCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}




void getSystemStateProcess(char* pname, xmlDoc* doc, char* value) {
   int idpm;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   idpm = -1;
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);

   if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
      idpm = getIntFromEpicsName(pname,3);  
    
      getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
      if(strcmp(action,"systemstate_sub")==0) {
         strcpy(tmp,"/system/status/SystemStatus");
      } else {
         strcpy(tmp,""); 
      }
    
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) printf("[ getSystemStateProcess ] : xpath \"%s\"\n",tmp);

         if(doc!=NULL) {
            
            result =  getnodeset(doc, (xmlChar*) tmp);
            if(result!=NULL) {
               if(DEBUG>0) printf("[ getSystemStateProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  node = result->nodesetval->nodeTab[0];
                  if(node!=NULL) {
                  
                     getStrValue(doc, node,value);
                     
                     if(DEBUG>0) printf("[ getSystemStateProcess ]: got val %s.\n",value);      
                  } else {
                     printf("[ getSystemStateProcess ] : [ WARNING ] no Link nodes found\n");
                  }
               } else {
                  printf("[ getSystemStateProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
               }
               xmlXPathFreeObject(result);        
            } else {
               if(DEBUG>0) printf("[ getSystemStateProcess ] : [ WARNING ] no results found\n");
            }  
            
         } else {
            printf("[ getSystemStateProcess ]: [ WARNING ]: no XML doc\n");
         }
      } else {
         printf("[ getSystemStateProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      }     
   } else {
      printf("[ getSystemStateProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
   return;
}




int getEventStateProcess(char* pname, xmlDoc* doc) {
   int val;
   int idpm;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   idpm = -1;
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);

   if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
      idpm = getIntFromEpicsName(pname,3);  
    
      getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
      if(strcmp(action,"eventstate_sub")==0) {
         strcpy(tmp,"/system/status/DataDpm/EventState");
      } else {
         strcpy(tmp,""); 
      }
    
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) printf("[ getEventStateProcess ] : xpath \"%s\"\n",tmp);

         if(doc!=NULL) {
            
            result =  getnodeset(doc, (xmlChar*) tmp);
            if(result!=NULL) {
               if(DEBUG>0) printf("[ getEventStateProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  node = result->nodesetval->nodeTab[0];
                  if(node!=NULL) {
                  
                     val = getIntValue(doc, node);
                     
                     if(DEBUG>0) printf("[ getEventStateProcess ]: got val %d.\n",val);      
                  } else {
                     printf("[ getEventStateProcess ] : [ WARNING ] no Link nodes found\n");
                  }
               } else {
                  printf("[ getEventStateProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
               }
               xmlXPathFreeObject(result);        
            } else {
               if(DEBUG>0) printf("[ getEventStateProcess ] : [ WARNING ] no results found with xpath \"%s\"\n",tmp);
            }  
            
         } else {
            printf("[ getEventStateProcess ]: [ WARNING ]: no XML doc\n");
         }
      } else {
         printf("[ getEventStateProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      }     
   } else {
      printf("[ getEventStateProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
   }
   return val;
}





int getTrigCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"trigcount_sub")==0) {
      strcpy(tmp,"/system/status/DataDpm/TrigCount");
    } else {
      strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
      if(DEBUG>2) printf("[ getTrigCountProcess ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
        if(DEBUG>0) printf("[ getTrigCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
        if(result->nodesetval->nodeNr==1) {
          node = result->nodesetval->nodeTab[0];
          if(node!=NULL) {
             val = getIntValue(doc, node);
            if(DEBUG>0) printf("[ getTrigCountProcess ]: got val %d.\n",val);      
          } else {
            printf("[ getTrigCountProcess ] : [ WARNING ] no Link nodes found\n");
          }
        } else {
          printf("[ getTrigCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
        }
        xmlXPathFreeObject(result);        
      } else {
        if(DEBUG>0) printf("[ getTrigCountProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getTrigCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getTrigCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}


int getDtmTrigCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dtm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"trigcount_sub")==0) {
      strcpy(tmp,"/system/status/TiDtm/Trig1Count");
    } else {
      strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
       //if(DEBUG>2) 
       printf("[ getDtmTrigCountProcess ] : xpath \"%s\"\n",tmp);
       
       if(doc!=NULL) {
          result =  getnodeset(doc, (xmlChar*) tmp);
          if(result!=NULL) {
             //if(DEBUG>0) 
             printf("[ getDtmTrigCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
             if(result->nodesetval->nodeNr==1) {
                node = result->nodesetval->nodeTab[0];
                if(node!=NULL) {
                   val = getIntValue(doc, node);
                   //if(DEBUG>0) 
                   printf("[ getDtmTrigCountProcess ]: got val %d.\n",val);      
                } else {
                   printf("[ getDtmTrigCountProcess ] : [ WARNING ] no Link nodes found\n");
                }
             } else {
                printf("[ getDtmTrigCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
             }
             
             xmlXPathFreeObject(result);
             
          } else {
             printf("[ getDtmTrigCountProcess ] : [ WARNING ] no results found\n");
          }  
       } else {
             printf("[ getDtmTrigCountProcess ] : [ WARNING ] no xml doc\n");
       }
    } else {
      printf("[ getDtmTrigCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getDtmTrigCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}


int getDtmReadCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dtm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"readcount_sub")==0) {
      strcpy(tmp,"/system/status/TiDtm/ReadCount");
    } else {
      strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
       //if(DEBUG>2) 
       printf("[ getDtmReadCountProcess ] : xpath \"%s\"\n",tmp);
       
       if(doc!=NULL) {
          result =  getnodeset(doc, (xmlChar*) tmp);
          if(result!=NULL) {
             //if(DEBUG>0) 
             printf("[ getDtmReadCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
             if(result->nodesetval->nodeNr==1) {
                node = result->nodesetval->nodeTab[0];
                if(node!=NULL) {
                   val = getIntValue(doc, node);
                   //if(DEBUG>0) 
                   printf("[ getDtmReadCountProcess ]: got val %d.\n",val);      
                } else {
                   printf("[ getDtmReadCountProcess ] : [ WARNING ] no Link nodes found\n");
                }
             } else {
                printf("[ getDtmReadCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
             }
             
             xmlXPathFreeObject(result);
             
          } else {
             printf("[ getDtmReadCountProcess ] : [ WARNING ] no results found\n");
          }  
       } else {
             printf("[ getDtmReadCountProcess ] : [ WARNING ] no xml doc\n");
       }
    } else {
      printf("[ getDtmReadCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getDtmReadCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}




int getDtmAckCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  int idtm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  idtm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dtm")==0) {     
    idtm = getIntFromEpicsName(pname,3);  
    idpm = getIntFromEpicsName(pname,4);      
    getStringFromEpicsName(pname,action,5,BUF_SIZE);    
    
    if(strcmp(action,"ackcount_sub")==0) {
       sprintf(tmp,"/system/status/TiDtm/AckCount%d",idpm);
    } else {
       strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
       if(DEBUG>2) 
          printf("[ getDtmAckCountProcess ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
         if(DEBUG>0) 
            printf("[ getDtmAckCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
        if(result->nodesetval->nodeNr==1) {
          node = result->nodesetval->nodeTab[0];
          if(node!=NULL) {
             val = getIntValue(doc, node);
             if(DEBUG>0) 
                printf("[ getDtmAckCountProcess ]: got val %d.\n",val);      
          } else {
             printf("[ getDtmAckCountProcess ] : [ WARNING ] no Link nodes found\n");
          }
        } else {
          printf("[ getDtmAckCountProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
        }
        strcpy(tmp,"/system/status/TiDtm/AckCount%d");
        if(DEBUG>2)
           printf("[ getDtmAckCountProcess ] : free xpath result\n");
        xmlXPathFreeObject(result);
      } else {
         printf("[ getDtmAckCountProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getDtmAckCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getDtmAckCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}




int getDtmMinTrigPeriodProcess(char* pname, xmlDoc* doc) {
  int val;
  int idtm;
  char str1[BUF_SIZE];
  char str2[BUF_SIZE];
  char action[BUF_SIZE];
  char tmp[BUF_SIZE];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idtm = -1;
  getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  getStringFromEpicsName(pname,str2,2,BUF_SIZE);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dtm")==0) {     
    idtm = getIntFromEpicsName(pname,3);  

    //cross-check
    if(idtm<0 &&idtm>1) {
       printf("[ getDtmMinTrigPeriodProcess ] : [ ERROR ]: idtm not valid for \"%s\"\n", pname);
       exit(1);
    }

    getStringFromEpicsName(pname,action,4,BUF_SIZE);    
    
    if(strcmp(action,"mintrigperiod_sub")==0) {
       sprintf(tmp,"/system/status/TiDtm/MinTrigPeriod");
    } else {
       strcpy(tmp,""); 
    }
    
    if(strcmp(tmp,"")!=0) {
       if(DEBUG>-1) 
          printf("[ getDtmMinTrigPeriodProcess ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
         if(DEBUG>-1) 
            printf("[ getDtmMinTrigPeriodProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
        if(result->nodesetval->nodeNr==1) {
          node = result->nodesetval->nodeTab[0];
          if(node!=NULL) {
             val = getIntValue(doc, node);
             //if(DEBUG>0) 
                printf("[ getDtmMinTrigPeriodProcess ]: got val %d.\n",val);      
          } else {
             printf("[ getDtmMinTrigPeriodProcess ] : [ WARNING ] no Link nodes found\n");
          }
        } else {
          printf("[ getDtmMinTrigPeriodProcess ] : [ WARNING ] %d Link nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
        }
        strcpy(tmp,"/system/status/TiDtm/MinTrigPeriod%d");
        if(DEBUG>2)
           printf("[ getDtmMinTrigPeriodProcess ] : free xpath result\n");
        xmlXPathFreeObject(result);
      } else {
         printf("[ getDtmMinTrigPeriodProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getDtmMinTrigPeriodProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getDtmMinTrigPeriodProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}








void getRunState(int idpm, xmlDoc* doc, char* state) {
   int dpm;
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   char tmp[BUF_SIZE];
   dpm = idpm;
   strcpy((char*)state, "undef");
   if(DEBUG>0)
      printf("[ getRunState ] : get state of dpm %d (idpm=%d) dpm_doc at %p\n", dpm, idpm, doc);
   if(doc!=NULL) {      
      if(DEBUG>0)
         printf("[ getRunState ]: idpm %d xml ok\n", idpm);    
      if(DEBUG>2) 
         printf("[ getRunStateFromDpmValue ] : get RunState from dpm xml\n");
      sprintf(tmp,"/system/status/RunState");
      if(DEBUG>2) printf("[ getRunStateDpm ] : xpath \"%s\"\n",tmp);
      result =  getnodeset(doc, (xmlChar*) tmp);
      if(result!=NULL) {
         if(DEBUG>2) 
            printf("[ getRunStateFromDpmValue ] : got %d nodes\n", result->nodesetval->nodeNr);
         if(result->nodesetval->nodeNr==1) {
            node = result->nodesetval->nodeTab[0];
            if(node!=NULL) {
               getStrValue(doc, node, state);
               //getRunStateFromDpmValue(doc, (xmlChar*) state);
               if(DEBUG>0)
                  printf("[ getRunState ]: got val %s\n", state);
            } else {
               printf("[ getRunStateFromDpmValue ] : [ WARNING ] no RunState nodes found\n");
               strcpy((char*)state, "no valid node");
            }
         } else {
            printf("[ getRunStateFromDpmValue ] : [ WARNING ] %d RunState nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
            strcpy((char*)state,"wrong nr of nodes");
         }
         xmlXPathFreeObject(result);
      } else {
         printf("[ getRunStateFromDpmValue ] : [ WARNING ] no results found\n");
         strcpy((char*)state, "no xpath results");
      }  
   } else {
      if(DEBUG>0) 
         printf("[ getRunState ]: [ WARNING ]: the dpm %d xml doc status is invalid\n",idpm);
      strcpy(state,"no valid xml");
   }
   if(DEBUG>0) 
      printf("[ getRunStateFromDpmValue ] : returning with state \"%s\"\n", state);
  
   return;
}



void getRunStateFromDpmValue(xmlDocPtr doc, xmlChar* state) {
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  char tmp[BUF_SIZE];
  
  return;
}






int findSystemStr(char* buf, const int MAX, char** start) {
    if(DEBUG>1) printf("[ findSystemStr ]: finding system string from %p and %d chars len with start at %p\n",buf,MAX,*start);
    char* b;
    char* e;
    char* s;
    char* p_ending;
    char* status_tag_s;
    char* status_tag_e;

    b = buf;
    while(1!=0) {    
        s = strstr(b,"<system>");  
        p_ending = strchr(b,'\f');  

        if(s!=NULL) {
            if(p_ending!=NULL) {      
                //check that status exists
                if(DEBUG>1) printf("[ findSystemStr ]: found system at len %d and ending and len %d\n",s-b,p_ending-b);
                status_tag_s = strstr(b,"<status>");
                status_tag_e = strstr(b,"</status>");
                // look at this system string  if status tags are found inside the ending
                if(status_tag_s!=NULL && status_tag_e!=NULL) {
                    if(DEBUG>1) printf("[ findSystemStr ]: found status tags at len %d and %d\n",status_tag_s-b, status_tag_e-b);
                    if((status_tag_s-b)<(p_ending-b) && (status_tag_e-b)<(p_ending-b)) {
                        if(DEBUG>1) printf("[ findSystemStr ]: found status tags inside ending\n");
                        // return this
                        *start = s;
                        e = p_ending-1;
                        if(DEBUG>1) {
                            printf("[ findSystemStr ]: found s at %p and e at %p and *start at %p with len %d \n",s,e,*start,e-s);
                            printf("[ findSystemStr ]: last characters are:\n");
                            int ii;
                            for(ii=-50;ii<=0;++ii) {
                                char ee = *(e+ii);
                                printf("[ findSystemStr ]: %d: '%c'\n",ii,ee);
                            }
                        }
                        return (int)(e-s);
                    }
                } 
                else {
                    // go to next, if there is one
                    b = p_ending+1;
                    if((b-buf)>MAX) return -1;
                }
            } else {
                if(DEBUG>1) printf("[ findSystemStr ]: p_ending couldn't be found\n"); 
                // nothing in this string to work with
                break;
            }
        } else {
            if(DEBUG>1) printf("[ findSystemStr ]: <system> couldn't be found\n"); 
            // nothing in this string to work with
            break;      
        }
    }


    return -1;
}



void pollDpmXmlString(int socketfd, char** xml_string_out, int* len_out) {
   char* buf = NULL;
   char* buf_loop = NULL;
   int buf_len;
   int read_i;
   int read_n;
   int nempty;
   int counter;
   int n_endings;
   time_t timer;
   time_t cur_time;
   struct tm *lt;
   int dt;
   char *pch;
   int k;
   
   
   if(DEBUG>0) printf("[ pollDpmXmlString ]:  from socket %d \n", socketfd);
      
   time(&timer);
   
   
   nempty=0;
   counter=0;
   read_i=0;
   buf_len=0;
   n_endings=0;
   dt=0;
   
   while(dt<3) { 
     
     time(&cur_time);

     dt = difftime(cur_time,timer);
     
     if(DEBUG>1) 
       printf("[ pollDpmXmlString ]: Try to read from socket (nempty %d read_i %d time %ds)\n",nempty,read_i,dt); //,asctime(localtime(&cur_time)));
     
     read_n = 0;
     ioctl(socketfd, FIONREAD, &read_n);
     
     if(DEBUG>1) {
       printf("[ pollDpmXmlString ]: %d chars available on socket\n",read_n);
     }
     


     if(read_n>0) {      
       
       // allocate memory needed
       if(DEBUG>1) printf("[ pollDpmXmlString ]: Allocate %d array\n",read_n);      
       
       // check that the buffer used is not weird
       if(buf_loop!=NULL) {
         printf("[ pollDpmXmlString ]: [ ERROR ]: buf_loop is not null!\n");
         exit(1);
       }
       
       // allocate space to hold the input
       buf_loop = (char*) calloc(read_n+1,sizeof(char));
       
       if(DEBUG>1) printf("[ pollDpmXmlString ]: Allocated buf_loop array at %p strlen %d with %d length \n",buf_loop,strlen(buf_loop),(int)sizeof(char)*(read_n+1));      


       
       // Read from socket
       read_n = read(socketfd,buf_loop,read_n);
       
       if(DEBUG>0) {
          printf("[ pollDpmXmlString ]: Read %d chars from socket\n",read_n);
          printf("[ pollDpmXmlString ]: buf_loop strlen is %d\n",strlen(buf_loop));
       }

       if (read_n < 0) {
         printf("[ pollDpmXmlString ]: [ ERROR ]: read %d from socket\n",read_n);
         exit(1);
       }


       
       // We only want to use the xml ending in order to avouid having problems 
       // parsing the full string with string tools. 
       // Therefore remove terminating chars.
       if(DEBUG>2) printf("[ pollDpmXmlString ]: fix terminations\n");
       for(k=0;k<read_n;++k) {
         if(buf_loop[k]=='\0') {
           if(DEBUG>2) printf("[ pollDpmXmlString ]: fix termination at idx %d in this buf_loop\n",k);
           buf_loop[k]=' ';
         }
       }
       
       // search for xml endings in this buffer
       pch = strchr(buf_loop,'\f'); 
       while(pch!=NULL) { 
         if(DEBUG>1) printf("[ pollDpmXmlString ]: found ending at %p (array index %d) in this buf!\n",pch,pch-buf_loop); 
         n_endings++; 
         pch = strchr(pch+1,'\f'); 
       } 
       
       
       
       // copy to other buffer while looping            
       if(DEBUG>2) printf("[ pollDpmXmlString ]: Copy %d to other buffer (at %p before realloc) \n",read_n,buf);      
       
       // reallocate more memory
       buf = (char*) realloc(buf,sizeof(char)*(buf_len+read_n));
       if(buf==NULL) {
         printf("[ pollDpmXmlString ]: [ ERROR ]: failed to allocated buf\n");
         if(buf_loop==NULL) {
           free(buf_loop);
         }
         exit(1);
       }
       
       if(DEBUG>2) printf("[ pollDpmXmlString ]: Allocated longer buf at %p and copy to pointer %p (offset= %d) \n",buf,buf+buf_len,buf_len);      
       
       
       // do the copy
       memcpy(buf+buf_len,buf_loop,sizeof(char)*read_n);
       
       if(DEBUG>1) printf("[ pollDpmXmlString ]: memcpy done\n");
       
       //update the buffer length counter
       buf_len += read_n;      
       
       if(DEBUG>1) printf("[ pollDpmXmlString ]: free buf_loop\n");

       

       
       // free loop buffer for next loop
       if(buf_loop!=NULL) {
         free(buf_loop);
         buf_loop=NULL;
       }
       
       if(DEBUG>2) printf("[ pollDpmXmlString ]: end of read_i %d with buf strlen %d\n",read_i,strlen(buf));
       
       read_i++;
       
     } // read_n>0
     else {
       if(DEBUG>2) printf("[ pollDpmXmlString ]: Nothing to read from socket. Sleep a little..\n");      
       usleep(1000);
       nempty++;
     } 
     
     
     
     if(n_endings>1) {
       if(DEBUG>1) printf("[ pollDpmXmlString ]: \nfound %d endings at read_i %d with at len %d and strlen %d. Stop reading from buffer\n",n_endings,read_i,buf_len,strlen(buf));      
       break;
     }
     
     
     counter++;
     
     
   } //time out
   
   
   
   if(DEBUG>0) {
     printf("[ pollDpmXmlString ]: Done reading from socket. Found %d endings and a buf_len of %d (dt=%d)\n",n_endings, buf_len, dt);
     if(buf!=NULL) printf("[ pollDpmXmlString ]: strlen %d\n", strlen(buf));
   }
   
   // Now find the substring of the large string buffer that contains the <system/> tags ending with the special termination char
   
   if(buf!=NULL) {

     // Check that I actually found any endings in the buffer
     if(n_endings>=1) {

       if(DEBUG>1) {
         printf("[ pollDpmXmlString ]: \nPick out config and status string between <system> and %d endings in string with strlen %d and buf_len %d\n",n_endings,strlen(buf),buf_len);
         //printf("[ pollDpmXmlString ]: \nbuf: \n%s\n",buf);
       }
       
       // find the <system/> tag substring start/stop pointers
       char* start = NULL;
       char* xml_str = NULL;       
       int len = findSystemStr(buf, buf_len,&start);    
       
       
       // check that I got it.
       if(len>0) {               

         // find the end of the substring
         char* stop = start+len;
         
         if(DEBUG>1) {
           printf("[ pollDpmXmlString ]: len %d start at %p stop at %p\n",len,start, stop);
           printf("[ pollDpmXmlString ]: calloc xml string len %d\n",len+1);
         }
         
         // allocate memory for the substring
         xml_str = (char*) calloc(len+1,sizeof(char));
         
         // do the copy of the substring
         memcpy(xml_str,start,len);
         
         // terminate (remember we removed all of them inside the string)
         xml_str[len] = '\0'; 
         
         if(DEBUG>1) printf("[ pollDpmXmlString ]: \ncopied %d chars to %p with strlen %d\n%s\n",len+1,xml_str,strlen(xml_str),xml_str);
         
         // Set the pointer-to-pointer to the the substring pointer and the size
         *xml_string_out = xml_str;
         *len_out = len+1;
         
         if(DEBUG>1) printf("[ pollDpmXmlString ]: output pars are at %p and len %d\n",*xml_string_out,*len_out);
         
       } 
       else {
         if(DEBUG>0) printf("[ pollDpmXmlString ]: Couldn't find system and/or status string in xml buffer\n");
       }
     
     } else {
       if(DEBUG>0) printf("[ pollDpmXmlString ]: Couldn't find system and/or status string in xml buffer\n");       
     }
     
     free(buf);
     
     
   }
   else {
     if(DEBUG>0) printf("[ pollDpmXmlString ]: The string buffer is empty (null)\n");
   }
   
   if((*xml_string_out)==NULL) {
     if(DEBUG>0) printf("[ pollDpmXmlString ]: No valid xml string extracted from this poll (%d endings)\n",n_endings);
   }
   
   return;
   
}




void getDpmXmlDoc(int sockfd, int dpm, xmlDoc** dpm_doc_ptrptr, char* nodeTypeStr) {

   if(DEBUG>0) printf("[ getDpmXmlDoc ]: from socket %d for %s %d at %p\n",sockfd,nodeTypeStr,dpm,*dpm_doc_ptrptr);

  if(*dpm_doc_ptrptr!=NULL) {
     printf("[ getDpmXmlDoc ]: [ ERROR ]: xml doc is not null!\n");
    exit(1);
  }
  
  // check that the socket is open
  if(sockfd<=0) {
    if(DEBUG>0) printf("[ getDpmXmlDoc ]: [ ERROR ]: socket is not open.\n");
    exit(1);
  }
  
  char* xml_str;
  xml_str = NULL;
  if(DEBUG>2) printf("[ getDpmXmlDoc ]: Before reading xml string (%p)\n",xml_str);
  int xml_str_len = -1;


  pollDpmXmlString(sockfd, &xml_str, &xml_str_len);
  
  if(DEBUG>2) printf("[ getDpmXmlDoc ]: After reading xml string with %d chars (%p)\n",xml_str_len, xml_str);
  
  if(xml_str!=NULL) {
    if(DEBUG>1) printf("[ getDpmXmlDoc ]:  xml string is not null\n");
    //int tt=0;
    //for(tt=0;tt<100;++tt) printf("%c\n",*(xml_str+tt));
    if(DEBUG>1) printf("[ getDpmXmlDoc ]:  strlen(xml string) = %d\n", strlen(xml_str));
    if(DEBUG>1) printf("[ getDpmXmlDoc ]:  2 xml string is not null\n");
    
    if(strlen(xml_str)>0) {
      if(DEBUG>1) {
        printf("[ getDpmXmlDoc ]: create xml document from xml string(strlen %d)\n",strlen(xml_str));
        printf("[ getDpmXmlDoc ]: xml string:\n\"%s\"\n",xml_str);
      }
      *dpm_doc_ptrptr = xmlReadMemory(xml_str,strlen(xml_str),"noname.xml",NULL,0);
      if(DEBUG>1) printf("[ getDpmXmlDoc ]: xml doc done %p\n",*dpm_doc_ptrptr);
      if(*dpm_doc_ptrptr!=NULL) {
        xmlNode* dpm_root = xmlDocGetRootElement(*dpm_doc_ptrptr);
        if(dpm_root!=NULL) {
          if(DEBUG>2) {
             printf("[ getDpmXmlDoc ]: found dpm_root name %s\n",(dpm_root)->name);
             printf("[ getDpmXmlDoc ]: print xml to file\n");
          }
          char tmpxmldocname[40];
          sprintf(tmpxmldocname,"%s%d.xml",nodeTypeStr,dpm);
          int bytes_written = xmlSaveFormatFile(tmpxmldocname,(*dpm_doc_ptrptr),1);
          if(DEBUG>2) {
            printf("[ getDpmXmlDoc ]: printed %d bytes of xml to file\n",bytes_written);
          }
        } else {
          printf("[ getDpmXmlDoc ]: [ ERROR ]: xml doc built but no root element found!?\n");
          exit(1);	   
        }
      } else {
        printf("[ getDpmXmlDoc ]: [ ERROR ]: problem building xml doc at %p from \n%s\n",(*dpm_doc_ptrptr),xml_str);
        exit(1);
      }
    } else {
      printf("[ getDpmXmlDoc ]: [ ERROR ]: xml_string is there but has zero string length!\n");	
      exit(1);
    }
  } else {
    printf("[ getDpmXmlDoc ]: [ WARNING ]:  xml_string is NULL after reading from socket!\n");	
  }
  
  if(DEBUG>2)
    printf("[ getDpmXmlDoc ]:  dpm_doc_ptrptr at %p \n", (*dpm_doc_ptrptr));
  
  if(xml_str!=NULL) {
    if(DEBUG>1) printf("[ getDpmXmlDoc ]:  free xml_str at %p \n",xml_str);
    free(xml_str);
  }
  
  
  
  if(DEBUG>0) printf("[ getDpmXmlDoc ]: done.\n");
  
}





void getSyncProcess(char* pname, xmlDoc* doc, char* value) {
   int val;
   int ifeb;
   int idp;
   int iapv;
   char str1[BUF_SIZE];
   char str5[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   ifeb = -1;
   idp = -1;
  
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  
   if(strcmp(str1,"daq")==0) {
    
      getStringFromEpicsName(pname,str5,5,BUF_SIZE);
    
      if(strcmp(str5,"syncbase_rd_asub")==0) {      
         ifeb = getIntFromEpicsName(pname,2);  
         idp = getIntFromEpicsName(pname,3);  
         iapv = getIntFromEpicsName(pname,4);        
         sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/HybridSyncStatus[@index=\"%d\"]/Base%d", ifeb, idp, iapv);      
      } else if(strcmp(str5,"syncpeak_rd_asub")==0) {
         ifeb = getIntFromEpicsName(pname,2);  
         idp = getIntFromEpicsName(pname,3);  
         iapv = getIntFromEpicsName(pname,4);        
         sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/HybridSyncStatus[@index=\"%d\"]/Peak%d", ifeb, idp, iapv);      
      } else {
         strcpy(tmp,""); 
      }
    
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>2) 
            printf("[ getSyncProcess ] : xpath \"%s\"\n",tmp);

         if(doc!=NULL) {
            
            result =  getnodeset(doc, (xmlChar*) tmp);

            if(result!=NULL) {
               if(DEBUG>0) printf("[ getSyncProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  node = result->nodesetval->nodeTab[0];
                  if(node!=NULL) {
                     getStrValue(doc,node,value);
                     if(DEBUG>0) printf("[ getSyncProcess ]: got val %tmp2.\n",value);      
                  } else {
                     printf("[ getSyncProcess ] : [ WARNING ] no Sync nodes found\n");
                     strcpy(value,"-3");
                  }
               } else {
                  printf("[ getSyncProcess ] : [ WARNING ] %d Sync nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
                  strcpy(value,"-4");	  
               }
               xmlXPathFreeObject(result);	  
            } else {
               if(DEBUG>1)
                  printf("[ getSyncProcess ] : [ WARNING ] no results found\n");
               strcpy(value,"-5");	  	
            }
         } else {
            if(DEBUG>1)
               printf("[ getSyncProcess ] : [ WARNING ] no XML doc\n");
            strcpy(value,"-8");	  	
         }
      } else {
         printf("[ getSyncProcess ]: [ ERROR ]: couldn't find action for this record name \"%s\"!\n",pname);
         strcpy(value,"-6");
      }     
   } else {
      printf("[ getSyncProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);   
      strcpy(value, "-7");
   }

   return;
}




void getInsertedFramesProcess(char* pname, xmlDoc* doc, char* value) {
   int val;
   int idp;
   int iapv;
   char str1[BUF_SIZE];
   char str5[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   idp = -1;
  
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  
   if(strcmp(str1,"daq")==0) {
    
      getStringFromEpicsName(pname,str5,5,BUF_SIZE);
    
      if(strcmp(str5,"insertedframes_rd_asub")==0) {      
         idp = getIntFromEpicsName(pname,3);  
         iapv = getIntFromEpicsName(pname,4);        
         sprintf(tmp,"/system/status/DataDpm/RceCore/DataPath[@index=\"%d\"]/SampleExtractor[@index=\"%d\"]/InsertedFrames",idp,iapv);
         
      } else {
         strcpy(tmp,""); 
      }
    
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>0) 
            printf("[ getInsertedFramesProcess ] : xpath \"%s\"\n",tmp);

         if(doc!=NULL) {
            
            result =  getnodeset(doc, (xmlChar*) tmp);

            if(result!=NULL) {
               if(DEBUG>0) printf("[ getInsertedFramesProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  node = result->nodesetval->nodeTab[0];
                  if(node!=NULL) {
                     getStrValue(doc,node,value);
                     if(DEBUG>0) printf("[ getInsertedFramesProcess ]: got val %s.\n",value);      
                  } else {
                     printf("[ getInsertedFramesProcess ] : [ WARNING ] no Sync nodes found\n");
                     strcpy(value,"-3");
                  }
               } else {
                  printf("[ getInsertedFramesProcess ] : [ WARNING ] %d Sync nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
                  strcpy(value,"-4");	  
               }
               xmlXPathFreeObject(result);	  
            } else {
               if(DEBUG>0)
                  printf("[ getInsertedFramesProcess ] : [ WARNING ] no results found\n");
               strcpy(value,"-5");	  	
            }
         } else {
            if(DEBUG>1)
               printf("[ getInsertedFramesProcess ] : [ WARNING ] no XML doc\n");
            strcpy(value,"-8");	  	
         }
      } else {
         printf("[ getInsertedFramesProcess ]: [ ERROR ]: couldn't find action for this record name \"%s\"!\n",pname);
         strcpy(value,"-6");
      }     
   } else {
      printf("[ getInsertedFramesProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);   
      strcpy(value, "-7");
   }

   return;
}



void getEBEventErrorCountProcess(char* pname, xmlDoc* doc, char* value) {
   int val;
   int idp;
   int iapv;
   char str1[BUF_SIZE];
   char str5[BUF_SIZE];
   char tmp[BUF_SIZE];
   xmlXPathObjectPtr result;
   xmlNodePtr node;
   val = -1;
   idp = -1;
  
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
  
   if(strcmp(str1,"daq")==0) {
    
      getStringFromEpicsName(pname,str5,3,BUF_SIZE);
    
      if(strcmp(str5,"ebeventerrorcount_rd_asub")==0) {      
         sprintf(tmp,"/system/status/DataDpm/RceCore/EventBuilder/EventErrorCount");
      } else {
         strcpy(tmp,""); 
      }
      
      if(strcmp(tmp,"")!=0) {
         if(DEBUG>-1) 
            printf("[ getEBEventErrorCountProcess ] : xpath \"%s\"\n",tmp);

         if(doc!=NULL) {
            
            result =  getnodeset(doc, (xmlChar*) tmp);

            if(result!=NULL) {
               if(DEBUG>-1) printf("[ getEBEventErrorCountProcess ] : got %d nodes\n", result->nodesetval->nodeNr);
               if(result->nodesetval->nodeNr==1) {
                  node = result->nodesetval->nodeTab[0];
                  if(node!=NULL) {
                     getStrValue(doc,node,value);
                     if(DEBUG>-1) printf("[ getEBEventErrorCountProcess ]: got val %s.\n",value);      
                  } else {
                     printf("[ getEBEventErrorCountProcess ] : [ WARNING ] no Sync nodes found\n");
                     strcpy(value,"-3");
                  }
               } else {
                  printf("[ getEBEventErrorCountProcess ] : [ WARNING ] %d Sync nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
                  strcpy(value,"-4");	  
               }
               xmlXPathFreeObject(result);	  
            } else {
               if(DEBUG>-1)
                  printf("[ getEBEventErrorCountProcess ] : [ WARNING ] no results found\n");
               strcpy(value,"-5");	  	
            }
         } else {
            if(DEBUG>1)
               printf("[ getEBEventErrorCountProcess ] : [ WARNING ] no XML doc\n");
            strcpy(value,"-8");	  	
         }
      } else {
         printf("[ getEBEventErrorCountProcess ]: [ ERROR ]: couldn't find action for this record name \"%s\"!\n",pname);
         strcpy(value,"-6");
      }     
   } else {
      printf("[ getEBEventErrorCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);   
      strcpy(value, "-7");
   }

   return;
}






void getHybSync(char* pname, xmlDoc* doc, char* syncStr) {
   if(DEBUG>1) 
         printf("[ getHybSync ] : for pname \"%s\"\n", pname);

   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   char tmp[BUF_SIZE];
   int feb;
   int datapath;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char action[BUF_SIZE];
   char sync[40];
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,4,BUF_SIZE);
   if(strcmp(str1,"lv")==0 && strcmp(str2,"sync")==0) {    
      feb = getIntFromEpicsName(pname,2);      
      datapath = getIntFromEpicsName(pname,3);      
      getStringFromEpicsName(pname,action,5,BUF_SIZE);    
      //getHybridSync(feb, datapath, action, sync);
      
      if(strcmp(action,"sync_asub")) {
         sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/HybridSyncStatus[@index=\"%d\"]/SyncDetected", feb, datapath);
      }
      else {
         printf("[ getHybSync ] : [ ERROR ] wrong action \"%s\"\n",action);    
      }
      
      if(DEBUG>1) 
         printf("[ getHybSync ] : xpath \"%s\"\n",tmp);


      if(doc!=NULL) {
         
         result = getnodeset(doc, (xmlChar*) tmp);
         
         if(result!=NULL) {
            nodeset = result->nodesetval;
            if(DEBUG>1) 
               printf("[ getHybSync ] : got %d nodes\n", nodeset->nodeNr);
            if(nodeset->nodeNr==1) {
               getStrValue(doc,nodeset->nodeTab[0],(xmlChar*)syncStr);
            } else {
               strcpy(syncStr, "-1");
            }
            
            xmlXPathFreeObject(result);
            
         } else {
            if(DEBUG>1)
               printf("[ getHybSync ] : no nodes found\n");
            strcpy(syncStr, "-1");
         }
      } else {
         if(DEBUG>1)
            printf("[ getHybSync ] : no xml doc found\n");
         strcpy(syncStr, "-8");
      }
   } else {
      printf("[ getHybSync ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
      exit(1);
   }
   
   
}




void flushSocket(int socketfd) {
   int read_total = 0;
   int read_n;
   int dt;
   int n_endings;
   char buf_loop[1024];
   time_t cur_time;
   time_t timer;
   
   if(DEBUG>0) printf("[ flushSocket ]: start flush\n");
   
   time(&timer);   
   n_endings=0;
   dt=0;
   
   while(n_endings<1) {      
     
     time(&cur_time);
     dt = difftime(cur_time,timer);
     
     if(dt>2) break;
     
     if(DEBUG>1) printf("[ flushSocket ]: Read %d from socket\n",read_n);
     
     // Read from socket
     read_n = read(socketfd,buf_loop,1023);
     buf_loop[1023] = '\0';
     if(DEBUG>1) printf("[ flushSocket ]: Flushed %d chars\n",read_n);
     //printf("\n----\n\"%s\"\n----\n",buf_loop);
     if (read_n < 0) {
       printf("[ flushSocket ]: [ ERROR ]: read %d from socket\n",read_n);
       exit(1);
     }         
     
     if(read_n>0) {
       // search for xml endings in this buffer
       char* pch = strchr(buf_loop,'\f'); 
       if(pch!=NULL) { 
	 if(DEBUG>0) printf("[ flushSocket ]: found ending at %p (array index %d) in this buf!\n",pch,pch-buf_loop); 
	 n_endings++; 
       } 
     }
     
     read_total += read_n;               
     
   }
   
   if(DEBUG>0) printf("[ flushSocket ]: Done flushing socket, found %d endings and flushed %d in total in dt=%ds.\n",n_endings,read_total,dt);
   
   return;
   

} 



void writeHybridSwitchProcess(const char* pname, const int value, const int socket, const char* layer) {

   int feb_id;
   int feb_ch;
   char tmp[BUF_SIZE];
   char type[BUF_SIZE];
   char ch_name[BUF_SIZE];
   char action[BUF_SIZE];
   char buffer[BUF_SIZE];
   char hyb_tag[BUF_SIZE];
   char toggle[BUF_SIZE];
   char open_tag[BUF_SIZE];
   char close_tag[BUF_SIZE];
   int n;
   
   
               
   if(value==1) sprintf(toggle,"%s","True");
   else sprintf(toggle,"%s","False");
   

   
   getStringFromEpicsName(pname,type,1,BUF_SIZE);
   
   if(strcmp(type,"lv")==0) {

      feb_id = getIntFromEpicsName(pname,2);    

      if(DEBUG>-1) printf("[ writeHybridSwitchProcess ] : got feb_id %d which is layer %s\n",feb_id, layer);

      
      if(feb_id>=0) {
         
         // check if this is all hybrids on a feb or individual
         getStringFromEpicsName(pname,tmp,3,BUF_SIZE);

         if(DEBUG>-1) printf("[ writeHybridSwitchProcess ] : got type %s\n",tmp);


         if(strcmp(tmp,"all")==0) {
            
            // do all hybrids on this feb

            getStringFromEpicsName(pname,action,4,BUF_SIZE);
            
            if(strcmp(action,"switch_sub")==0) { 
               const int BIG_BUF_SIZE = 1024;
               char bigbuffer[BIG_BUF_SIZE];
               memset(bigbuffer,0,BIG_BUF_SIZE);
               
               // open tags

               char* bb_ptr = bigbuffer;
               sprintf(bb_ptr,"<system><config><ControlDpm><FebFpga index=\"%d\"><FebCore>",feb_id);
               bb_ptr = bb_ptr + strlen(bigbuffer)-1+1;

               // add the hybrid cmd's
               int nHybrids;
               if(strstr(layer,"L1")==NULL)
                  nHybrids = 4;
               else
                  nHybrids = 2;
               for(feb_ch=0;feb_ch<nHybrids;++feb_ch) {
                  sprintf(buffer,"<Hybrid%dPwrEn>%s</Hybrid%dPwrEn>",feb_ch,toggle,feb_ch);
                  // check that we don't overrun the biffer
                  if((bb_ptr-bigbuffer+strlen(buffer))<BIG_BUF_SIZE) {
                     // copy the string into the buffer
                     strcpy(bb_ptr,buffer);
                     //point to the next char
                     bb_ptr = bb_ptr + strlen(buffer)-1+1; 
                     //reset loop buffer
                     memset(buffer,0,BUF_SIZE);
                  } else {
                     printf("[ writeHybridSwitchProcess ] : [ ERROR ] : bigbuffer is too small to hold command\n");
                     exit(1);                     
                  }
               }
               
               // close the tags
               strcpy(buffer,"</FebCore></FebFpga></ControlDpm></config></system>");
               strcpy(bb_ptr,buffer);
               bb_ptr =  bb_ptr + strlen(buffer)-1+1;
               

               // add the end of command char
               *bb_ptr = '\f';
               
               printf("[ writeHybridSwitchProcess ] : cmd \"%s\"\n",bigbuffer);
               
               // write to sicket file desc.
               n = write(socket,bigbuffer,strlen(bigbuffer));
               
               if(n<0) 
                  socket_error("[ writeHybridSwitchProcess ] : [ ERROR ] : couldn't write to socket");
               else 
                  printf("[ writeHybridSwitchProcess ] : wrote %d chars to socket\n",n);
               
               
               
            } else {
               printf("[ writeHybridSwitchProcess ]: [ ERROR ]: this hybrid action type is not valid \"%s\"\n",action);
            }    
            
            
         } else {

            // do single hybrid on this feb
            
            feb_ch = getIntFromEpicsName(pname,3);   
            
            if(feb_ch>=0 && feb_ch<=3) {
               
               getStringFromEpicsName(pname,action,5,BUF_SIZE);
               
               if(strcmp(action,"switch_sub")==0) { 
                  
                  
                  getStringFromEpicsName(pname,ch_name,4,BUF_SIZE);
                  
                  if(strcmp(ch_name,"dvdd")==0 || 
                     strcmp(ch_name,"avdd")==0 || 
                     strcmp(ch_name,"v125")==0 || 
                     strcmp(ch_name,"all")==0) {
                     
                     getFebCnfCmd(feb_id,1,open_tag,BUF_SIZE);
                     getFebCnfCmd(feb_id,0,close_tag,BUF_SIZE);
                     sprintf(hyb_tag,"Hybrid%dPwrEn",feb_ch);
                     sprintf(buffer,"%s<%s>%s</%s>%s\f",open_tag,hyb_tag,toggle,hyb_tag,close_tag);
                     
                     printf("[ writeHybridSwitchProcess ] : cmd \"%s\"\n",buffer);
                     
                     n = write(socket,buffer,strlen(buffer));
                     
                     if(n<0) 
                        socket_error("[ writeHybridSwitchProcess ] : [ ERROR ] : couldn't write to socket");
                     else 
                        printf("[ writeHybridSwitchProcess ] : wrote %d chars to socket\n",n);
                     
                     //writeHybridSwitch(socket, value, feb_id, hyb_id);
                     //writeHybrid(precord,action,feb_ch,feb_id,ch_name);  
                     
                  } else {
                     printf("[ writeHybridSwitchProcess ]: [ ERROR ]: wrong option for hybrid ch: %s\n",ch_name);
                  }
               } else {
                  printf("[ writeHybridSwitchProcess ]: [ ERROR ]: this hybrid action type is not valid \"%s\"\n",action);
               }    
               
               
               
            } else {
               printf("[ writeHybridSwitchProcess ]: [ ERROR ]: getting feb ch\n");
            } 
         }
      } else {
         printf("[ writeHybridSwitchProcess ]: [ ERROR ]: getting feb id\n");
      } 
   } else {
      printf("[ writeHybridSwitchProcess ]: [ ERROR ]: this type is not valid \"%s\"\n",type);
   }  
   
   return;
}



void getFebCnfCmd(int feb_id, int isopentag,  char* cmd, const int MAX) {
   char tmp[MAX];
   if(isopentag==0) 
      sprintf(tmp,"</FebCore></FebFpga></ControlDpm></config></system>");
   else
      sprintf(tmp,"<system><config><ControlDpm><FebFpga index=\"%d\"><FebCore>",feb_id);
   strcpy(cmd,tmp);
}






int checkNonZeroNodes(xmlDoc* document, const char* xpath) {
   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   xmlNodePtr node;
   xmlNodePtr children;
   int i;
   int nnonzero;
   int n;
   nnonzero=0;
   if(DEBUG>1) printf("[ checkNonZeroNodes ] :search xpath=\"%s\" \n", xpath);
   result = getnodeset(document, (xmlChar*) xpath);
   if(result!=NULL) {
      nodeset = result->nodesetval;
      if(DEBUG>1) printf("[ checkNonZeroNodes ] : found %d results for xpath=\"%s\" \n", nodeset->nodeNr,xpath);
      for(i=0;i<nodeset->nodeNr;++i) {
         node = nodeset->nodeTab[i];
         if(node!=NULL) {
            children = node->xmlChildrenNode;
            n++;
            if(children==NULL) {
               if(DEBUG>1) printf("[ checkNonZeroNodes ] : no children found for node %s.\n", node->name);
            } else {
               if(DEBUG>1) printf("[ checkNonZeroNodes ] : found children for node %s.\n", node->name);               
               nnonzero++;
            }
         } else {
            printf("[ checkNonZeroNodes ] : [ ERROR ] :  couldn't find node!\n");
         }
      }
      xmlXPathFreeObject(result);	
   } else {
      if(DEBUG>1) printf("[ checkNonZeroNodes ] : no results found.\n");
   }
   if(DEBUG>1) printf("[ checkNonZeroNodes ] : %d/%d elements had no children\n", nnonzero,n);

   if(nnonzero>0) return 0;
   else return 1;
}


void getNodeVal(xmlDoc* document, const char* xpath, char* value) {
   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   xmlNodePtr node;
   xmlNodePtr children;
   strcpy(value,"");
   if(DEBUG>1) printf("[ getNodeVal ] :search xpath=\"%s\" \n", xpath);
   result = getnodeset(document, (xmlChar*) xpath);
   if(result!=NULL) {
      nodeset = result->nodesetval;      
      if(DEBUG>1) printf("[ getNodeVal ] : found %d results for xpath=\"%s\" \n", nodeset->nodeNr,xpath);
      if(nodeset->nodeNr==1) {
         getStrValue(document, nodeset->nodeTab[0], (xmlChar*)value);
      } else {
         if(DEBUG>1) printf("[ getNodeVal ] : nodes found are different than 1 (=%d).\n", node->name, nodeset->nodeNr);        
      }
      xmlXPathFreeObject(result);	
   } else {
      if(DEBUG>1) printf("[ getNodeVal ] : no results found.\n");
   }
   return;
}



void getHybridTempProcess(char* pname, xmlDoc* doc, char* value) {
   if(DEBUG>1) printf("[ getHybridTempProcess ] : for pname \"%s\"\n", pname);

   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   char tmp[BUF_SIZE];
   int feb;
   int datapath;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char str3[BUF_SIZE];
   char action[BUF_SIZE];
   strcpy(value,"");
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);
   if(strcmp(str1,"temp")==0 && strcmp(str2,"hyb")==0) {
      feb = getIntFromEpicsName(pname,3);      
      datapath = getIntFromEpicsName(pname,4);      
      getStringFromEpicsName(pname,action,5,BUF_SIZE);    
      
      if(strcmp(action,"temp0")==0) {
         sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/SoftPowerMonitor/Hybrid%d_ZTemp", feb, datapath);
         if(DEBUG>1) 
            printf("[ getHybridTempProcess ] : xpath \"%s\"\n",tmp);
         
         if(doc!=NULL) {
            
            result = getnodeset(doc, (xmlChar*) tmp);
            
            if(result!=NULL) {
               nodeset = result->nodesetval;
               if(DEBUG>1) 
                  printf("[ getHybridTempProcess ] : got %d nodes\n", nodeset->nodeNr);
               if(nodeset->nodeNr==1) {
                  getStrValue(doc,nodeset->nodeTab[0],value);
                  if(DEBUG>1) 
                     printf("[ getHybridTempProcess ] : got  value %s\n", value);

               } else {
                  if(DEBUG>1)
                     printf("[ getHybridTempProcess ] : [ WARNING ] : wrong nr of nodes found\n");
               }
               
               xmlXPathFreeObject(result);
               
            } else {
               if(DEBUG>1)
                  printf("[ getHybridTempProcess ] : no nodes found\n");
            }
         } else {
            if(DEBUG>1)
               printf("[ getHybridTempProcess ] : no xml doc found\n");
         }
      }
      else {
         printf("[ getHybridTempProcess ] : [ ERROR ] wrong action \"%s\"\n",action);    
         exit(1);
      }
   } else {
      printf("[ getHybridTempProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
      exit(1);
   }
}



void getFebTempProcess(char* pname, xmlDoc* doc, char* value) {
   if(DEBUG>1) printf("[ getFebTempProcess ] : for pname \"%s\"\n", pname);

   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   char tmp[BUF_SIZE];
   int feb;
   int datapath;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char type[BUF_SIZE];
   char action[BUF_SIZE];
   strcpy(value,"");
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,2,BUF_SIZE);
   if(strcmp(str1,"temp")==0 && strcmp(str2,"fe")==0) {
      feb = getIntFromEpicsName(pname,3);      
      getStringFromEpicsName(pname,action,4,BUF_SIZE);    
      
      
      if(strcmp(action,"axixadc")==0) {
         sprintf(type,"FebFpgaTemp");
      }
      else if(strcmp(action,"FebTemp0")==0) {
         sprintf(type,"FebTemp0");
      }
      else if(strcmp(action,"FebTemp1")==0) {
         sprintf(type,"FebTemp1");
      } else {
         sprintf(type,"");
      }
      
      if(strcmp(type,"")!=0) {
         
         
         sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/SoftPowerMonitor/%s",feb,type);
         
         if(DEBUG>1) 
            printf("[ getFebTempProcess ] : xpath \"%s\"\n",tmp);
         
         if(doc!=NULL) {
            
            result = getnodeset(doc, (xmlChar*) tmp);
            
            if(result!=NULL) {
               nodeset = result->nodesetval;
               if(DEBUG>1) 
                  printf("[ getFebTempProcess ] : got %d nodes\n", nodeset->nodeNr);
               if(nodeset->nodeNr==1) {
                  getStrValue(doc,nodeset->nodeTab[0],value);
                  
                  if(DEBUG>1)
                     printf("[ getFebTempProcess ] : got  value %s\n", value);
                  
               } else {
                  if(DEBUG>1)
                     printf("[ getFebTempProcess ] : [ WARNING ] : wrong nr of nodes found\n");
               }
               
               xmlXPathFreeObject(result);
               
            } else {
               if(DEBUG>1)
                  printf("[ getFebTempProcess ] : no nodes found\n");
            }
         } else {
            if(DEBUG>1)
               printf("[ getFebTempProcess ] : no xml doc found\n");
         }
      }
      else {
         printf("[ getFebTempProcess ] : [ ERROR ] wrong action \"%s\"\n",action);    
         exit(1);
      }
   } else {
      printf("[ getFebTempProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
      exit(1);
   }
}





void getHybridLVProcess(char* pname, xmlDoc* doc, char* value) {
   if(DEBUG>1) printf("[ getHybridLVProcess ] : for pname \"%s\"\n", pname);

   xmlXPathObjectPtr result;
   xmlNodeSetPtr nodeset;
   char tmp[BUF_SIZE];
   int feb;
   int datapath;
   char str1[BUF_SIZE];
   char str2[BUF_SIZE];
   char str3[BUF_SIZE];
   char action[BUF_SIZE];
   char channel[BUF_SIZE];
   char type[BUF_SIZE];
   
   strcpy(value,"");
   getStringFromEpicsName(pname,str1,1,BUF_SIZE);
   getStringFromEpicsName(pname,str2,4,BUF_SIZE);    
   
   
   if(strcmp(str1,"lv")==0) {
      
      if(strcmp(str2,"v125")==0)
         sprintf(channel,"V125");
      else if(strcmp(str2,"avdd")==0)
         sprintf(channel,"AVDD");
      else if(strcmp(str2,"dvdd")==0)
         sprintf(channel,"DVDD");
      else 
         sprintf(channel,"");
      
      if(strcmp(channel,"")!=0) {
         feb = getIntFromEpicsName(pname,2);      
         datapath = getIntFromEpicsName(pname,3);            
         
         getStringFromEpicsName(pname,action,5,BUF_SIZE);    
         
         if(strcmp(action,"i_rd_sub")==0) {
            sprintf(type,"Current");
            sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/SoftPowerMonitor/Hybrid%d_%s_%s", feb, datapath, channel, type);
         }
         else if(strcmp(action,"vn_sub")==0) {
            sprintf(type,"Near");
            sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/SoftPowerMonitor/Hybrid%d_%s_%s", feb, datapath, channel, type);
         }
         else if(strcmp(action,"vf_sub")==0) {
            sprintf(type,"Sense");
            sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/SoftPowerMonitor/Hybrid%d_%s_%s", feb, datapath, channel, type);
         }
         else if(strcmp(action,"stat_sub")==0) {
            sprintf(tmp,"/system/status/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/Hybrid%dPwrOn", feb, datapath);
         }
         else if(strcmp(action,"v_set_rd_sub")==0) {
            // need to fix the names for this particular one
            strcpy(channel,"");
            if(strcmp(str2,"v125")==0)
               sprintf(channel,"V1_25");
            else if(strcmp(str2,"avdd")==0)
               sprintf(channel,"Avdd");
            else 
               sprintf(channel,"Dvdd");
            sprintf(tmp,"/system/config/ControlDpm/FebFpga[@index=\"%d\"]/FebCore/Hybrid%d%sTrim",feb,datapath,channel);
            
         }
         else
            sprintf(tmp,"");
            
            if(strcmp(tmp,"")!=0) {
            
            if(DEBUG>1) 
               printf("[ getHybridLVProcess ] : xpath \"%s\"\n",tmp);
            
            if(doc!=NULL) {
               
               result = getnodeset(doc, (xmlChar*) tmp);
               
               if(result!=NULL) {
                  nodeset = result->nodesetval;
                  if(DEBUG>1) 
                     printf("[ getHybridLVProcess ] : got %d nodes\n", nodeset->nodeNr);
                  if(nodeset->nodeNr==1) {
                     getStrValue(doc,nodeset->nodeTab[0],value);
                     
                     if(DEBUG>1)
                        printf("[ getHybridLVProcess ] : got  value %s\n", value);
                     
                  } else {
                     if(DEBUG>1)
                        printf("[ getHybridLVProcess ] : [ WARNING ] : wrong nr of nodes found\n");
                  }
                  
                  xmlXPathFreeObject(result);
                  
               } else {
                  if(DEBUG>1)
                     printf("[ getHybridLVProcess ] : no nodes found\n");
               }
            } else {
               if(DEBUG>1)
                  printf("[ getHybridLVProcess ] : no xml doc found\n");
            }
         }
         else {
            printf("[ getHybridLVProcess ] : [ ERROR ] unknown action for pname \"%s\"\n",pname);    
            exit(1);
         }
      }
      else {
         printf("[ getHybridLVProcess ] : [ ERROR ] wrong channel for pname \"%s\"\n",pname);    
         exit(1);
      }
      
   } else {
      printf("[ getHybridLVProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
      exit(1);
   }
}

