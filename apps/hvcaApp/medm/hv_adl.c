/*****************************************************************************
 *                                                                           *
 *                "hv_adl.c"                                                 *
 *                                                                           *
 *                THIS PROGRAM GENERATES GUI'S (MEDM) FOR THE                *
 *                HALL B HIGH VOLTAGE CONTROLS                               *
 *                                                                           *
 *		                Sasha Philips                                *
 *				The George Washington University             *
 *				Fall '96                                     *
 *****************************************************************************/


#include "hv_adl.h"

/******************************************************************************
  
  MAIN PROGRAM
  
  ****************************************************************************/


main(void)
     
{
  
  FILE *fp; 
  int i, j, k;
  int screens;          /* total # of screens required per group */
  int screen_no;        /* particular screen # passed to the make_gui function */
  int group_no;         /* used to control main loop to create gui's */
  
/* redundant declarations, but here as a reminder */
  /*  extern char hvdatafile[30];       
  extern char groupnamefile[30];
  extern char alarmsfile[30];
  extern char enable_snapfile[30];  
  extern char disable_snapfile[30]; 
  extern char filename[30]; */
  
  char parent[30];    /* variable used in the making of the alarms config file */
  
  /**************************************
    Read hv channel info. from data file 
    ***************************************/
  


  /* For the reader to input the data file that has all the channel information. */
  
  
  printf("Input name of hv data file (omit the extension '.dat') :  ");
  scanf("%s", filename);
  strcpy(hvdatafile, filename);
  strcat(hvdatafile, ".dat");
  printf("\n");
  
  
  if ( (fp=fopen(hvdatafile, "r")) == NULL ) { 
    
    printf("cannot open data file\n"); 
    exit(1);
  }
  
  
  i = 0;
  
  while ( feof(fp) == 0) {
    
    fscanf(fp, "%s%d%d%d%d%d%d%d%f%f%f%f%f%f%f", chan_info[i].label_hv,
	   &chan_info[i].group_hv, &chan_info[i].enable_hv,
	   &chan_info[i].arcnet_hv,
	   &chan_info[i].mf_hv, &chan_info[i].card_hv,
	   &chan_info[i].module_hv, &chan_info[i].chan_hv,
	   &chan_info[i].set_v, &chan_info[i].mvdz,
	   &chan_info[i].mcdz, &chan_info[i].ramp_up,
	   &chan_info[i].ramp_down, &chan_info[i].trip_current,
	   &chan_info[i].hv_limit);
    i++; 
  }
  
  fclose(fp);
  
  
  /********************************
    Read group_names from data file 
    *********************************/
  
  
  strcpy(groupnamefile, filename);
  strcat(groupnamefile, ".grp");
  
  if ( (fp=fopen(groupnamefile, "r")) == NULL ) { 
    
    printf("cannot open groupname file\n"); 
    exit(1); 
  }
  
  i = 0;
  
  while ( feof(fp) == 0) {
    
    fscanf(fp, "%d%s", &group_info[i].group_hv,
	   group_info[i].groupname_hv); 
    i++; 
  }
  
  fclose(fp);
  
  /**********************
    Write alarms file
    **********************/
  
  strcpy(alarmsfile, filename);
  strcat(alarmsfile, ".alarms");
  
  fp = fopen(alarmsfile, "w");
  
  
  for (i = 0; chan_info[i].label_hv[0] != '\0'; i++) {
    
    if (chan_info[i].set_v > 0.0) {

      fprintf(fp, "%s %f %f %f %f %s %s %s %s\n", chan_info[i].label_hv, 
	      chan_info[i].set_v + 100.00, 
	      chan_info[i].set_v - 100.00,
	      chan_info[i].set_v + 50.00,
	      chan_info[i].set_v - 50.00,
	      "MAJOR", "MAJOR", "MINOR", "MINOR");

    } else {

      fprintf(fp, "%s %f %f %f %f %s %s %s %s\n", chan_info[i].label_hv, 
	      chan_info[i].set_v - 100.00, 
	      chan_info[i].set_v + 100.00,
	      chan_info[i].set_v - 50.00,
	      chan_info[i].set_v + 50.00,
	      "MAJOR", "MAJOR", "MINOR", "MINOR");

    }
    
  }
  
  fclose(fp);
  
  /*******************
    Read alarms file
    ********************/
  
  
  strcpy(alarmsfile, filename);
  strcat(alarmsfile, ".alarms");
  
  if ( (fp=fopen(alarmsfile, "r")) == NULL ) { 
    
    printf("cannot open alarms initialization file\n"); 
    exit(1); 
  }
  
  i = 0;
  
  while ( feof(fp) == 0) {
    
    fscanf(fp, "%s%f%f%f%f%s%s%s%s", alarms_info[i].label_hv,
	   &alarms_info[i].hhmv, &alarms_info[i].llmv, 
	   &alarms_info[i].himv, &alarms_info[i].lomv,
	   alarms_info[i].hhsv, alarms_info[i].llsv, 
	   alarms_info[i].hsmv, alarms_info[i].lsmv);
    i++; 
  }
  
  fclose(fp);
  
  
  
  
  
  
  /******** to see the alarm values *******
    j = 0;
    
    do {
    
    printf("%s %.2f %.2f %.2f %.2f %s %s %s %s\n", 
    alarms_info[j].label_hv, 
    alarms_info[j].hhmv,
    alarms_info[j].llmv,
    alarms_info[j].himv,
    alarms_info[j].lomv,  
    alarms_info[j].hhsv, 
    alarms_info[j].llsv,
    alarms_info[j].hsmv, 
    alarms_info[j].lsmv);  
    j++;
    
    } while (alarms_info[j].label_hv[0] != '\0');
    ***************************************************/
  
  
  /************************** FUNCTION CALLS **************************/
  
  get_groupname(); 	/* Call function 'get_groupname'*/
  
  
  printf("\n");
  
  
  /* display(); */			/* Call function 'display' 	*/
  
  
  printf("\n");
  
  /********************************
    Make the process variable names 
    *********************************/
  
  
  
  make_pvname(); 		/* Call function 'make_pvname'.  
					   Here, the structure is being 
					   passed as a pointer, so the 
					   function will modify the values */
  
  get_crate_nos();      
  
  
  
  
  /**********************************
    
    BEGIN MAKING GUI's GROUP BY GROUP
    
    ***********************************/
  
  
  
  
  i = 0; 
  
  for (group_no = 1; group_info[group_no - 1].groupname_hv[0] != '\0'; group_no++)  {
    

    printf("WORKING ON GROUP #");
    printf("%d\n", group_no);

    
    
    /**********************************************
      Copy all the channel info into the temporary 
      structure group by group 
      ***********************************************/
    
    
    
    for (k = 0; chan_info[k].label_hv[0] != '\0'; k++)   {
      
      if (chan_info[k].group_hv == group_no)  {
	
	temp_info[i] = chan_info[k];

	i++;	/* increase the index in temp_info */
	
      }
      
    }  
    
    
    
    
    /**************************************
      Alarm files for alarmhandler created
      for each group
      ***************************************/
    
    strcpy(alarmsfile, filename);
    strcat(alarmsfile, "_");  
    strcat(alarmsfile, group_info[group_no - 1].groupname_hv );
    strcat(alarmsfile, ".alhConfig");
    
    fp = fopen(alarmsfile, "w");
    

/* SEVRCOMMAND for each HV group...E.Wolin, 30-jul-98 */
    fprintf(fp, "%s%s\n%s%s%s%d%s%s%s\n%s%s%s%d%s%s%s\n%s\n%s\n%s\n",
	    "GROUP   HV    HV_", 
	    group_info[group_no - 1].groupname_hv,
	    "$SEVRCOMMAND UP_MAJOR remsh clon00 \"epics_alarm HV_", 
	    filename,
	    " 2 ERROR ",
	    group_no,
	    " \\\"ALH reporting ALARM for group HV_",
	    group_info[group_no-1].groupname_hv,
	    "\\\"\"",
	    "$SEVRCOMMAND DOWN_NO_ALARM remsh clon00 \"epics_alarm HV_",
	    filename,
 	    " 0 INFO ",
	    group_no,
	    " \\\"ALH reporting alarms cleared for group HV_",
	    group_info[group_no-1].groupname_hv,
	    "\\\"\"",
	    "$GUIDANCE",	
	    "Click on group name (on left) to change channel listings on right half.  Track down RED/tripped channels and enable them",
	    "$END");

/***
  fprintf(fp, "%s%s\n%s\n%s\n%s\n",
	    "GROUP   HV    HV_", group_info[group_no - 1].groupname_hv,
	    "$GUIDANCE",	
	    "Find the tripped channel (look for red status), use the \"P\" button to bring up controls for that channel and enable it",
	    "$END");
***/

    
    for (i = 0; temp_info[i].label_hv[0] != '\0'; i++) {
      
      strcpy(parent, group_info[group_no - 1].groupname_hv);
      
      strcpy(channel, temp_info[i].pvname);
      strcat(channel, "_property"); 
      fprintf(fp, "%s    %s%s        %s\n", "CHANNEL", 
	      "HV_", parent, 
	      channel);
      fprintf(fp,"$GUIDANCE\nUse the \"P\" button to bring up control window for the tripped channel\n$END\n");
      fprintf(fp,"$COMMAND medm -x -attach -macro \"channel_name=%s,group_number=%i\" hv_generic.adl >> /dev/null \n",
	      temp_info[i].label_hv,group_no);
    }
    
    
    fclose(fp);
    
    /*****************/
    
    
    
    
    
    
     /* Make snap files for this group */
       make_snap(group_no);    

    
    
    
    
    
    
    /*******************************************************************
      Figure out how many screens are required per group in order to 
      generate the correct number of screens
      *********************************************************************/
    
    
    
    
    screens = ( (group_info[group_no - 1].chan_per_group - 1) / 24 ) + 1;
    
    
    
    
    for (screen_no = 1; screen_no <= screens; screen_no++) {
      
      /****  CALL FUNCTION 'make_gui'  ****/
      
      make_gui(screen_no, screens, group_no); 
    }
    
    
    
    i = 0;  /* reset the index for temp_info */
    
    
    /*** Empty out the contents of temp_info ***/
    
    for (k = 0; temp_info[k].label_hv[0] != '\0'; k++)  
      {
	strcpy(temp_info[k].label_hv, "" );
	
      }
    
    
    
    
    
    
  } /* end of loop that makes gui's for !all! the groups */
  
  
  
  menu_gui(); 
  
  
  
  
  
  
  
  return 0;
  
}  

/**************************************************************************
  
  End of Main Program   
  
  ***************************************************************************/


