/***********************************************************************
  
  FUNCTION make_pvname
  
  function that creates the final process variable names
  and passes the pv name to the structure hvchan
  
  ************************************************************************/

#include "hv_adl.h"

void make_pvname()
     
{
  
  int j = 0;
  
  while (chan_info[j].label_hv[0] != '\0') { 
    
    strcpy(chan_info[j].pvname, "B_hv_");
    strcat(chan_info[j].pvname, chan_info[j].label_hv);
    
    j++;
    
  }
  
}




