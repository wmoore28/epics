#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <tsDefs.h>
#include <cadef.h>
#include <ezca.h>


void setzero(char* pvname, long lnth);
void low(char* type);

void delay_(seconds, status)
    float *seconds;
    int *status;
{
    *status = ezcaDelay(*seconds);
}

void e_message_off_()
{
    ezcaAutoErrorMessageOff();
}

void e_message_on_()
{
    ezcaAutoErrorMessageOn();
}

void err_prefix_(prefix, lnth)
    char prefix[];
    long lnth;
{
    setzero(prefix, lnth);
    ezcaPerror(prefix);
}

void g_ctrl_limits_(pvname, low, high, status, lnth)
    char pvname[];
    double *low, *high;
    int *status;
    long lnth;
    
{
    setzero(pvname, lnth);
    *status = ezcaGetControlLimits(pvname, low, high);
}

void g_err_string_(prefix, str_buff, status, lnth, ln2)
    char prefix[], str_buff[];
    int *status;
    long lnth, ln2;
{
    int len_err;
    char *str;
    setzero(prefix, lnth);
    *status = ezcaGetErrorString(prefix, &str);
    len_err = strlen(str);
    if(len_err > ln2)
      printf("\n\n\n\n  WARNING: The string length is insufficient !!!\n\n\n\n");
    strcpy(str_buff, str);
    ezcaFree((void *) str);
}

void g_graph_limits_(pvname, low, high, status, lnth)
    char pvname[];
    double *low, *high;
    int *status;
    long lnth;
{
    setzero(pvname, lnth);
    *status = ezcaGetGraphicLimits(pvname, low, high);
}

void g_nelem_(pvname, nelem, status, lnth)
    char pvname[];
    int *nelem, *status;
    long lnth;
{
    setzero(pvname, lnth);
    *status = ezcaGetNelem(pvname, nelem);
}

void g_precision_(pvname, precision, status, lnth)
    char pvname[];
    short *precision;
    int *status;
    long lnth;
    
{
    setzero(pvname, lnth);
    *status = ezcaGetPrecision(pvname, precision);
}

void g_retrycount_(retrycount)
    int *retrycount;
{
    *retrycount = ezcaGetRetryCount();
}

void g_status_(pvname, nsec, secPastEpoch, state, severity, status, lnth)
    char pvname[];
    int *nsec, *secPastEpoch, *status;
    short *state, *severity;
    long lnth;
    
{
    TS_STAMP t;
    setzero(pvname, lnth);
    *status = ezcaGetStatus(pvname, &t, state, severity);
    *nsec = t.nsec;
    *secPastEpoch = t.secPastEpoch;
}

void g_timeout_(timeout)
    float *timeout;
{
    *timeout = ezcaGetTimeout();
}

void g_units_(pvname, units, status, lnth, ldum)
    char pvname[], units[];
    int *status;
    long lnth, ldum;
{
    setzero(pvname, lnth);
    *status = ezcaGetUnits(pvname, units);
}

void g_value_(pvname_in, type_in, data_buff, nelem, status, lnth, ln_type)
    char pvname_in[], type_in[], *data_buff;
    int *nelem, *status;
    long lnth, ln_type;
{
    char pvname[100], type[10];
/*
    setzero(pvname, lnth);
    setzero(type, ln_type);
*/
    strcpy(pvname, pvname_in);
    pvname[lnth] = '\0';
    strcpy(type, type_in);
    type[ln_type] = '\0';
    low(type);
    if(!strcmp(type, "string"))
      *status = ezcaGet(pvname, ezcaString, *nelem, data_buff);
    else if(!strcmp(type, "byte"))
      *status = ezcaGet(pvname, ezcaByte, *nelem, data_buff);
    else if(!strcmp(type, "short"))
      *status = ezcaGet(pvname, ezcaShort, *nelem, data_buff);
    else if(!strcmp(type, "long"))
      *status = ezcaGet(pvname, ezcaLong, *nelem, data_buff);
    else if(!strcmp(type, "float"))
      *status = ezcaGet(pvname, ezcaFloat, *nelem, data_buff);
    else if(!strcmp(type, "double"))
      *status = ezcaGet(pvname, ezcaDouble, *nelem, data_buff);
    else{
      printf("\n\n\n\n   Argument 2 of g_value() '%s' is not available!!!\n\n\n", type);
      *status = 9;
      exit(1);
    }
}

void group_off_(status)
  int *status;
{
    *status = ezcaEndGroup();
}

void group_on_(status)
  int *status;
{
    *status = ezcaStartGroup();
}

void group_report_(ret_code, lnth, status)
    int ret_code[], *status;
    long lnth;
{
    int i, *buf, length;
    *status = ezcaEndGroupWithReport(&buf, &length);
    if(length > lnth){
      printf("\n\n\n\n  WARNING: The length of the status array is insufficient !!!\n\n\n\n");
      *status = 9;
      exit(1);
    }
    for (i = 0; i < length; i++)
      ret_code[i] = buf[i];
    ezcaFree((void *) buf);
}

