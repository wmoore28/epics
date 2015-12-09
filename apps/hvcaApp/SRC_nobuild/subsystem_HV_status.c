#include <stdlib.h>
#include <math.h>
#include <vxWorks.h>
#include <types.h>
#include <stdioLib.h>
#include <dbDefs.h>
#include <subRecord.h>
#include <mcaRecord.h>
#include <dbCommon.h>
#include <recSup.h>
#include <dbFldTypes.h>
#include <dbAccess.h>
#include <link.h>
#include <string.h>

#define DEBUG 0 /* 0 - disabled; 1 - enabled */

#define MAX_CHAN 1300

static struct dbAddr inp_addr[ALL_CHAN]; /*  input PV addresses */

/* ------------------------------------------------------------------------ */

void get_pv_addr(char *name, struct dbAddr *paddr){

  if (DEBUG) printf("get_pv_addr::Finding address = 0x%x corresponding to name \"%s\"\n",paddr,name);
  dbNameToAddr( name, paddr );
  if (DEBUG) printf("get_pv_addr::Found address = 0x%x corresponding to name \"%s\"\n",paddr,name);
  if( paddr->precord == 0 ) {
    printf("Error in fill_init->get_pv_addr: Cand find %s \n", name );
    exit(1);
  }
}

/* ------------------------------------------------------------------------ */

int InitHV( psub )
     struct subRecord* psub;
{
  long n_chan;
  char name[256];
  const char *pname;
  char letter;
  int i;
  int offset;
  int ihisto;
  pname = name;

  /*
    printf("Initialized Function Summing PV record %s \n",  (char*) ((psub->inpc).value.constantStr) );
  */
  for(ihisto=0; ihisto<4; ihisto++) {
    sprintf(name, "%s_%s_histo", (char*) ((psub->inpa).value.constantStr), veto_groups[ihisto]);
    get_pv_addr(name, &(hist_addr[ihisto]));


    /*set_veto_group(psub);  find out the veto group */
    n_chan = get_inp_ch_info(ihisto, 0, MODE_ENTRIES);
    offset = get_inp_ch_info(ihisto, 0, MODE_OFFSET);
    /*inp_addr = (struct dbAddr*) malloc( ALL_CHAN * sizeof( struct dbAddr ) );*/
    printf("fill_init: The veto_group =  %d\n", ihisto);
    printf("fill_init: The number of channels =  %ld\n", n_chan);

    letter = (char) veto_groups[ihisto][0];
    for(i=0; i<n_chan; i++) {
      sprintf(name,"%s_%c_ai_%d", (char*) ((psub->inpa).value.constantStr),
              letter, get_inp_ch_info(ihisto, i, MODE_INDEX) );
      printf("channel name before get_pv_addr = %s \n",name);
      get_pv_addr(name, &(inp_addr[i+offset]) );
    }
  }
  return(0);
}

/* ------------------------------------------------------------------------ */

int ScanHV( psub )
     struct subRecord* psub;
{
  int ihisto;
  long i, n_chan, option;
  char letter;
  double data[1];
  double *buffer;
  void* pfl;
  int status;
  long one = 1;
  int offset;
  option = 0;


  /*struct subRecord* sub_rec;*/
  /*struct dbAddr rec_addr ;*/

  option = 0;
  status = 0;
  pfl=NULL;


  for(ihisto=0; ihisto<4; ihisto++) {

    /*set_veto_group(psub);  find out the veto group */
    n_chan = get_inp_ch_info(ihisto, 0, MODE_ENTRIES);
    offset = get_inp_ch_info(ihisto, 0, MODE_OFFSET);
    letter = (char) veto_groups[ihisto][0];

    buffer = (double*) malloc( n_chan * sizeof(double) );

    /* loop to read the input channels and fill the buffer */
    for(i=0; i<n_chan; i++) {
      /*sub_rec = (subRecord*)inp_addr[i+offset].precord;*/
      data[0] = -1;
      if ( inp_addr[i+offset].precord != NULL ) {
        status |= dbGetField( &inp_addr[i+offset], DBR_DOUBLE, data, &option, &one, pfl );
        if ( status != 0 ) {
          printf("Error in fill_proc: Can't get data from 0x%x \n", inp_addr[i+offset] );
          psub->val = 0;
          return(-3);
        }
        buffer[i] = data[0];
        /*printf("buffer[%ld] = %f\n",i,data[0]);*/
      } else {
        printf("error in proc: precord is null\n");
      }
    }

    /* copy buffer into histogram */
    if ( hist_addr[ihisto].precord != NULL ) {
      status |= dbPutField( &hist_addr[ihisto], DBR_DOUBLE, buffer, n_chan );
    }
    else
      status |= 0x100 ;
    free( buffer );
  }

  return(status);
}
