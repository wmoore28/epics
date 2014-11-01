

/*************
  INCLUDE FILES
  **************/


#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "adl_gen.h"


/************
  STRUCTURES
  *************/


struct hvchan {				
  char label_hv[30];		/* channel name 	*/
  int group_hv;			/* group # 		*/
  char groupname_hv[30];		/* group name		*/
  int enable_hv;			/* software enable	*/
  int arcnet_hv;		/* arcnet #		*/
  int mf_hv;			/* mf #			*/
  int card_hv;			/* card # (0-15)	*/
  int module_hv;		/* module #		*/
  int chan_hv;			/* chan # (0-11 on card)*/
  float set_v;			/* set voltage		*/
  float mvdz;			/* meas. dead zone vol.	*/
  float mcdz;			/* meas. dead zone cur.	*/
  float ramp_up;			/* vol. ramp up speed	*/
  float ramp_down;			/* vol. ramp down speed	*/
  float trip_current;		/* set trip current	*/
  float hv_limit;                  /* set hv limit         */
  char pvname[30];			/* process variable name*/
};
struct hvchan chan_info[2000];                   /* Contains all the relevant parameters 
						    for each hv channel; the associated
						    variable name is 'chan_info' */

struct hvchan temp_info[2000];                   /* makes a temporary copy of all the 
						    information for a particular !group! 
						    of channels, because the gui is made 
						    group by group; the associated variable 
						    name is 'tempp_info' */




struct group {
  int group_hv;              	/* group number 	*/
  char groupname_hv[30];		/* group name 		*/
  int chan_per_group;	      	/* total # of channels	*/
};	      
struct group group_info[25];                    /* contains the group#'s that go with the 
						   group names, and the total # of channels
						   per group            */


struct hvcrates {				
  int arcnet_no;		/* hv arcnet #		*/
  int crate_no;		/* hv crate #		*/
};
struct hvcrates crate_info[20];                /* Contains information relating to
						  each of the hv crates */


struct alarms {
  char label_hv[30];		/* channel name 	*/
  float hhmv;                      /* high high limit */
  float llmv;                      /* low low limit */
  float himv;                      /* high limit */ 
  float lomv;                      /* low limit */
  char hhsv[6];                    /* high high severity */
  char llsv[6];                    /* low low severity */
  char hsmv[6];                    /* high severity */
  char lsmv[6];                    /* low severity */
};
struct alarms alarms_info[2000];




/**********
  FUNCTIONS
  ***********/

void display();      /* Displays the information read 
						     from the data file */



void make_pvname();  /* Creates the process variable name 
						     from the mf, card, module and chan 
						     numbers */



void get_groupname();  /* Assigns groupnames to group #'s as 
						     read from the data file groupnames.dat
						     and counts the # of channels associated 
						     with that group */

void get_crate_nos();      /*  Stores the crate#'s and 
							     related information */


void make_snap(int group_no);    /* Makes the snap files that allow the
						       group en/disables, save, restore & 
						       initialize alarms */


void make_gui(int screen_no, int screens,
	      int group_no);                     /* Creates a screen of 24 channels for a 
						    given group # */


void menu_gui();   /* Creates the top level gui */


/*****************
  GLOBAL VARIABLES
  *****************/

char hvdatafile[30];                            /* file with all the hv channel
						   information                    */

char groupnamefile[30];                         /* file with all the group name
						   information                    */

char alarmsfile[30];                            /* file with alarm initialization
						   values                        */

char enable_snapfile[30];                       /* snapfile for enabling all the 
						   channels of a particular group */

char disable_snapfile[30];                      /* snapfile for disabling all the 
						   channels of a particular group */

char filename[30];                              /* This is the file that is read 
						   from the user!!! All other 
						   related filenames are variations
						   of this name                   */

