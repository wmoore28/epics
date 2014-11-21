/*********************************************************************
  
  FUNCTION get_groupname
  
  associates group numbers with the given 
  groupnames & counts the # of channels in a given group
  
  ***********************************************************************/

#include "hv_adl.h"

void get_groupname()
     
{
  
  int i = 0;
  int j = 0;
  
  /* Initialize the chan_per_group field */
  
  for (j = 0; group_info[j].groupname_hv[0] != '\0'; j++) {
    
    group_info[j].chan_per_group = 0;
  }
  
  
  do {
    
    for (j = 0; group_info[j].groupname_hv[0] != '\0'; j++) {
      
      if (chan_info[i].group_hv == group_info[j].group_hv) {
	
	strcpy(chan_info[i].groupname_hv, group_info[j].groupname_hv);
	group_info[j].chan_per_group++;
      }
      
    }
    
    i++;
    
  } while (chan_info[i].label_hv[0] != '\0');
  
  
  /* print the chans per group for curiosity's sake */  
  
  /*   
     for (j = 0; group_info[j].groupname_hv[0] != '\0'; j++) {
     
     printf("%d %d\n", group_info[j].group_hv, group_info[j].chan_per_group);
     }  
     */
  
}

