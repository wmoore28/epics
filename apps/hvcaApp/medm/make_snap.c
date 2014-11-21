/*********************************************************************
  
  FUNCTION make_snap
  
  Creates the snap files that allow the group
  enables and disables
  
  ***********************************************************************/

#include "hv_adl.h"

void make_snap(int group_no)
     
{
  
  FILE *fs;  /* for the enable script file */
  char enable_scriptfile[30];
  FILE *fq;  /* for the disable script file */
  char disable_scriptfile[30];
  FILE *fr;  /* for the restore script file */
  char restore_scriptfile[30];
  FILE *frdv;  /* for the restore dv script file */
  char restore_dv_scriptfile[30];
  FILE *ft;  /* for the save script file */
  char save_scriptfile[30];
  FILE *fv;  /* for the alarms script file */
  char alarms_scriptfile[30];
  
  
  
  FILE *fp;
  FILE *fpdv;
  
  int i = 0;
  int j = 0;
  int k = 0;
  int l = 0;
  
  int upper_limit;
  
  
  char enable[30];       /* merely the process variable name chan_info[].pvname .......*/
  char disable[30];      /* ............plus the extension .CEO */
  
  extern char enable_snapfile[30];  /* redundant declarations, but here as a reminder */
  extern char disable_snapfile[30]; 
  extern char filename[30];
  
  char save_reqfile[30];    /* burt request file for logging values */
  char pvsave[30];         /* variable used for the channel pvnames */
  
  char restore_snapfile[30];    /* burt snap file for restoring values */
  char restore_dv_snapfile[50];    /* burt snap file for restoring values */
  char restore[30];         /* variable used for the channel pvnames */
  
  char alarms_snapfile[30];
  char alarm[30];
  
  
  /***********************************************************
    Naming and opening of scriptfiles containing the snapfiles 
    ***********************************************************/
  
  
  strcpy(enable_scriptfile, filename);
  strcat(enable_scriptfile, "_");
  strcat(enable_scriptfile, group_info[group_no - 1].groupname_hv);
  strcat(enable_scriptfile, "_en.csh");
  
  fs = fopen(enable_scriptfile, "w");
  fprintf(fs, "%s\n", "#!/bin/csh -f");
  /*
     fprintf(fs, "%s\n", "setenv PATH .:$EPB/extensions/bin/hp700:/bin:/usr/local/bin");  
     */
  fprintf(fs, "%s\n", "echo $PATH");
  fclose(fs);  
  
  
  
  strcpy(disable_scriptfile, filename);
  strcat(disable_scriptfile, "_");
  strcat(disable_scriptfile, group_info[group_no - 1].groupname_hv);
  strcat(disable_scriptfile, "_dis.csh");
  
  fq = fopen(disable_scriptfile, "w");
  fprintf(fq, "%s\n", "#!/bin/csh -f");
  /*
     fprintf(fq, "%s\n", "setenv PATH .:$EPB/extensions/bin/hp700:/bin:/usr/local/bin");  
     */
  fprintf(fq, "%s\n", "echo $PATH"); 
  fclose(fq);  
  
  
  /* Figure out upper limit for the # of channels per file */
  
  upper_limit = group_info[group_no - 1].chan_per_group;
  
  /*********************
    The enable snap file
    *********************/
  
  
  strcpy(enable_snapfile, filename);
  strcat(enable_snapfile, "_");
  strcat(enable_snapfile, group_info[group_no - 1].groupname_hv);
  strcat(enable_snapfile, "_en");
  strcat(enable_snapfile, ".snap");
  
  fp = fopen(enable_snapfile, "w");
  
  fprintf(fp, "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", 
	  "--- Start BURT header",
	  "Time:     October 1996",
	  "Login ID: philips (Sasha Philips)",
	  "Eff  UID: ",
	  "Group ID: ",
	  "Keywords: ",
	  "Comments: Thanks Kathy",
	  "Type:     Absolute",
	  "Directory /site/epics/hallb/hlapp/burt/snapfiles",
	  "Req File: ",
	  "--- End BURT header");
  
  for (l = 0; l < upper_limit; l++) { 
    
    
    
    i = l;  
    
    strcpy(enable, temp_info[i].pvname);
    strcat(enable, "_CE");       
    
    fprintf(fp, "%s %d %d\n", enable, 1, 1);
    
  }
  
  fclose(fp);
  
  
  
  fs = fopen(enable_scriptfile, "a");
  
  fprintf(fs, "%s%s\n", "burtwb -f $APP/hvcaApp/req/", enable_snapfile);    
  fclose(fs);
  
  
  
  /**********************
    The disable snap file
    ***********************/
  
  
  strcpy(disable_snapfile, filename);
  strcat(disable_snapfile, "_");  
  strcat(disable_snapfile, group_info[group_no - 1].groupname_hv);
  strcat(disable_snapfile, "_dis");
  strcat(disable_snapfile, ".snap");
  
  fp = fopen(disable_snapfile, "w");
  
  fprintf(fp, "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", 
	  "--- Start BURT header",
	  "Time:     October 1996",
	  "Login ID: philips (Sasha Philips)",
	  "Eff  UID: ",
	  "Group ID: ",
	  "Keywords: ",
	  "Comments: Thanks Kathy",
	  "Type:     Absolute",
	  "Directory /site/epics/hallb/hlapp/burt/snapfiles",
	  "Req File: ",
	  "--- End BURT header");
  
  
  for (l = 0; l < upper_limit; l++) { 
    
    i = l;  
    
    
    strcpy(disable, temp_info[i].pvname);
    strcat(disable, "_CE");       
    
    fprintf(fp, "%s %d %d\n", disable, 1, 0);
    
  }
  
  
  fclose(fp);
  
  
  fq = fopen(disable_scriptfile, "a");
  
  fprintf(fq, "%s%s\n", "burtwb -f $APP/hvcaApp/req/", disable_snapfile);    
  fclose(fq);
  
  
  /**************************
    Close all the scriptfiles
    **************************/
  
  
  fs = fopen(enable_scriptfile, "a");
  fprintf(fs, "%s\n", "exit");    
  fclose(fs);
  
  fq = fopen(disable_scriptfile, "a");
  fprintf(fq, "%s\n", "exit");    
  fclose(fq);
  
}






