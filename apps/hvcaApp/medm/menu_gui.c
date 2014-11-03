/*****************************************************************************
  
  FUNCTION menu_gui
  
  ****************************************************************************/

#include "hv_adl.h"

void menu_gui()
     
{
  
  
  int dx, dy;  
  int x, y; 
  int i, j, k, l, m; 
  int screens, screens_button, nbutton, scr, nchans, chans_gr;
  int counter;            /* to count the # of hv crates */
  
  int crate_no;
  int arcnet_no;
  
  char screens_txt[5];	/* to convert integers to text  */
  char snapfile[150];	/* snapfile used for group enable/disable */
  char restfile[150];	/* snapfile used for restoring voltage current values */
  char restdvfile[150];	/* snapfile used for restoring voltage values only */
  char reqfile[300];	/* request file used for saving voltage current values */
  char linkfile[30];
  
  extern char filename[30]; 	   /* redundant declarations, but here as a reminder */
  
  
  
  
  
  strcpy(adl_file, filename);
  strcat(adl_file, ".adl");
  
  adl_object("OPEN", 10, 10, 1000, 800, 14); 
  
  /************
    Main Header
    *************/
  
  x = 110;
  y = 15;
  dx = 700;
  dy = 45;
  
  strcpy(channel, "");
  strcpy(text_str, "HALL B HV Controls - Main Menu");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /********************
   * Utilities Button *
   ********************/

  x = x + dx;
  dx = 25;
  dy = 25;
      
  sprintf(item_name[0],
	  "xterm -sb -sl 2000 -e $APP/hvcaApp/medm/chdv_set.tcl %s &", filename);
  sprintf(item_label[0], "Group Voltage Set");  
  sprintf(item_args[0], "");            

  sprintf(item_name[1],
	  "xterm -sb -sl 2000 -e $APP/hvcaApp/medm/chdv_incr.tcl %s &", filename);
  sprintf(item_label[1], "Group Voltage Increment/Decrement");  
  sprintf(item_args[1], "");            

  sprintf(item_name[2],
	  "xterm -sb -sl 2000 -e $APP/hvcaApp/scripts/restore_hv.pl %s &", filename);
  sprintf(item_label[2], "Restore HV values");  
  sprintf(item_args[2], "");            

  sprintf(item_name[3],
	  "xterm -sb -sl 2000 -e $APP/hvcaApp/scripts/save_hv_4_det.pl %s &", filename);
  sprintf(item_label[3], "Backup HV values");  
  sprintf(item_args[3], "");            


  adl_object("SHELL_COMMAND", x, y, dx, dy, 20);
  
  x = x + dx;
  dx = 100;

  strcpy(channel, "");
  strcpy(text_str, "Utilities");
  strcpy(alignment, "HC");
      
  adl_object("TEXT", x, y, dx, dy, 54);
    
  /************************
    Group Number Header
    *************************/
  
  x = 20;
  y = 200; 
  dx = 50;	
  dy = 23;	
  
  strcpy(channel, "");
  strcpy(text_str, "Group#");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Group Name Header
    *************************/
  
  x = 120;
  dx = 50;	
  
  strcpy(channel, "");
  strcpy(text_str, "Group Name");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /*****************************
    Channels per group Header
    ******************************/
  
  x = 220;
  dx = 50;	
  
  strcpy(channel, "");
  strcpy(text_str, "Chans.");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /*******************************
    Channel enable/disable Header
    ********************************/
  
  x = 330;
  dx = 50;	
  
  strcpy(channel, "");
  strcpy(text_str, "Group Ena/Dis");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /*******************************
    Links to other screens Header
    ********************************/
  
  x = x + 65;
  y = y - 20; 
  dx = 100;	
  
  strcpy(channel, "");
  strcpy(text_str, "Voltage/");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);

  y = y + 20; 
  dx = 100;	
  
  strcpy(channel, "");
  strcpy(text_str, "Current");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);

  x = x + 100;
  dx = 150;	
  
  strcpy(channel, "");
  strcpy(text_str, "Other Params");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  x = x + 100;
  dx = 150;	
  
  strcpy(channel, "");
  strcpy(text_str, "Save");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /*********************************************************************************/
  
  
  
  /* This is for the crates */
  
  
  counter = 0;
  
  for (i = 0; i < 20; i++)  {
    
    if (crate_info[i].crate_no != 0) {
      
      crate_no = crate_info[i].crate_no;          
      arcnet_no =crate_info[i].arcnet_no;          
      
      
      /************************
	HV On for a given crate
	*************************/
      
      x = 30 + counter * 120;
      y = 75; 
      
      dx = 70;	
      dy = 30;	
      
      sprintf(channel, "B_HVON_SET_%02d_%02d", arcnet_no, crate_no);
      
      strcpy(button_label, "HV/On");
      strcpy(press_msg, "1");
      bclr = 0;    			/* It is not necessary to repeat this as a
					   white background will be maintained 
					   throughout */
      
      
      adl_object("MESSAGE_BUTTON", x, y, dx, dy, 15);
      
      
      
      /************************
	HV Off for a given crate
	*************************/
      
      
      y = 105; 
      
      sprintf(channel, "B_HVON_SET_%02d_%02d", arcnet_no, crate_no);
      
      strcpy(button_label, "HV/Off");
      strcpy(press_msg, "0");
      
      adl_object("MESSAGE_BUTTON", x, y, dx, dy, 20);
      
      
      
      /****************************
	HV Status for a given crate
	*****************************/
      
      x = 105 + counter * 120;
      y = 77; 
      
      dx = 20;	
      dy = 55;	
      
      sprintf(channel, "B_HVSTATUS_%02d_%02d", arcnet_no, crate_no);
      
      strcpy(direction, "up");
      strcpy(fillmode, "from edge");
      
      adl_object("BAR", x, y, dx, dy, 15);
      
      
      /****  HV button header  ***/
      
      x = 63 + counter * 120;
      y = 145; 
      dx = 40;	
      dy = 20;	
      
      strcpy(channel, "");
      sprintf(text_str, "Crate #%d", crate_no);
      strcpy(alignment, "HC");
      
      adl_object("TEXT", x, y, dx, dy, 54);
      
      
      /**********************/
      
      
      
      counter++;
      
      
      
    } /* end of if condition; ie making hv on/off buttons */
    
    
    
    
  }  /* end of loop for crates */
  
  
  
  
  /*********************************************************************************/
  
  /* j is going to serve as the group number */
  
  for (j = 0; group_info[j].groupname_hv[0] !='\0'; j++) {
    
    i = 0;                                    /* reset the temp_info index to zero */
    
    for (m = 0; chan_info[m].label_hv[0] != '\0'; m++)   {
      
      if (chan_info[m].group_hv == j + 1)  {
	
	temp_info[i] = chan_info[m];
	
	i++;	/* increase the index in temp_info */
	
      }
      
    }  
    
    
    
    
    
    
    /***************
      Group Number 
      ****************/
    
    x = 20;
    y = 235 + j * 55; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, "");
    sprintf(text_str, "%d", group_info[j].group_hv);   
    /* for copying an integer to a text array */
    
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    
    /***************
      Group Name 
      ****************/
    
    x = 115;
    dx = 50;	
    
    strcpy(channel, "");
    strcpy(text_str, group_info[j].groupname_hv);
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    
    /*********************
      Channels per group 
      **********************/
    
    x = 220;
    dx = 50;	
    
    strcpy(channel, "");
    sprintf(text_str, "%d", group_info[j].chan_per_group);   
    /* for copying an integer to a text array */
    
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    /*************
      Group Enable
      **************/
    
    
    bclr = 0;
    
    
    
    x = 315;
    dx = 25;
    dy = 25;
    
    strcpy(snapfile, "$APP/hvcaApp/medm/adl/");
    strcat(snapfile, filename);
    strcat(snapfile, "_");
    strcat(snapfile, group_info[j].groupname_hv);
    strcat(snapfile, "_en.csh > /dev/null 2>&1 &");
    
    sprintf(item_name[0], "%s", snapfile);
    
    sprintf(item_label[0], "%s", "Enable all");  
    
    sprintf(item_args[0], "%s", "");            
    
    adl_object("SHELL_COMMAND", x, y, dx, dy, 15);
    
    
    /*************
      Group Disable
      **************/
    
    x = 375;
    
    strcpy(snapfile, "$APP/hvcaApp/medm/adl/");
    strcat(snapfile, filename);
    strcat(snapfile, "_");
    strcat(snapfile, group_info[j].groupname_hv);
    strcat(snapfile, "_dis.csh > /dev/null 2>&1 &");
    
    sprintf(item_name[0], "%s", snapfile);
    
    sprintf(item_label[0], "%s", "Disable all");  
    
    sprintf(item_args[0], "%s", "");            
    
    adl_object("SHELL_COMMAND", x, y, dx, dy, 20);
    
    
    /******************************  
      Link buttons to other screens
      ******************************/
    
    chans_gr = group_info[j].chan_per_group;
    screens = ( (chans_gr - 1) / 24 ) + 1;
    
    nbutton = screens/8 + 1;

    scr = 0;
    for (i = 0; i < nbutton; i++) {

      x = 30*i + 425;
      
      if (i == nbutton - 1) {
	screens_button = screens - 8*(nbutton - 1);
      }
      else {
	screens_button = 8;
      }
      for (k = 0; k < screens_button; k++) {
	
	if (scr == screens - 1) {
	  nchans = chans_gr - 24*(screens - 1);
	}
	else {
	  nchans = 24;
	}

	strcpy(linkfile, filename);	 
	strcat(linkfile, "_");
	strcat(linkfile, group_info[j].groupname_hv);
	strcat(linkfile, "_");
	sprintf(screens_txt, "%d", scr + 1); 
	strcat(linkfile, screens_txt);          
	strcat(linkfile, ".adl");
	
	sprintf(item_name[k], "%s", linkfile); 
	
	sprintf(item_label[k], "%s - %s", temp_info[scr*24].label_hv,
		temp_info[scr*24 + nchans - 1].label_hv);
	
	scr++;
      } /* end of loop for k */
      
      adl_object("RELATED_DISPLAY", x, y, dx, dy, 38);
      
    }

    scr = 0;
    for (i = 0; i < nbutton; i++) {

      x = 30*i + 525;
      
      if (i == nbutton - 1) {
	screens_button = screens - 8*(nbutton - 1);
      }
      else {
	screens_button = 8;
      }
      for (k = 0; k < screens_button; k++) {
	
	if (scr == screens - 1) {
	  nchans = chans_gr - 24*(screens - 1);
	}
	else {
	  nchans = 24;
	}

	strcpy(linkfile, filename);	 
	strcat(linkfile, "_");
	strcat(linkfile, group_info[j].groupname_hv);
        strcat(linkfile, "_param_");
	sprintf(screens_txt, "%d", scr + 1); 
	strcat(linkfile, screens_txt);          
	strcat(linkfile, ".adl");
	
	sprintf(item_name[k], "%s", linkfile); 
	
	sprintf(item_label[k], "%s - %s", temp_info[scr*24].label_hv,
		temp_info[scr*24 + nchans - 1].label_hv);
	
	scr++;
      } /* end of loop for k */
      
      adl_object("RELATED_DISPLAY", x, y, dx, dy, 38);
      
    }

    /* Save script launcher for the group */

    x = 660;
    
    strcpy(snapfile, "$APP/hvcaApp/scripts/save_hv_4_grp.pl ");
    strcat(snapfile, filename);
    strcat(snapfile, " ");
    strcat(snapfile, group_info[j].groupname_hv);
    /*    strcat(snapfile, " > /dev/null 2>&1 &"); */
    
    sprintf(item_name[0], "xterm -sb -sl 2000 -e %s  &", snapfile);
    
    sprintf(item_label[0], "%s", "Save Group");  
    
    sprintf(item_args[0], "%s", "");            
    
    adl_object("SHELL_COMMAND", x, y, dx, dy, 20);
    

    /* end save script launch */
    
  } /* end of loop for j, i.e. for all the groups */


  /* close the menu gui */  

  adl_object("CLOSE", 10, 10, 1100, 600, 14);
  
  
}
