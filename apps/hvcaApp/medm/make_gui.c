/**************************************************************************
 **************************************************************************
 
 FUNCTION make_gui  
 
 function that makes gui for a selected # of channels
 at this point.
 
 ***************************************************************************
 ***************************************************************************/

#include "hv_adl.h"

void make_gui(int screen_no,
	      int screens,
	      int group_no)
     
{
  
  int dx, dy;  
  int x, y; 
  int i, j, k, l; 
  int upper_limit;
  
  char screen_no_txt[5];  /* to convert integers to text  */
  char screens_txt[5];	/* to convert integers to text  */
  char snapfile[150];
  
  extern char filename[30]; 	 /* redundant declarations, but here as a reminder */
  extern char enable_snapfile[30];  
  extern char disable_snapfile[30]; 
  
  
  
  
  
  /**************************
    Creates the gui filename 
    ***************************/
  
  strcpy(adl_file, filename);
  strcat(adl_file, "_");
  strcat(adl_file, group_info[group_no - 1].groupname_hv);
  strcat(adl_file, "_");
  sprintf(screen_no_txt, "%d", screen_no); /* convert integer to string */
  strcat(adl_file, screen_no_txt);
  strcat(adl_file, ".adl");
  
  
  
  
  
  adl_object("OPEN", 10, 10, 800, 850, 14); 
  
  
  /* Parameters for a given operation have to be assigned values !before! every 
     adl_object call.  Otherwise the last value assigned to that variable
     is carried over. */
  
  /*******************************************
    Headers/Labels
    *******************************************/
  
  /************
    MAIN HEADER
    ************/
  
  x = 45;
  y = 20;
  dx = 300;
  dy = 35;
  
  strcpy(channel, "");
  strcpy(text_str, "VOLTAGE/CURRENT");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  x = 415;
  y = 15;
  dx = 50;
  dy = 20;
  
  strcpy(channel, "");
  
  strcpy(text_str, group_info[group_no - 1].groupname_hv );
  
  
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  x = 415;
  y = 35;
  dx = 50;
  dy = 20;
  
  strcpy(channel, "");
  strcpy(text_str, "Screen " );
  strcat(text_str, screen_no_txt);
  strcat(text_str, " of ");
  sprintf(screens_txt, "%d", screens);  /* convert integer to string */
  strcat(text_str, screens_txt);
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Channel Name Header
    *************************/
  
  x = 15;
  y = 75; 
  dx = 110;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Channel Name");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Group Number Header
    *************************/
  
  x = 135;
  y = 75; 
  dx = 50;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Group#");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  
  /*********************************
    Measured Voltage header
    **********************************/
  
  x = 342;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Measured V");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /****************************
    Demand Voltage Confirm header
    *****************************/
  
  x = 420;
  y = 75; 
  dx = 80;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Demand V");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Demand Voltage header
    *************************/
  
  x = 520;
  y = 75; 
  dx = 80;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input V");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Measured Current header
    *************************/
  
  x = 642;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Measured I");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Channel Status header
    *************************/
  
  x = 720;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Status");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  /**************************************************************
    Generate screen for channels using a loop
    ***************************************************************/
  
  
  
  /* Figure out upper limit for the loop; 24 channels per screen
     until the last screen */
  
  
  if (group_info[group_no - 1].chan_per_group - 24 * (screen_no - 1) >= 24) {
    
    upper_limit = 24;
  }
  else if (group_info[group_no - 1].chan_per_group - 24 * (screen_no -1) < 24) {
    
    upper_limit = group_info[group_no - 1].chan_per_group - 24 * (screen_no -1);
  }
  
  
  
  for (j = 0; j < upper_limit; j++) {
    
    l = 24 * (screen_no - 1) + j;
    
    
    /*************
      Channel Name 
      *************/
    
    x = 20;
    y = 100 + 30*j; 
    dx = 100;
    dy = 20;
    
    strcpy(channel, "");
    strcpy(text_str, temp_info[l].label_hv);
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    /********
      Group #
      *********/
    
    x = 140;
    y = 100 + 30*j;
    dx = 40;
    dy = 20;
    
    sprintf(text_str, "%d", temp_info[l].group_hv);   
    /* for copying an integer to a text array */
    
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    
    
    
    /******* 
      Enable 
      *******/
    
    x = 200;
    y = 100 + 30*j;
    dx = 28;
    dy = 20;
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_CE"); 
    strcpy(button_label, "Ena");
    strcpy(press_msg, "1");
    bclr = 0;
    
    adl_object("MESSAGE_BUTTON", x, y, dx, dy, 15);
    
    
    /*************
      Enable Status
      **************/
    
    x = 240;    
    y = 103 + 30*j;
    dx = 14;
    dy = 14;
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.K"); 
    strcpy(style, "dash");    
    strcpy(clrmode, "discrete");
    strcpy(visibility, "if not zero");
    
    
    adl_object("OVAL", x, y, dx, dy, 15);
    
    /******** 
      Disable 
      ********/
    
    x = 272;
    y = 100 + 30*j;  
    dx = 28;
    dy = 20;
    
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_CE");
    strcpy(button_label, "Dis");
    strcpy(press_msg, "0");
    bclr = 0;  
    
    adl_object("MESSAGE_BUTTON", x, y, dx, dy, 20);
    
    
    
    /******************
      Measured Voltage 
      ******************/
    
    
    
    x = 320;
    y = 100 + 30*j; 
    dx = 80;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.F");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    
    
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    /***********************
      Demand Voltage Confirm 
      ************************/
    
    
    x = 420;
    y = 100 + 30*j; 
    dx = 80;	
    dy = 20;	 
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.G");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    
    
    /***************
      Demand Voltage 
      ****************/
    
    
    x = 520;
    y = 100 + 30*j; 
    dx = 80;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_DV");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    bclr = 0;
    
    
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    /******************
      Measured Current 
      ******************/
    
    
    
    x = 620;
    y = 100 + 30*j; 
    dx = 80;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.E");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    
    
    /******************
      Channel Status 
      ******************/
    
    
    
    x = 720;
    y = 100 + 30*j; 
    dx = 40;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.L");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
  }  	/* end of 'make screen' for loop */
  
  adl_object("CLOSE", 10, 10, 800, 850, 14);
  
  
  /*******************************************************************
    
    Screens for related control parameters
    
    ******************************************************************/
  
  
  /**************************
    Create the gui filename 
    ***************************/
  
  strcpy(adl_file, filename);
  strcat(adl_file, "_");
  strcat(adl_file, group_info[group_no - 1].groupname_hv);
  strcat(adl_file, "_param_");
  sprintf(screen_no_txt, "%d", screen_no); /* convert integer to string */
  strcat(adl_file, screen_no_txt);
  strcat(adl_file, ".adl");
  
  
  adl_object("OPEN", 10, 10, 1050, 850, 14); 
  
  bclr = 0;    			/* It is not necessary to repeat this as a
		  		   white background will be maintained 
		  		   throughout */
  
  
  
  
  /*******************************************
    Headers/Labels
    *******************************************/
  
  /************
    MAIN HEADER
    ************/
  
  x = 75;
  y = 20;
  dx = 300;
  dy = 35;
  
  strcpy(channel, "");
  strcpy(text_str, "CONTROL PARAMETERS");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  x = 475;
  y = 15;
  dx = 50;
  dy = 20;
  
  strcpy(channel, "");
  
  strcpy(text_str, group_info[group_no - 1].groupname_hv );
  
  
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  x = 475;
  y = 35;
  dx = 50;
  dy = 20;
  
  strcpy(channel, "");
  strcpy(text_str, "Screen " );
  strcat(text_str, screen_no_txt);
  strcat(text_str, " of ");
  sprintf(screens_txt, "%d", screens);  /* convert integer to string */
  strcat(text_str, screens_txt);
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /************************
    Channel Name Header
    *************************/
  
  x = 15;
  y = 75; 
  dx = 110;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Channel Name");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Group #  Header
    *************************/
  
  x = 135;
  y = 75; 
  dx = 50;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Group#");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  
  /*********************************
    High Voltage Limit header
    **********************************/
  
  x = 212;
  y = 75; 
  dx = 30;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "V Limit");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  
  /****************************
    Trip Current header
    *****************************/
  
  x = 282;
  y = 75; 
  dx = 30;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Trip I");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /****************************
    Trip Current Set
    *****************************/
  
  x = 352;
  y = 75; 
  dx = 30;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input TI");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Ramp Up header
    *************************/
  
  x = 422;
  y = 75; 
  dx = 30;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Ramp Up");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Ramp Up Set header
    *************************/
  
  x = 488;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input RU");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Ramp Down header
    *************************/
  
  x = 558;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Ramp Down");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  /************************
    Ramp Down Set header
    *************************/
  
  x = 628;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input RD");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Voltage Dead Zone header
    *************************/
  
  x = 698;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "MVDZ");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /*****************************
    Voltage Dead Zone Set header
    ******************************/
  
  x = 768;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input MVDZ");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Current Dead Zone header
    *************************/
  
  x = 838;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "MCDZ");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /*****************************
    Current Dead Zone Set header
    ******************************/
  
  x = 908;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Input MCDZ");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  
  /************************
    Channel Status header
    *************************/
  
  x = 978;
  y = 75; 
  dx = 40;	
  dy = 18;	
  
  strcpy(channel, "");
  strcpy(text_str, "Status");
  strcpy(alignment, "HC");
  
  adl_object("TEXT", x, y, dx, dy, 54);
  
  for (j = 0; j < upper_limit; j++) {
    
    l = 24 * (screen_no - 1) + j;
    
    
    /*************
      Channel Name 
      *************/
    
    x = 20;
    y = 100 + 30*j; 
    dx = 100;
    dy = 20;
    
    strcpy(channel, "");
    strcpy(text_str, temp_info[l].label_hv);
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    /********
      Group #
      *********/
    
    x = 140;
    y = 100 + 30*j;
    dx = 40;
    dy = 20;
    
    sprintf(text_str, "%d", temp_info[l].group_hv);   
    /* for copying an integer to a text array */
    
    strcpy(alignment, "HC");
    
    adl_object("TEXT", x, y, dx, dy, 14);
    
    
    /*******************
      High Voltage Limit
      *******************/
    
    x = 200;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.O");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    
    /***************
      Trip Current
      ****************/
    
    x = 270;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.J");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    
    /*****************
      Trip Current Set
      ******************/
    
    x = 340;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_TC");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    
    /***************
      Ramp Up
      ****************/
    
    x = 410;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.H");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    /***************
      Ramp Up Set
      ****************/
    
    x = 480;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_RUP");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    
    /***************
      Ramp Down
      ****************/
    
    x = 550;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.I");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    /***************
      Ramp Down Set
      ****************/
    
    x = 620;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_RDN");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    
    /*******************
      Voltage Dead Zone
      ********************/
    
    x = 690;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.M");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    /***********************
      Voltage Dead Zone Set
      ************************/
    
    x = 760;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_MVDZ");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    /*******************
      Current Dead Zone
      ********************/
    
    x = 830;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.N");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
    /***********************
      Current Dead Zone Set
      ************************/
    
    x = 900;
    y = 100 + 30*j; 
    dx = 50;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_MCDZ");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    adl_object("TEXT_ENTRY", x, y, dx, dy, 14);
    
    
    
    /******************
      Channel Status 
      
      ******************/
    
    
    x = 970;
    y = 100 + 30*j; 
    dx = 40;	
    dy = 20;	
    
    strcpy(channel, temp_info[l].pvname);
    strcat(channel, "_property.L");
    strcpy(format, "decimal");
    strcpy(alignment, "HC");
    
    
    adl_object("TEXT_UPDATE", x, y, dx, dy, 14);
    
  }  	/* end of 'make screen' for loop */
  
  adl_object("CLOSE", 10, 10, 1050, 850, 14);
  
} /* End of function make_gui */


