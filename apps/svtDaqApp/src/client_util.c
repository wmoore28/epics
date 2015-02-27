#include "client_util.h"
#include <time.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/ioctl.h>
#include "febxml.h"
#include "dpmxml.h"
#include "hybxml.h"
#include "socket.h"
#include "commonConstants.h"
#include "commonXml.h"
#include "status.h"
#include "commonDoc.h"

//int client_util_debug = 2;
char *xml_string = NULL;
char *dpm_xml_string[N_DPM] = {NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
xmlDoc* dpm_xml_doc[N_DPM] = {NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
xmlNode* dpm_xml_root[N_DPM] = {NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
xmlDoc* doc = NULL;
xmlDoc* doc_prev = NULL;
xmlNode* xml_root = NULL;
int xml_poll_status = 0;

void free_xml_string() {
    if(DEBUG>2) printf("free_xml_string(): at %p\n",xml_string);
    if(xml_string!=NULL) {
        free(xml_string);
        xml_string = NULL;
        if(DEBUG>2) printf("free_xml_string(): done\n");
    } else {
        if(DEBUG>2) printf("free_xml_string(): already nil\n");
    }
    if(DEBUG>2) printf("free_xml_string(): now at %p\n",xml_string);
}


void free_dpm_xml_string(int dpm) {
   if(DEBUG>2) printf("[ free_xml_string ] : for dpm %d at %p\n", dpm,dpm_xml_string[dpm]);
    if(dpm_xml_string[dpm]!=NULL) {
        free(dpm_xml_string[dpm]);
        dpm_xml_string[dpm] = NULL;
        if(DEBUG>2) printf("[ free_xml_string ] : done\n");
    } else {
        if(DEBUG>2) printf("[ free_xml_string ] : already nil\n");
    }
    if(DEBUG>2) printf("[ free_xml_string ] : now at %p\n",dpm_xml_string[dpm]);
}







double extractTempValFromString(char value[]) {
    double t = 0.0;
    char* p_start = strstr(value,"C (");
    if(p_start != NULL) {
        char* t_str = (char*) malloc(p_start-value); //strlen(value));
        memcpy(t_str,value,p_start-value);//,p_start-value);
        t = atof(t_str);
        //if(mySubDebug) {
        //  printf("convert %s to float %f\n",t_str,t);
        //}
        free(t_str);
    } 
    return t;
}



void getHalfFromDaqMapRecordName(char name[], char board_type[], const int MAX) {
    return getSubStrFromName(name,3,board_type,MAX);
}
void getHybridFromDaqMapRecordName(char name[], char board_type[], const int MAX) {
    return getSubStrFromName(name,4,board_type,MAX);
}





void getXmlDoc(int sockfd, int read_status, int read_config) {

    if(DEBUG>1) printf("[ getXmlDoc ]: from socket %d (read_status %d read_config %d)\n",sockfd,read_status,read_config);

    // check that I'm not already polling it
    if(xml_poll_status==1) {
        if(DEBUG>1) printf("[ getXmlDoc ]: already polling so don't continue for this process (%d,%p)\n",xml_poll_status,xml_string);    
        return;
    }

    // occupy the poll flag
    xml_poll_status = 1;

    //clear old documents
    if(DEBUG>2) printf("[ getXmlDoc ]: free xml string %p\n",xml_string);
    free_xml_string();
    //if(xml_string!=NULL) {
    //  free(xml_string);
    //}
    if(DEBUG>2) printf("[ getXmlDoc ]: free xml string done %p\n",xml_string);
    if(doc!=NULL) {
       
       if(doc_prev!=NULL) {
          if(DEBUG>2) printf("[ getXmlDoc ]: free the prev xml doc\n");
          xmlFreeDoc(doc_prev);
          doc_prev=NULL;
       }
       if(DEBUG>2) printf("[ getXmlDoc ]: copy to prev xml doc\n");
       doc_prev = xmlCopyDoc(doc,1);
       
       if(DEBUG>2) printf("[ getXmlDoc ]: free current xml doc\n");       
       xmlFreeDoc(doc);
       xmlCleanupParser();
       doc=NULL;
       xml_root=NULL;
    }
    if(DEBUG>2) printf("[ getXmlDoc ]: free xml doc done\n");

    // check that the socket is open
    if(sockfd<=0) {
        if(DEBUG>2) printf("[ getXmlDoc ]: socket is not open.\n");
        //clear the flag
        xml_poll_status = 0;
        return;
    }


    // Do a status and config read to be sure to catch all info
    // Need to see exactly how the falgs are set in the return string 
    // from the server to see what to do here.

    if(read_status>0) {

        if(DEBUG>2) printf("[ getXmlDoc ]: ReadStatus\n");

        writeReadStatus(sockfd);

    }

    if(read_config>0) {

        if(DEBUG>2) printf("[ getXmlDoc ]: ReadConfig\n");

        writeReadConfig(sockfd);

    }

    if(DEBUG>2) printf("[ getXmlDoc ]: Before reading xml string (%p)\n",xml_string);

    pollXmlString(sockfd);

    if(DEBUG>2) printf("[ getXmlDoc ]: After reading xml string (%p)\n",xml_string);

    if(xml_string!=NULL) {
        if(strlen(xml_string)>0) {
           if(DEBUG>1) printf("[ getXmlDoc ]: create xml document from xml string(strlen %d)\n",strlen(xml_string));
            if(DEBUG>1) printf("[ getXmlDoc ]: xml string:\n%s\n",xml_string);
            doc = xmlReadMemory(xml_string,strlen(xml_string),"noname.xml",NULL,0);
            if(DEBUG>1) printf("[ getXmlDoc ]: xml doc done %p\n",doc);
            if(doc!=NULL) {
                xml_root = xmlDocGetRootElement(doc);
                if(xml_root!=NULL) {
                   if(DEBUG>2) {
                      printf("[ getXmlDoc ]: found xml_root name %s\n",(xml_root)->name);
                      printf("[ getXmlDoc ]: print xml to file\n");
                   }
                   int bytes_written = xmlSaveFormatFile("svtdaq.xml",doc,1);
                   if(DEBUG>2) {
                      printf("[ getXmlDoc ]: printed %d bytes of xml to file\n",bytes_written);
                   }
                }
            } else {
                printf("[ getXmlDoc ]: [ ERROR ]: problem building xml doc at %p from \n%s\n",doc,xml_string);
                exit(1);
            }
        } else {
            printf("[ getXmlDoc ]: [ ERROR ]: xml_string is there but has zero string length!\n");	
            exit(1);
        }
    } else {
        printf("[ getXmlDoc ]: [ WARNING ]:  xml_string is NULL after reading from socket!\n");	
    }

    //clear the flag
    xml_poll_status = 0;
    if(DEBUG>0) printf("[ getXmlDoc ]: cleared the flag and return (%d)\n",xml_poll_status);

}








int getXmlPollStatus() {
   // check that we have an xml file
   int cmpDump;
   int nonZero;
   int cmpNodes;
   int xmlStrExists;
   int xmlDocExists;
   cmpDump = 1;
   nonZero = 1;
   cmpNodes = 1;
   xmlStrExists = 1;
   xmlDocExists = 1;
   if(xml_string!=NULL) {
     if(strlen(xml_string)>0) {
       xmlStrExists = 0;
       if(doc!=NULL) {
	 xmlDocExists = 0;	 
	 if(DEBUG>0) printf("[ getXmlPollStatus ] : xml doc exists.\n");	 
	 if(DEBUG>0) printf("[ getXmlPollStatus ] : check non-zero nodes.\n");
	 nonZero = checkNonZeroNodes(doc);
	 if(DEBUG>0) printf("[ getXmlPollStatus ] : nonZero = %d\n",nonZero);
         
	 // compare a xml dump to previous
	 if(doc_prev!=NULL) {
	   
	   if(DEBUG>0) printf("[ getXmlPollStatus ] : compare xml doc to prev.\n");
	   //cmpDump = compareXmlDump(doc, doc_prev);
	   cmpDump = 0;
	   if(DEBUG>0) printf("[ getXmlPollStatus ] : cmpDump = %d\n", cmpDump);                              
           
	   if(DEBUG>0) printf("[ getXmlPollStatus ] : check node contents.\n");
	   cmpNodes = compareNodeSets(doc, doc_prev);
	   if(DEBUG>0) printf("[ getXmlPollStatus ] : cmpNodes = %d\n",cmpNodes);            
           
	 } else {
	   if(DEBUG>0) printf("[ getXmlPollStatus ] : no prev doc to compare to.\n");
	   cmpDump = 0;
	   cmpNodes = 0;
	 }	 
       }
     }
   } 
   
   if(xmlStrExists == 0) {
     printf("[ getXmlPollStatus ] : check that xml str exists -> OK\n");
   } else {
     printf("[ getXmlPollStatus ] :  [ WARNING ] : check that xml str exists -> FAILED!\n");
   }

   if(xmlDocExists == 0) {
     printf("[ getXmlPollStatus ] : check that xml doc exists -> OK\n");
   } else {
     printf("[ getXmlPollStatus ] :  [ WARNING ] : check that xml doc exists -> FAILED!\n");
   }

   if(nonZero == 0) {
     printf("[ getXmlPollStatus ] : check that nodes are non-empty -> OK\n");
   } else {
     printf("[ getXmlPollStatus ] :  [ WARNING ] : check that nodes are non-empty -> FAILED!\n");
   }
   
   if(cmpDump == 0) {
     printf("[ getXmlPollStatus ] : check that previous xml poll is not identical -> OK\n");
   } else {
     printf("[ getXmlPollStatus ] : [ ERROR ]: check that previous xml poll is not identical -> FAILED\n");
   }

   if(cmpNodes == 0) {
      printf("[ getXmlPollStatus ] : check that specific xml node values are updating -> OK\n");
   } else {
     printf("[ getXmlPollStatus ] : [ ERROR ] : check that specific xml node values are updating -> FAILED\n");
   }
   
   int status;
   if(xmlStrExists!=0)      status = 1;
   else if(xmlDocExists!=0) status = 2;
   else if(nonZero!=0)      status = 3;
   else if(cmpDump!=0)      status = 4;
   else if(cmpNodes!=0)      status = 5;
   else {
     printf("[ getXmlPollStatus ] : XML t OK.\n");
     status = 0;
   } 

   if(status!=0) 
     printf("[ getXmlPollStatus ] : [ ERROR ] : XML document NOT OK.\n");
   
   return status;
   
}





void writeReadConfig(int sockfd) {
    int n;
    //char buffer[] = "<system><command>ReadConfig</command></system>\f";
    char buffer[] = "<system><command><ReadConfig/></command></system>\f";
    if(DEBUG) printf("writeReadConfig: Executing:\"%s\"\n",buffer);
    n = write(sockfd,buffer,strlen(buffer));
    if(n<0) 
        socket_error("writeReadConfig: ERROR writing to socket");
    return;
}

void writeReadStatus(int sockfd) {
    int n;
    char buffer[] = "<system><command><ReadStatus/></command></system>\f";
    if(DEBUG) printf("writeReadStatus: Executing:\"%s\"\n",buffer);
    n = write(sockfd,buffer,strlen(buffer));
    if(n<0) 
        socket_error("writeReadStatus: ERROR writing to socket");
    return;
}

int getDataDpmId(int i) {
  int dpm;
  if(i>=0 && i<N_DPM) {
    if(i < 7) 
      dpm = i;
    else 
      dpm = i+1;    
  } 
  else {
    printf("[ getDataDpmId ]: [ ERROR [ : invalid index %d\n", i);
    exit(1);
  }
  return dpm;
}

int getDataDpmIndex(int dpm) {
  int i;
  i=-1;
  if(dpm>=0 && dpm<N_DPM) {
    if(dpm!=7) {
      if(dpm < 7) 
	i = dpm;
      else 
	i = dpm-1;    
    }
    else {
      printf("[ getDataDpmId ]: [ ERROR [ : invalid data dpm %d\n",dpm );
      exit(1);
    }
  }
  else {
    printf("[ getDataDpmId ]: [ ERROR [ : invalid data dpm %d\n", dpm);
    exit(1);
  }
  return i;
}


int getXmlDocStatus() {
   if(doc==NULL) {
      return 1;
   }
   if(xml_root==NULL) {
      return 2;
   }  
   return 0;
}


int getAllDpmXmlDocStatus() {
   int idpm;
   int status = 0;
   for(idpm=0; idpm<N_DPM; ++idpm) {
      status = getDpmXmlDocStatus(idpm);
      if(status!=0) {
         return status;
      }
   }
   return status;
}

int getDpmXmlDocStatus(int idpm) {
   if(dpm_xml_doc[idpm]==NULL) {
      return 1;
   }
   if(dpm_xml_root[idpm]==NULL) {
      return 2;
   }  
   return 0;
}


void getXMLValue(char tag[], char value[],const unsigned int MAX) {
    if(DEBUG>0) printf("[ getXMLValue ]: tag \"%s\"\n",tag);
    if(doc==NULL) {
        if(DEBUG>0) printf("[ getXMLValue ]: [ WARNING ]: no xml document available at %p.\n",doc);
        return;
    }
    if(xml_root==NULL) {
        if(DEBUG>0) printf("[ getXMLValue ]: [ WARNING ]: no xml root element available.\n");
        return;
    }  
    if(DEBUG>1) printf("[ getXMLValue ]: retrieve value from xml document\n");
    retrieveValue(doc,xml_root,tag,value,MAX);
    if(DEBUG>1) printf("[ getXMLValue ]: retrieved value \"%s\" from xml\n",value);
}













xmlNode* retrieveElement(xmlDoc* doc, xmlNode* node, char* tag) {
    xmlNode* cur_node = NULL;
    xmlNode* found_it = NULL;
    //int debug = 1;
    for(cur_node = node; cur_node; cur_node = cur_node->next) {
        if(found_it!=NULL) {
            if(DEBUG>3) printf("[ retrieveElement ]: stop at cur_node %s prev %s  \n",cur_node->name,cur_node->prev->name);
            break;
        }
        if(DEBUG>3) printf("[ retrieveElement ]: Looking for %s and comparing to %s\n",tag,cur_node->name);
        if( (!xmlStrcmp(cur_node->name,(const xmlChar*)tag)) ) {
            if(DEBUG>3) printf("[ retrieveElement ]: found an element of type %d\n",cur_node->type);
            if (cur_node->type == XML_ELEMENT_NODE) {
                if(DEBUG>3) printf("[ retrieveElement ]: found it\n");
                found_it = cur_node;
                break;
            }
        }

        if(found_it!=NULL) {
            if(DEBUG>3) printf("[ retrieveElement ]: found it at name %s \n",cur_node->name);
            return found_it;
        }

        found_it = retrieveElement(doc,cur_node->children,tag);

    }

    return found_it;
}











void pollXmlString(int socketfd) {
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


    if(DEBUG>1) printf("[ pollXmlString ]:  from socket %d \n", socketfd);

    free_xml_string();

    time(&timer);

    if(DEBUG>1) {
      lt = localtime(&timer);
      printf("[ pollXmlString ]: start_time at %s\n",asctime(lt));
    }

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
	  printf("[ pollXmlString ]: Try to read from socket (nempty %d read_i %d time %ds)\n",nempty,read_i,dt);

        read_n = 0;
        ioctl(socketfd, FIONREAD, &read_n);

        if(DEBUG>1) {
            printf("[ pollXmlString ]: %d chars available on socket\n",read_n);
        }

        if(read_n>0) {      

            // allocate memory needed
            if(DEBUG>1) printf("[ pollXmlString ]: Allocate %d array\n",read_n);      

            // check that the buffer used is not weird
            if(buf_loop!=NULL) {
                printf("[ pollXmlString ]: [ ERROR ]: buf_loop is not null!\n");
                exit(1);
            }

            // allocate space to hold the input
            buf_loop = (char*) calloc(read_n+1,sizeof(char));

            if(DEBUG>1) printf("[ pollXmlString ]: Allocated buf_loop array at %p strlen %d with %d length \n",buf_loop,strlen(buf_loop),(int)sizeof(char)*(read_n+1));      

            // Read from socket
            read_n = read(socketfd,buf_loop,read_n);

            if(DEBUG>1) printf("[ pollXmlString ]: Read %d chars from socket\n",read_n);

            if(DEBUG>2) printf("[ pollXmlString ]: buf_loop strlen is %d\n",strlen(buf_loop));

            if (read_n < 0) {
                printf("[ pollXmlString ]: [ ERROR ]: read %d from socket\n",read_n);
                exit(1);
            }

            //fix c-string terminations, cases where there is a termination in the middle..
            int k;
            for(k=0;k<read_n;++k) {
                //printf("[ pollXmlString ]: '%c'\n",buf_loop[k]);
                if(buf_loop[k]=='\0') {
                    if(DEBUG>2) printf("[ pollXmlString ]: fix termination at idx %d in this buf_loop\n",k);
                    buf_loop[k]=' ';
                }
            }

            if(DEBUG>2) printf("[ pollXmlString ]: Fixed buf_loop strlen %d:\n%s\n",strlen(buf_loop),buf_loop);


            // search for xml endings in this buffer
            pch = strchr(buf_loop,'\f'); 
            while(pch!=NULL) { 
                if(DEBUG>1) printf("[ pollXmlString ]: found ending at %p (array index %d) in this buf!\n",pch,pch-buf_loop); 
                n_endings++; 
                pch = strchr(pch+1,'\f'); 
            } 


            // copy to other buffer while looping            
            if(DEBUG>2) printf("[ pollXmlString ]: Copy %d to other buffer (at %p before realloc) \n",read_n,buf);      

            // reallocate more memory
            buf = (char*) realloc(buf,sizeof(char)*(buf_len+read_n));
            if(buf==NULL) {
                printf("[ pollXmlString ]: [ ERROR ]: failed to allocated buf\n");
                if(buf_loop==NULL) {
                    free(buf_loop);
                }
                exit(1);
            }

            if(DEBUG>2) printf("[ pollXmlString ]: Allocated longer buf at %p and copy to pointer %p (offset= %d) \n",buf,buf+buf_len,buf_len);      


            // do the copy
            memcpy(buf+buf_len,buf_loop,sizeof(char)*read_n);

            if(DEBUG>1) printf("[ pollXmlString ]: memcpy done\n");

            //update the buffer length counter
            buf_len += read_n;      

            if(DEBUG>1) printf("[ pollXmlString ]: free buf_loop\n");

            // free loop buffer for next loop
            if(buf_loop!=NULL) {
                free(buf_loop);
                buf_loop=NULL;
            }

            if(DEBUG>2) printf("[ pollXmlString ]: end of read_i %d with buf strlen %d\n",read_i,strlen(buf));

            read_i++;

        } // read_n>0
        else {
            if(DEBUG>1) printf("[ pollXmlString ]: Nothing to read from socket. Sleep a little..\n");      
            usleep(0.05);
            nempty++;
        } 



        if(n_endings>1) {
            if(DEBUG>1) printf("[ pollXmlString ]: \nfound %d endings at read_i %d with at len %d and strlen %d. Stop reading from buffer\n",n_endings,read_i,buf_len,strlen(buf));      
            break;
        }


        counter++;

        // dummy check for time-out?
        //if(counter>50) {
        //    printf("[ pollXmlString ]: Many (%d) iterations to get XML string. Something is strange\n",counter);
        //    break;
        //}

    }



    if(DEBUG>1) 
      printf("[ pollXmlString ]: Done reading from socket. Found %d endings and a buf_len of %d (dt=%d)\n",n_endings, buf_len, dt);
    
    if(DEBUG>2) 
      if(buf!=NULL) printf("[ pollXmlString ]: strlen %d\n", strlen(buf));
    
    

    if(n_endings>=1) {
        if(DEBUG>1) printf("[ pollXmlString ]: \nPick out config and status string between <system> and %d endings in string with strlen %d and buf_len %d\n",n_endings,strlen(buf),buf_len);
        if(DEBUG>1) printf("[ pollXmlString ]: \nbuf: \n%s\n",buf);

        //search for the <status> tag in each <system>->'\f' substring

        char* start = NULL;
        int len = findSystemStr(buf, buf_len,&start);    
        if(len>0) {      
            char* stop = start+len;
            if(DEBUG>1) printf("[ pollXmlString ]: len %d start at %p stop at %p\n",len,start, stop);
            if(DEBUG>1) printf("[ pollXmlString ]: calloc xml string len %d\n",len);
            xml_string = (char*) calloc(len+1,sizeof(char));
            //xml_string = (char*) malloc(sizeof(char)*len);
            if(DEBUG>1) printf("[ pollXmlString ]: copy to xml string at %p\n",xml_string);	
            memcpy(xml_string,start,len);
            // terminate
            xml_string[len] = '\0'; 
            if(DEBUG>1) printf("[ pollXmlString ]: \ncopied %d chars to %p with strlen %d\n%s\n",len+1,xml_string,strlen(xml_string),xml_string);

        }
        else {
            if(DEBUG>1) printf("[ pollXmlString ]: Couldn't find system and/or status string in xml buffer\n");
        }
    } 

    if(xml_string==NULL) {
        if(DEBUG>0) printf("[ pollXmlString ]: No valid xml string extracted from this poll (%d endings)\n",n_endings);
    }

    return;

}




/*
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
   
   
   if(DEBUG>0) printf("[ pollDpmXmlString ]:  from socket %d \n", socketfd);
      
   time(&timer);
   
   if(DEBUG>0) {
     lt = localtime(&timer);
     printf("[ pollDpmXmlString ]: start_time at %s\n",asctime(lt));
   }
   
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
	printf("[ pollDpmXmlString ]: Try to read from socket (nempty %d read_i %d time %ds)\n",nempty,read_i,dt);
      
      read_n = 0;
      ioctl(socketfd, FIONREAD, &read_n);
      
      if(DEBUG>0) {
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
         
         if(DEBUG>0) printf("[ pollDpmXmlString ]: Read %d chars from socket\n",read_n);
         
         if(DEBUG>2) printf("[ pollDpmXmlString ]: buf_loop strlen is %d\n",strlen(buf_loop));
         
         if (read_n < 0) {
            printf("[ pollDpmXmlString ]: [ ERROR ]: read %d from socket\n",read_n);
            exit(1);
         }
         
         //fix c-string terminations, cases where there is a termination in the middle..
         int k;
         for(k=0;k<read_n;++k) {
            //printf("[ pollDpmXmlString ]: '%c'\n",buf_loop[k]);
            if(buf_loop[k]=='\0') {
               if(DEBUG>2) printf("[ pollDpmXmlString ]: fix termination at idx %d in this buf_loop\n",k);
               buf_loop[k]=' ';
            }
         }
         
         if(DEBUG>2) printf("[ pollDpmXmlString ]: Fixed buf_loop strlen %d:\n%s\n",strlen(buf_loop),buf_loop);
         
         
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
         if(DEBUG>0) printf("[ pollDpmXmlString ]: Nothing to read from socket. Sleep a little..\n");      
         usleep(0.05);
         nempty++;
      } 
      
      
      
      if(n_endings>1) {
         if(DEBUG>0) printf("[ pollDpmXmlString ]: \nfound %d endings at read_i %d with at len %d and strlen %d. Stop reading from buffer\n",n_endings,read_i,buf_len,strlen(buf));      
         break;
      }
      
      
      counter++;
      
      
   } //time out
   
   
   
   //if(DEBUG>0) {
   printf("[ pollDpmXmlString ]: Done reading from socket. Found %d endings and a buf_len of %d (dt=%d)\n",n_endings, buf_len, dt);
   if(DEBUG>0)
     if(buf!=NULL) printf("[ pollDpmXmlString ]: strlen %d\n", strlen(buf));
   
   
   
   if(n_endings>=1) {
      if(DEBUG>0) printf("[ pollDpmXmlString ]: \nPick out config and status string between <system> and %d endings in string with strlen %d and buf_len %d\n",n_endings,strlen(buf),buf_len);
      if(DEBUG>1) printf("[ pollDpmXmlString ]: \nbuf: \n%s\n",buf);
      
      //search for the <status> tag in each <system>->'\f' substring
      
      char* start = NULL;
      char* tmp_str = NULL;
      int len = findSystemStr(buf, buf_len,&start);    
      if(len>0) {      
         char* stop = start+len;
         if(DEBUG>1) printf("[ pollDpmXmlString ]: len %d start at %p stop at %p\n",len,start, stop);
         if(DEBUG>1) printf("[ pollDpmXmlString ]: calloc xml string len %d\n",len+1);
         tmp_str = (char*) calloc(len+1,sizeof(char));
         if(DEBUG>1) printf("[ pollDpmXmlString ]: copy to xml string at %p\n",tmp_str);	
         memcpy(tmp_str,start,len);
         // terminate
         tmp_str[len] = '\0'; 
         if(DEBUG>1) printf("[ pollDpmXmlString ]: \ncopied %d chars to %p with strlen %d\n%s\n",len+1,tmp_str,strlen(tmp_str),tmp_str);
         // fix output pars
         *xml_string_out = tmp_str;
         *len_out = len+1;
         if(DEBUG>1) printf("[ pollDpmXmlString ]: output pars are at %p and len %d\n",*xml_string_out,*len_out);
         
         
      } else {
         if(DEBUG>0) printf("[ pollDpmXmlString ]: Couldn't find system and/or status string in xml buffer\n");
      }
   }
   
   if(xml_string_out==NULL) {
      if(DEBUG>0) printf("[ pollDpmXmlString ]: No valid xml string extracted from this poll (%d endings)\n",n_endings);
   }
   
   return;
   
}

*/





void retrieveValue(xmlDoc* doc, xmlNode* node, char* tags, char value[], const unsigned int MAX) {
    xmlChar* value_str = NULL;
    char* pch;
    char* pch_prev=NULL;
    xmlNode* cur_node = NULL;
    xmlNode* prev_node = node;
    //use a copy since it modifies the original string
    //char* tags = (char*)malloc(strlen(tags)*sizeof(char));
    //strcpy(tags,tags);
    if(DEBUG>0) printf("[ retrieveValue ]: for tag \"%s\"\n",tags);
    if(strlen(tags)>0) {
        pch = strtok(tags," :,.-");
        while(pch!=NULL) {
            if(DEBUG>2) printf("[ retrieveValue ]: Find element %s \n",pch);
            if(pch_prev!=NULL) {
                if(DEBUG>2) printf("[ retrieveValue ]: Find element %s from children of prev element at %p\n",pch,prev_node->name);
                cur_node = retrieveElement(doc,prev_node->children,pch);
            }
            else {
                if(DEBUG>2) printf("[ retrieveValue ]: Find element %s from element %s\n",pch,prev_node->name);
                cur_node = retrieveElement(doc,prev_node,pch);
            }

            // check that we found it
            if(cur_node != NULL) {
                if(DEBUG>2) printf("[ retrieveValue ]: found cur_node name %s\n",cur_node->name);
            } else {
                if(DEBUG>2) printf("[ retrieveValue ]: couldn't find cur_node\n");
                break;
            }

            pch_prev = pch;
            prev_node = cur_node;
            pch = strtok(NULL," :,.");
        }

        //if there is a node at the end it means we should get it's list of strings
        // if it's not the lowest level it might returns some garbage -> FIX THIS!
        if(cur_node !=NULL) {
            value_str  = xmlNodeListGetString(doc,cur_node->children,0);
            if(value_str!=NULL) {
                if(DEBUG>2) printf("[ retrieveValue ]: Found value %s\n",value_str);
                if(strlen((char*) value_str)>=MAX) {
                    if(DEBUG>2) printf("[ retrieveValue ]: the value for tags=%s is %d i.e. larger than MAX=%d, return no value!\n",tags,strlen((char*)value_str),MAX);
                    value_str = NULL;
                } else {
                    if(DEBUG>2) printf("[ retrieveValue ]: copy the value_str=\"%s\" (%d) to %p\n",value_str,strlen((char*)value_str),value);
                    strcpy((char*)value,(char*)value_str);
                }
            } else {
                value_str = NULL;
                if(DEBUG>2) printf("[ retrieveValue ]: Found no value for tags %s\n",tags);
            }
        } else {
            value_str = NULL;
            if(DEBUG>2) printf("[ retrieveValue ]: cur_node is null so no value found for tags=%s\n",tags);
        }
    }
    if(value_str!=NULL) {
        if(DEBUG>1) printf("[ retrieveValue ]: free value_str\n");
        xmlFree(value_str);
    }
}


void getXmlDocStrFormat(char** xml_str, int * xml_str_len) {
    if(doc!=NULL) {
      xmlDocDumpFormatMemoryEnc	(doc,(xmlChar**)xml_str,xml_str_len, "UTF-8",1);    
    }
}

void getFebDeviceDna(int feb_id, char* dna) {
  if(getXmlDocStatus()==0) {
    getFebDnaValue(doc, feb_id,(xmlChar*) dna);
  } else {
    if(DEBUG>0)
      printf("[ getFebDeviceDna ]: [ WARNING ]: the dpm xml doc status is invalid\n");
    strcpy(dna, "no valid xml");
  }
}






double getFebT(int feb_id, char* ch_name) {
   double t = 0.0;
   if(getXmlDocStatus()==0) {
      if(strcmp(ch_name,"axixadc")==0) {
         t = getFebTempValue(doc,"FebFpgaTemp", feb_id);
      }
      else if(strcmp(ch_name,"FebTemp0")==0 || strcmp(ch_name,"FebTemp1")==0) {
         t = getFebTempValue(doc,ch_name, feb_id);
      } else {
         printf("[ getFebT ] : [ ERROR ]: wrong ch_name \"%s\"\n",ch_name);
      }
   }
   return t;
}

double getHybridT(int index, int hyb, const char* type) {
   double val = 0.0;
   if(getXmlDocStatus()==0) {
      if(strcmp(type,"temp0")==0) 
         val = getHybTValue(doc, "ZTemp0", index, hyb);
      else if(strcmp(type,"temp1")==0) 
         val = getHybTValue(doc, "ZTemp1", index, hyb);
      else {
         printf("[ getHybridT ]: [ ERROR ]: the typee %s is invalid\n",type);
      }     
   } else {
      if(DEBUG>1) printf("[ getHybridT ]: [ WARNING ]: the xml doc status is invalid\n");
   }
   return val; 
}

double getHybridI(int index, int hyb, const char* type) {
   double val = 0.0;
   char tmp[256];
   if(getXmlDocStatus()==0) {      
      strcpy(tmp,type);
      val = getHybIValue(doc, strToUpper(tmp), index, hyb);
   } else {
      if(DEBUG>1) printf("[ getHybridI ]: [ WARNING ]: the xml doc status is invalid\n");
   }
   return val; 
}


double getHybridV(int feb_id, int hyb_id,char ch_name[], char ch_pos[]) { 
   double val = 0.0;
   char tmp[256];
   if(getXmlDocStatus()==0) {      
      strcpy(tmp,ch_name);
      val = getHybVValue(doc, strToUpper(tmp), feb_id, hyb_id, ch_pos);
   } else {
      if(DEBUG>1) printf("[ getHybridV ]: [ WARNING ]: the xml doc status is invalid\n");
   }
   return val; 
}

double getHybridSwitch(int index, int hyb) {
   double val = 0.0;
   if(getXmlDocStatus()==0) {      
      val = getHybSwitchValue(doc, index, hyb);
   } else {
      if(DEBUG>1) printf("[ getHybridSwitch ]: [ WARNING ]: the xml doc status is invalid\n");
   }
   return val; 
}

void getHybridSync(int index, int datapath, char* action, char* syncStr) {
  if(DEBUG>1)
    printf("[ getHybridSync ]: get sync for feb %d datapath %d \n", index, datapath);  
  if(getXmlDocStatus()==0) {      
    if(DEBUG>1)
      printf("[ getHybridSync ]: xml ok\n");
    getHybSync(doc, index, datapath, action, syncStr);
    if(DEBUG>1)
      printf("[ getHybridSync ]: got val %s\n", syncStr);
  } else {
    if(DEBUG>1) printf("[ getHybridSync ]: [ WARNING ]: the dpm xml doc status is invalid\n");    
    strcpy(syncStr, "no xml");
  }
}


void getSync(char* pname, char* value) {
  if(getXmlDocStatus()==0) {      
    if(DEBUG>1)
      printf("[ getSync ]: xml ok\n");
    getSyncProcess(pname, doc, value);
    if(DEBUG>1)
      printf("[ getSync ]: got val %s\n", value);
  } else {
    if(DEBUG>1) printf("[ getSync ]: [ WARNING ]: the xml doc status is invalid\n");    
    strcpy(value, "no xml");
  }
}


int getDpmFromFebValue(int index, int hybrid) {
  int dpm;
  int dpm_found;
  int val_feb;
  dpm_found = -1;

  //if(DEBUG>0) 
  printf("[ getDpmFromFebValue ]: find dpm for feb %d and hybrid %d\n", index, hybrid);
  
  for(dpm=0; dpm<N_DPM; ++dpm) {
    //if(DEBUG>0) 
    printf("[ getDpmFromFebValue ]: check dpm %d\n", dpm);
    if(getDpmXmlDocStatus(dpm)==0) {
      //if(DEBUG>0) 
      printf("[ getDpmFromFebValue ]: dpm xml ok\n");
      xmlDoc* d = dpm_xml_doc[dpm];
      printf("[ getDpmFromFebValue ]: dpm xml at %p\n", d);
      val_feb = getFebFromDpmValue(d, hybrid);
      //if(DEBUG>0) 
      printf("[ getDpmFromFebValue ]: got feb %d from hybrid %d and dpm %d\n", val_feb, hybrid, dpm);
      if(val_feb<0) {
	//if(DEBUG>0) 
	printf("[ getDpmFromFebValue ]: [ WARNING]: invalid feb from hybrid %d and dpm %d\n", hybrid, dpm);
	continue;
      }
      
      if( val_feb == index ) {
	//if(DEBUG>0) 
	printf("[ getDpmFromFebValue ]: found feb %d from hybrid %d on dpm %d!\n", val_feb, hybrid, dpm);
	dpm_found = dpm;
      }
      
    }
    
    
    if( dpm_found >-1) {
      //if(DEBUG>0) 
      printf("[ getDpmFromFebValue ]: found dpm (%d), exit.. \n", dpm_found);
      break;      
    } else {
      //if(DEBUG>0) 
      printf("[ getDpmFromFebValue ]: done checking dpm %d. \n", dpm);
    }
    
    
  }
  
  //if(DEBUG>0) 
  printf("[ getDpmFromFebValue ]: return with dpm %d. \n", dpm_found);
  
  return dpm_found;
}


int getDpm(int index, int hyb) {
  int dpm;
  //if(DEBUG>0) 
  printf("[ getDpm ]: find dpm from feb %d and hybrid %d \n", index, hyb);
  dpm = getDpmFromFebValue(index, hyb);
  //if(DEBUG>0) 
  printf("[ getDpm ]: found dpm %d \n", dpm);
  return dpm;
}

double getDatapath(int index, int hyb, int dpm) {
   return -2.0; 
}


double getHybridTrim(int index, int hyb, char* type) {
   double val = 0.0;
   char s[10];
   if(getXmlDocStatus()==0) {      
      strToUpper(type);
      //monkey around with case
      if(strcmp(type,"AVDD")==0) strcpy(s,"Avdd");
      else if(strcmp(type,"DVDD")==0) strcpy(s,"Dvdd");
      else if(strcmp(type,"V125")==0) strcpy(s,"V1_25");
      else {
         printf("[ getHybridTrim ] : [ ERROR ] : this type is not supported \"%s\"\n",type);
      }   
      val = getHybTrimValue(doc, s, index, hyb);
   } else {
      if(DEBUG>1) printf("[ getHybridTrim ]: [ WARNING ]: the xml doc status is invalid\n");
   }
   return val; 
}






void writeHybridVSwitch(int sockid, int value, int feb_id, int hyb_id) {  
    char buffer[256];
    char hyb_tag[256];
    char toggle[256];
    int n;
    memset(buffer,0,256);  
    memset(hyb_tag,0,256);  
    memset(toggle,0,256);  
    if(value==1) sprintf(toggle,"%s","True");
    else sprintf(toggle,"%s","False");
    
    getHybSwitchCmd(toggle, feb_id, hyb_id, buffer, 256);

    printf("[ writeHybridVSwitch ] : cmd \"%s\"\n",buffer);
    
    n = write(sockid,buffer,strlen(buffer));
    
    if(n<0) 
       socket_error("[ writeHybridVSwitch ] : [ ERROR ] : couldn't write to socket");
    
    return;  
}




void writeHybridVTrim(int sockid, int value, int feb_id, int hyb_id, char *ch_name) {  
    char buffer[256];
    char hyb_tag[256];
    char ch_name_corr[256];
    int n;
    memset(buffer,0,256);  
    memset(hyb_tag,0,256);  
    memset(ch_name_corr,0,256);  
    // correct name
    if(strcmp(ch_name,"dvdd")==0) strcpy(ch_name_corr,"Dvdd");
    if(strcmp(ch_name,"avdd")==0) strcpy(ch_name_corr,"Avdd");
    if(strcmp(ch_name,"v125")==0) strcpy(ch_name_corr,"V1_25");
    
    getHybTrimCmd(value, feb_id, hyb_id, ch_name_corr, buffer, 256);
    
    if(DEBUG > 0) 
       printf("[ writeHybridVTrim ] : cmd to write \"%s\"\n",buffer);
    
    n = write(sockid,buffer,strlen(buffer));
    
    if(n<0) 
       socket_error("[ writeHybridVTrim ] : [ ERROR ] : couldn't write to socket");
    
    return;  
}