void monitor_check_(pvname, type, status, lnth, ln_type)
    char pvname[], type[]; 
    int *status;
    long lnth, ln_type;
{
    setzero(pvname, lnth);
    setzero(type, ln_type);
    low(type);
    if(!strcmp(type, "string"))
      *status = ezcaNewMonitorValue(pvname, ezcaString);
    else if(!strcmp(type, "byte"))
      *status = ezcaNewMonitorValue(pvname, ezcaByte);
    else if(!strcmp(type, "short"))
      *status = ezcaNewMonitorValue(pvname, ezcaShort);	
    else if(!strcmp(type, "long"))
      *status = ezcaNewMonitorValue(pvname, ezcaLong);
    else if(!strcmp(type, "float"))
      *status = ezcaNewMonitorValue(pvname, ezcaFloat);
    else if(!strcmp(type, "double"))
      *status = ezcaNewMonitorValue(pvname, ezcaDouble);
    else{
      printf("\n\n\n\n   Argument 2 of monitor_check() '%s' is not available!!!\n\n\n", type);
      *status = 9;
      exit(1);
    }
}

void monitor_off_(pvname, type, status, lnth, ln_type)
    char pvname[], type[]; 
    int *status;
    long lnth, ln_type;
{
    setzero(pvname, lnth);
    setzero(type, ln_type);
    low(type);
    if(!strcmp(type, "string"))
      *status = ezcaClearMonitor(pvname, ezcaString);
    else if(!strcmp(type, "byte"))
      *status = ezcaClearMonitor(pvname, ezcaByte);
    else if(!strcmp(type, "short"))
      *status = ezcaClearMonitor(pvname, ezcaShort);	
    else if(!strcmp(type, "long"))
      *status = ezcaClearMonitor(pvname, ezcaLong);
    else if(!strcmp(type, "float"))
      *status = ezcaClearMonitor(pvname, ezcaFloat);
    else if(!strcmp(type, "double"))
      *status = ezcaClearMonitor(pvname, ezcaDouble);
    else{
      printf("\n\n\n\n   Argument 2 of monitor_off() '%s' is not available!!!\n\n\n", type);
      *status = 9;
      exit(1);
    }
}

void monitor_on_(pvname, type, status, lnth, ln_type)
    char pvname[], type[]; 
    int *status;
    long lnth, ln_type;
{
    setzero(pvname, lnth);
    setzero(type, ln_type);
    low(type);
    if(!strcmp(type, "string"))
      *status = ezcaSetMonitor(pvname, ezcaString, 100);
    else if(!strcmp(type, "byte"))
      *status = ezcaSetMonitor(pvname, ezcaByte, 100);
    else if(!strcmp(type, "short"))
      *status = ezcaSetMonitor(pvname, ezcaShort, 100);	
    else if(!strcmp(type, "long"))
      *status = ezcaSetMonitor(pvname, ezcaLong, 100);
    else if(!strcmp(type, "float"))
      *status = ezcaSetMonitor(pvname, ezcaFloat, 100);
    else if(!strcmp(type, "double"))
      *status = ezcaSetMonitor(pvname, ezcaDouble, 100);
    else{
      printf("\n\n\n\n   Argument 2 of monitor_on() '%s' is not available!!!\n\n\n", type);
      *status = 9;
      exit(1);
    }
}

void p_retrycount_(retrycount, status)
    int *retrycount, *status;
{
    *status = ezcaSetRetryCount(*retrycount);
}

void p_timeout_(timeout, status)
    float *timeout;
    int *status;
{
    *status = ezcaSetTimeout(*timeout);
}

void p_value_(pvname_in, type_in, data_buff, nelem, status, lnth, ln_type)
    char pvname_in[], type_in[], *data_buff;
    int *nelem, *status;
    long lnth, ln_type;
{
    char pvname[100], type[10];
/*
    setzero(pvname, lnth);
    setzero(type, ln_type);
*/
    strcpy(pvname, pvname_in);
    pvname[lnth] = '\0';
    strcpy(type, type_in);
    type[ln_type] = '\0';
    low(type);
    if(!strcmp(type, "string"))
      *status = ezcaPut(pvname, ezcaString, *nelem, data_buff);
    else if(!strcmp(type, "byte"))
      *status = ezcaPut(pvname, ezcaByte, *nelem, data_buff);
    else if(!strcmp(type, "short"))
      *status = ezcaPut(pvname, ezcaShort, *nelem, data_buff);
    else if(!strcmp(type, "long"))
      *status = ezcaPut(pvname, ezcaLong, *nelem, data_buff);
    else if(!strcmp(type, "float"))
      *status = ezcaPut(pvname, ezcaFloat, *nelem, data_buff);
    else if(!strcmp(type, "double"))
      *status = ezcaPut(pvname, ezcaDouble, *nelem, data_buff);
    else{
      printf("\n\n\n\n   Argument 3 of p_value() '%s' is not available!!!\n\n\n", type);
      *status = 9;
      exit(1);
    }
}

void setzero(pvname, lnth)
  char pvname[];
  long lnth;
{
  int j;

  for (j = lnth - 1; j >= 1; j--)
    if(pvname[j] == ' ')
      ;
    else{
      pvname[j+1] = '\0';
      break;
    }
}

void low(type)
  char type[];
{
  int i = 0;

  while(type[i] != '\0'){
    if(type[i] > 64 && type[i] < 91)
      type[i] += 32;
    i++;
  }
}
