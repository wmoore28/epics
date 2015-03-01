/* --------------------------------------------- */
program struckDaq
/* --------------------------------------------- */
option +c;

%%#include <math.h>
#include "struckDaq.h"

short stop;
assign stop to "struckDaq_0.STOP";

short erase_start;
assign erase_start to "struckDaq_0.ERST";

short start;
assign start to "struckDaq_0.STRT";

short acqg;
assign acqg to "struckDaq_0.ACQG";
monitor acqg;

double dwel;
assign dwel to "struckDaq_0.DWEL";

char  tmp_name[128];

unsigned int fifo_all[NCHAN][NFIFO];
assign fifo_all to { "struckDaq_0",  "struckDaq_1",  "struckDaq_2",  "struckDaq_3", 
                     "struckDaq_4",  "struckDaq_5",  "struckDaq_6",  "struckDaq_7", 
                     "struckDaq_8",  "struckDaq_9", "struckDaq_10", "struckDaq_11",
                    "struckDaq_12", "struckDaq_13", "struckDaq_14", "struckDaq_15",
                    "struckDaq_16", "struckDaq_17", "struckDaq_18", "struckDaq_19",
                    "struckDaq_20", "struckDaq_21", "struckDaq_22", "struckDaq_23",
                    "struckDaq_24", "struckDaq_25", "struckDaq_26", "struckDaq_27",
                    "struckDaq_28", "struckDaq_29", "struckDaq_30", "struckDaq_31"}; 

short sub_fifo[HALF_FIFO];
assign sub_fifo to "";

float copy_fifo[NFIFO];
assign copy_fifo to "";


float struckDaq_debug;
assign struckDaq_debug to "struckDaq_debug";

int struckDaq_bin;

short tmp_short;
assign tmp_short to "";

float tmp_float;
assign tmp_float to "";

float time_2_fill_fifo;

float pause_time = 0.00000; /* Time to pause before reading */ 


ss struckDaq_calc {
   state init {
        when () {
	  printf( "In init \n" );
	  stop = 1;
          pvPut(stop);
          printf("struckDaq init state done...waiting for HV to init...\n");
        } state  wait
   }
   state wait {
      when (delay(4)) {
	 printf( "In wait \n");
         erase_start = 1;
         pvPut(erase_start);
         pvGet(dwel);
	 pvGet(struckDaq_debug);
         time_2_fill_fifo = dwel*(NFIFO+10);
         struckDaq_bin = 60.*NFIFO*dwel+0.499999;
         printf("struckDaq....here we go data in  %f secs %i\n", time_2_fill_fifo, struckDaq_bin);
      } state stop
   }
   state stop{
	when( delay( dwel * ( NFIFO ) ) ) {
	  stop = 1;
          pvPut(stop);
        } state read
   } 


   state read {
	when() {
	  sprintf(tmp_name,"struckDaq_%i.READ",15);
          pvAssign(tmp_short, tmp_name);
          tmp_short = 1;
	  pvPut( tmp_short );
/*
	  for (i=0; i<16; i++) {
            sprintf(tmp_name,"struckDaq_%i.READ",i);
            pvAssign(tmp_short, tmp_name);
            tmp_short = 1;
            pvPut(tmp_short);
          }
*/
        } state erase_start
   }

/*
   state get_fifo {
	when() {
	     for (i_chan = 0; i_chan < NCHAN; i_chan++) {
               pvGet(fifo_all[i_chan]);
             }
	} state erase_start
   }
*/	
   state erase_start {
        when() {
              erase_start = 1;
              pvPut(erase_start);
              pvGet(dwel);
        } state stop
   }
}











