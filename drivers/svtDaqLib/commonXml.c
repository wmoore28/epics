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



void getSubStrFromName(char name[],const int i, char board_type[], const int MAX) {
    char buf[MAX];
    strcpy(buf,name);
    strcpy(board_type,"");
    int idx;
    char* pch;
    memset(board_type,'\0',MAX);
    pch = strtok(buf,":");
    idx=0;
    while(pch!=NULL) {
        if(idx==i) {
            if(strlen(pch)>MAX) {
                printf("ERROR pch string is too long!\n");	
            } else {
                strcpy(board_type,pch);
                break;
            }
        }
        idx++;    
        pch = strtok(NULL,":");
    }  
    //printf("[ getSubStrFromName ] : got %s \n",board_type);
    return;
}

void getStringFromEpicsName(char name[], char str[], int idx) {   
   getSubStrFromName(name,idx,str,256);
}

int getIntFromEpicsName(char name[], int idx) {   
   char str[256];
   if(DEBUG>2) printf("[ getIntFromEpicsName ] : name %s idx %d\n", name, idx);
   getSubStrFromName(name,idx,str,256);
   char* p_end = str;
   int id = (int) strtol(str,&p_end,0);
   if(p_end==str) {
     printf("[ getIntFromEpicsName ]: [ ERROR ]: invalid convertion of this feb id %s\n",str);
      return -1;      
   }
   if(DEBUG>2) printf("[ getIntFromEpicsName ] : got %d\n", id);
   return id;
}


void getRunStateProcess(char* pname, xmlDoc* doc, char* state) {

  int idpm;
  char str1[256];
  char str2[256];
  char action[256];
  getStringFromEpicsName(pname,str1,1);
  getStringFromEpicsName(pname,str2,2);
  if(strcmp(str1,"daq")==0 && (strcmp(str2,"dtm")==0 ||strcmp(str2,"dpm")==0)) {
    idpm = getIntFromEpicsName(pname,3);  
    getStringFromEpicsName(pname,action,4);    
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

int getFebNumProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  int idp;
  char str1[256];
  char str2[256];
  char action[256];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  char tmp[256];
  val = -1;
  idpm = -1;
  idp = -1;
  getStringFromEpicsName(pname,str1,1);
  getStringFromEpicsName(pname,str2,2);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    idp = getIntFromEpicsName(pname,4);  
        
    getStringFromEpicsName(pname,action,5);    
    
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
      } else {
	printf("[ getFebNumProcess ] : [ WARNING ] no results found\n");
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
  char str1[256];
  char str2[256];
  char action[256];
  char tmp[256];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  idp = -1;
  getStringFromEpicsName(pname,str1,1);
  getStringFromEpicsName(pname,str2,2);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    idp = getIntFromEpicsName(pname,4);  
    
    getStringFromEpicsName(pname,action,5);    
    
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
	      char tmp2[256];
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
      } else {
	printf("[ getLinkProcess ] : [ WARNING ] no results found\n");
      }  
      

    } else {
      printf("[ getLinkProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getLinkProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}





int getEventCountProcess(char* pname, xmlDoc* doc) {
  int val;
  int idpm;
  char str1[256];
  char str2[256];
  char action[256];
  char tmp[256];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  idpm = -1;
  getStringFromEpicsName(pname,str1,1);
  getStringFromEpicsName(pname,str2,2);

  if(strcmp(str1,"daq")==0 && strcmp(str2,"dpm")==0) {     
    idpm = getIntFromEpicsName(pname,3);  
    
    getStringFromEpicsName(pname,action,4);    
    
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
              char tmp2[256];
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
      } else {
        printf("[ getEventCountProcess ] : [ WARNING ] no results found\n");
      }  
      
      
    } else {
      printf("[ getEventCountProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
    }     
  } else {
    printf("[ getEventCountProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);    
  }
  return val;
}








void getRunState(int idpm, xmlDoc* doc, char* state) {
  int dpm;
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  char tmp[256];
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
  char tmp[256];
  
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
       
       //if(DEBUG>1) 
       printf("[ pollDpmXmlString ]: Read %d chars from socket\n",read_n);
       printf("[ pollDpmXmlString ]: buf_loop strlen is %d\n",strlen(buf_loop));
       
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




void getDpmXmlDoc(int sockfd, int dpm, xmlDoc** dpm_doc_ptrptr) {

  if(DEBUG>0) printf("[ getDpmXmlDoc ]: from socket %d for dpm %d at %p\n",sockfd,dpm,*dpm_doc_ptrptr);

  if(*dpm_doc_ptrptr!=NULL) {
    if(DEBUG>-1) printf("[ getDpmXmlDoc ]: [ ERROR ]: xml doc is not null!\n");
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
          sprintf(tmpxmldocname,"dpm%d.xml",dpm);
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
    printf("[ getDpmXmlDoc ]:  free xml_str at %p \n",xml_str);
    free(xml_str);
  }
  
  
  
  if(DEBUG>0) printf("[ getDpmXmlDoc ]: done.\n");
  
}





void getSyncProcess(char* pname, xmlDoc* doc, char* value) {
  int val;
  int ifeb;
  int idp;
  int iapv;
  char str1[256];
  char str5[256];
  char action[256];
  char tmp[256];
  xmlXPathObjectPtr result;
  xmlNodePtr node;
  val = -1;
  ifeb = -1;
  idp = -1;
  
  getStringFromEpicsName(pname,str1,1);
  
  if(strcmp(str1,"daq")==0) {
    
    getStringFromEpicsName(pname,str5,5);
    
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
	    strcpy(value,"no nodes");
	  }
	} else {
	  printf("[ getSyncProcess ] : [ WARNING ] %d Sync nodes found, should be exactly 1\n", result->nodesetval->nodeNr);
	  strcpy(value,"too many nodes");	  
	}	  
      } else {
	if(DEBUG>1)
	  printf("[ getSyncProcess ] : [ WARNING ] no results found\n");
	strcpy(value,"no result");	  	
      }  
    } else {
      printf("[ getSyncProcess ]: [ ERROR ]: wrong action \"%s\"!\n",action);
      strcpy(value,"wrong action");
    }     
  } else {
    printf("[ getSyncProcess ]: [ ERROR ]: wrong record name? \"%s\"!\n",pname);   
    strcpy(value, "record");
  }

  return;
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
