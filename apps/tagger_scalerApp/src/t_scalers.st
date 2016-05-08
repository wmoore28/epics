/* -------------------------------------------- */
program t_scalers
/* -------------------------------------------- */
option -c;

#define NFIFO 512
#define NCOUNT 64
#define NCHAN 192
#define OFFSET_CHAN 0

short t_read_done;
assign t_read_done to "tag_t_Read";
monitor t_read_done;

float t_high;
assign t_high to "tag_t_Start.HIGH";

float t_fifo;
assign t_fifo to "tag_t_fifo";

short t_mode;
assign t_mode to "tag_t_reStart";

short t_start;
assign t_start to "tag_t_Start";

float t_read_time;
assign t_read_time to "tag_t_191.ERTM";

float t_dwel_time;
assign t_dwel_time to "tag_t_191.DWEL";

int   n_fifo_this_read;
int   i;
int   i_fifo;
int   i_t_ctr;
float t_sum;
float live_time;

char t_name[128];

float t_all[NCHAN];
assign t_all to "tag_t_scalers";

float t_relative[NCHAN];
assign t_relative to "tag_t_relative";

short t_amorphous_rad;
assign t_amorphous_rad to "tag_t_amorphous_rad";

float t_amorphous[NCHAN];
assign t_amorphous to "tag_t_amorphous";

float t_rel2amorphous[NCHAN];
assign t_rel2amorphous to "tag_t_rel2amorphous";

float t_hz[NCHAN];
assign t_hz to "tag_t_scalers_hz";

float t_cncd[NCOUNT];
assign t_cncd to "tag_t_coin";

float t_left[NCOUNT];
assign t_left to "tag_t_left";

float t_right[NCOUNT];
assign t_right to "tag_t_right";


float t_tmp[NFIFO];
assign t_tmp to "tag_t_192";

ss fill_array {
   state init {
     when () {
	  pvGet(t_dwel_time);
          printf("t_scalers summation state code loaded DWEL: %f\n", t_dwel_time);
     } state scalers_read
   }
   state scalers_read {
        when (t_read_done==1) {
/*	 printf("t_scalers: state scalers_read t_read_done=1\n");  */
	 ;
        } state get_arrays
   }
   state get_arrays {
	when(delay(0.2))  {
         pvGet(t_amorphous);
         pvGet(t_read_time);
	 pvGet(t_dwel_time);
         n_fifo_this_read = t_read_time/t_dwel_time;
/*	 printf("read time is %f n fifo is %i\n",t_read_time, n_fifo_this_read); */
	 if (n_fifo_this_read > NFIFO) {
           n_fifo_this_read = NFIFO;
         }
	 t_fifo = n_fifo_this_read;
         pvPut(t_fifo);
/*         printf("performing read of %i fifo\n", n_fifo_this_read); */

	 for (i=0; i<NCHAN; i++) {  
	    i_t_ctr = i + 1 + OFFSET_CHAN;
	    sprintf (t_name,"tag_t_%i",i_t_ctr);
	    pvAssign(t_tmp,t_name);
            pvGet(t_tmp);
	    t_sum = 0;
	    for (i_fifo=0; i_fifo < n_fifo_this_read; i_fifo++) {
		t_sum = t_sum + t_tmp[i_fifo];
	    }
	    if (t_all[i] != 0) {
	       t_relative[i] = t_sum/t_all[i];
            } else {
	       t_relative[i] = 1;
            }
	    if (t_amorphous[i] != 0) {
	       t_rel2amorphous[i] = t_sum/t_amorphous[i];
            } else {
	       t_rel2amorphous[i] = 1;
            }
	    t_all[i] = t_sum;

	    if ( i < NCOUNT ) {
	       t_cncd[i] = t_sum;
            }
	    if ( (i >= NCOUNT) && (i < (2*NCOUNT)) ) {
	       t_left[i-NCOUNT] = t_sum;
	/* These are the cable swaps  */
	       if ( ( i-NCOUNT ) == 61 )
		   t_left[0] =  t_sum; 
	       if ( ( i-NCOUNT ) == 62 )
		   t_left[32] =  t_sum; 
            }
	    if ( i >= (2*NCOUNT) ) {
	       t_right[i - 2*NCOUNT] = t_sum;
	/* These are the cable swaps  */
	       if ( ( i-2*NCOUNT ) == 61 )
		   t_right[0] =  t_sum; 
	       if ( ( i-2*NCOUNT ) == 62 )
		   t_right[32] =  t_sum; 
	    }

	    pvGet(t_amorphous_rad);
	    if (t_amorphous_rad) {
              t_amorphous[i] = t_sum;
            }
         }
	 pvPut(t_all);
	 pvPut(t_cncd);
	 pvPut(t_left);
	 pvPut(t_right);
	 pvPut(t_relative);
	 pvPut(t_rel2amorphous);
	 pvPut(t_amorphous);
         t_amorphous_rad = 0;
	 pvPut(t_amorphous_rad);
         pvGet(t_dwel_time);
         live_time = t_dwel_time*t_fifo;
/*	 printf("live_time %f\n",live_time); */
         if (live_time > 0) {
  	   for (i=0; i<NCHAN; i++) {  
             t_hz[i] = t_all[i]/live_time;
           }
         }

         pvPut(t_hz);
	 pvGet(t_mode);
         pvGet(t_high);
         t_high = t_high - 1;
	 if (t_mode == 1) {
	  t_start = 1;
	  pvPut(t_start);
         }
        } state scalers_read
   } 
   state wait_or_go {
       when (delay(t_high)) {
       } state scalers_read
       when (delay(1)) {
       ;
       } state scalers_read
   }
}


