#include <string.h>
#include <stdio.h>
#include "daqmap.h"

int getFebInfoFromDaqMap(int hyb_id, char* half, int (*map)[N_HYBRIDS]) {  
   int feb_id;   
   int h;

   h = -1;
   if(strcmp(half,"top")==0) h = 0;
   else if(strcmp(half,"bot")==0) h = 1;
   else {
      printf("[ getFebIdFromDaqMap ] : [ ERROR ] half \"%s\" is invalid\n !!!!!!!!!!!\n",half);
      return -1;
   }
   
   feb_id =  map[h][hyb_id];   

   if(DEBUG>3) 
      printf("[ getFebIdFromDaqMap ] : found feb %d from %s hyb %d\n",feb_id, half, hyb_id);   

   return feb_id;
}
