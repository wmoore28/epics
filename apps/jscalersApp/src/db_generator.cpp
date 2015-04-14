
/* db_generator.cpp */

#include <stdio.h>
#include <unistd.h>
#include <string>
#include "../Driver/common.h"

using namespace std;



///#include "../Driver/sy1527.h" /// my:
///#include "command.h" /// my:
//#define CRATE_LABEL "B_SCALERS%03d"
//#define CRATE_LABEL "B_SCALERSHPS11"
///----------------- CRATES/SLOTS CONFIGURATION ----------------------------

#define NCRATES 4
#define NSLOTS 22


enum {DISC2, FADC250};
int NCHANNELS[2] = {16, 16}; /// array indexes are e.g. DISC2, FADC250

char *crate_names[]={
    "B_SCALERSHPS11", // 0
    "B_SCALERSHPS12", // 1
    "B_SCALERSHPS1", // 2
    "B_SCALERSHPS2" // 3
};


int slot_types[14][22] =
{
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 0
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 1
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 2
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 3
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 4
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 5
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 6
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 7
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 8
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 9
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 10
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 11
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 },  // crate 12
  {DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2, DISC2 }   // crate 13
};

///-------------------------------------------------------------------------

///   0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15     slot number


#define get_part \
"record(bigsub, \"%s_%d_%d\") { \n \
   field(PRIO,\"LOW\") \n \
   field(DESC,\"big subroutine record\") \n \
   field(INAM,\"InitChannel\") \n \
   field(INPA,\"%02d\") \n \
   field(INPB,\"%02d\") \n \
   field(HIGH,\"50\") \n \
   field(INPC,\"%02d\") \n \
   field(HSV,\"MAJOR\") \n \
   field(PREC,\"1\") \n \
   field(SNAM,\"ScanChannel\") \n \
   field(SCAN,\"2 second\") \n \
}\n "

//pwonoff
//HV/OFF
//HV/ON

/// for boards

#define put_part_board_bo \
"record(bo, \"%s_%d_P%d_BO\") {  \n \
   field(DTYP,\"CAEN_HV\") \n \
   field(DESC,\"smi\") \n \
   field(OUT,\"#C%d S%d\") \n \
   field(OMSL,\"supervisory\") \n \
   field(ZNAM,\"%s\") \n \
   field(ONAM,\"%s\") \n \
   field(SCAN,\"Passive\") \n \
}\n"

#define put_part_board_bi \
"record(bi, \"%s_%d_P%d\") {  \n \
   field(DTYP,\"CAEN_HV\") \n \
   field(OSV,\"MAJOR\") \n \
   field(DESC,\"smi\") \n \
   field(ZSV,\"NO_ALARM\") \n \
   field(INP,\"#C%d S%d\") \n \
   field(ZNAM,\"%s\") \n \
   field(ONAM,\"%s\") \n \
   field(SCAN,\"2 second\") \n \
}\n"



/// for channels



#define put_part_aao \
"record(aao, \"%s_Sl%d_Ch%d_%s\") {  \n \
   field(DTYP,\"JLAB_SCALERS\") \n \
   field(DESC,\"scaler settings\") \n \
   field(OUT,\"#C%d S%d\") \n \
   field(NELM,\"10\")  \n \
   field(FTVL,\"DOUBLE\")  \n \
   field(SCAN,\"Passive\") \n \
}\n"

#define put_part_waveform \
"record(waveform, \"%s_Sl%d_Ch%d\") {  \n \
   field(DTYP,\"JLAB_SCALERS\") \n \
   field(DESC,\"scaler waveform\") \n \
   field(INP,\"#C%d S%d\") \n \
   field(NELM,\"4\")  \n \
   field(FTVL,\"DOUBLE\")  \n \
   field(SCAN,\"2 second\") \n \
}\n"

/*
#define put_part \
"record(bo, \"%s_%d_%d_%s\") {  \n \
}\n"
*/

int main(int argc,char *argv[]){

//printf(\"%s\n\",set_part.c_str());

FILE *fp=fopen("scalers_prod.db","w+");

//fprintf(fp,"%s",crates.c_str());
//fprintf(fp,"%s",set_part.c_str());

char tmp[1000], tmp1[100];
/*
//printf(\"%d %d\n\", slot_mask[0][5], slot_mask[1][5]);

for(int i=0;i<NCRATES;i++){
  
  sprintf(tmp,CRATE_LABEL,i);
  scrate=string(tmp);
  replace();
  //if(!slot_mask[i][j])continue;
  // sprintf(tmp, get_carte_part, i,j,j10,i,j,j10);
   fprintf(fp,"%s",get_crate_part.c_str());
  

}
*/
//=======================================

//enum{SET_THRESHOLD, SET_MODE};

char *pars[]={"threshold", "mode"};

int commands[]= {JLAB_SET_THRESHOLD, JLAB_SET_READ_MODE};
int NSETPARS=sizeof(commands)/sizeof(commands[0]);

int input_c, input_s;


//printf("size%d\n", sizeof(commands));

// {card 0-7: chassis, 8-15: slot;  signal 0-7:channel, 8-15:command}.



 for(int ip=0;ip<NSETPARS;ip++){


  for(int i=0;i<NCRATES;i++){
 strcpy(tmp1,crate_names[i]);
 //sprintf(tmp1,CRATE_LABEL,i);
//printf("%s 0\n", tmp1);

  for(int j=0;j<NSLOTS;j++){
   ///if(!slot_mask[i][j])continue;
   input_c=i+(j<<8);


   for(int j10=0;j10<NCHANNELS[slot_types[i][j]];j10++){
//printf("%s 2\n", pars[ip]);
   input_s=j10+(commands[ip]<<8);

    sprintf(tmp, put_part_aao, tmp1,j,j10,pars[ip],input_c,input_s);
//printf("%s 1\n", tmp);
    fprintf(fp,"%s",tmp);
   }
  }

 
  }
 }

//=======================================



  for(int i=0;i<NCRATES;i++){

 strcpy(tmp1,crate_names[i]);

//sprintf(tmp1,CRATE_LABEL,i);
//printf("%s 0\n", tmp1);

  for(int j=0;j<NSLOTS;j++){
   ///if(!slot_mask[i][j])continue;
   input_c=i+(j<<8);


   for(int j10=0;j10<NCHANNELS[slot_types[i][j]];j10++){
//printf("%s 2\n", pars[ip]);
   input_s=j10+(0<<8);

    sprintf(tmp, put_part_waveform, tmp1,j,j10,input_c,input_s);

//printf("%s 1\n", tmp);
    fprintf(fp,"%s",tmp);
   }
  }

 
  }
 

/*

for(int i=0;i<NCRATES;i++){

 sprintf(tmp1,CRATE_LABEL,i);

 for(int j=0;j<NSLOTS;j++){
  if(!slot_mask[i][j])continue;
  for(int j10=0;j10<NCHANNELS[slot_types[i][j]];j10++){
   sprintf(tmp, get_part, tmp1,j,j10,i,j,j10);
   fprintf(fp,"%s",tmp);
  }
 }
}
//printf(\"%s\n\",tmp);
*/



//4000000000000000000
//printf(\"1\n\");
return 1;

}
