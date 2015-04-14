
/* sy1527_test.c - generic test for sy1527 driver */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>

#include "jscalers.h"

ScalersSlowControl *scalersslowcontrol;

int main()
{
//char *new_args[args->aval.ac+1];
int id;
string hostname="";
// int number_of_slots=16;
// int *board_types=new int[16];
//board_types = new int[number_of_slots];

//scalersslowcontrol->vmecrates[id]=new VmeChassis(id, hostname  , number_of_slots, board_types);
scalersslowcontrol->vmecrates[id]=new VmeChassis(id, hostname );

  return 0;
} 
