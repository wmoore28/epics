

/********************************************************************
  
  FUNCTION display
  
  prints out the values read from the database 
  
  **********************************************************************/

#include "hv_adl.h"

void display()
     
{
  
  int j = 0;
  
  do {
    
    printf("%s %d %s %d %s %s %s %s %.2f %.2f %.2f %.2f %.2f %.2f %.2f\n", 
	   chan_info[j].label_hv, 
	   chan_info[j].group_hv,
	   chan_info[j].groupname_hv,
	   chan_info[j].enable_hv,
	   chan_info[j].mf_hv, chan_info[j].card_hv, 
	   chan_info[j].module_hv, chan_info[j].chan_hv,
	   chan_info[j].set_v,
	   chan_info[j].mvdz, chan_info[j].mcdz,
	   chan_info[j].ramp_up, chan_info[j].ramp_down,
	   chan_info[j].trip_current,
	   chan_info[j].hv_limit);  
    j++;
    
  } while (chan_info[j].label_hv[0] != '\0');
  
}


