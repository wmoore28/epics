/*********************************************************************
  
  FUNCTION get_crate_nos  
  
  Store the crate#'s in ascending order as well as 
  other related information
  
  ***********************************************************************/

#include "hv_adl.h"

void get_crate_nos()
     
{
  
  int i, j;
  int counter = 0;
  int ones, tens, number;
  char temp[3];
  
  
  /*** Empty out the contents of the crate structure ***/
  
  for (i = 0; i < 20; i++)  {
    
    crate_info[i].crate_no = 0;
    
  }
  
  
  for (j = 0; chan_info[j].label_hv[0] != '\0'; j++)  {
    
    number = chan_info[j].mf_hv;
    
    if (crate_info[number].crate_no == 0) {
      
      crate_info[number].arcnet_no = chan_info[j].arcnet_hv;
      crate_info[number].crate_no = chan_info[j].mf_hv;
      
    }
    
    
    
  }  /* end of j loop */
  
  
  
  /******* Print out the existing crate#'s
    
    for (i = 0; i < 20; i++)  {
    
    if (crate_info[i].crate_no[0] != '\0') {
    
    printf("There is a crate# %s\n", crate_info[i].crate_no);
    
    }
    
    }    **************************************************/
  
  
  
  
  
  
}     




