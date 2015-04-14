#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

#include <stdio.h>

int main(){
  
 printf("sizeof(int)=%d, sizeof(long int)=%d, sizeof(long long)=%d, sizeof(unsigned long *)=%d, sizeof(long *)=%d ,sizeof(long)=%d %d\n"
 , sizeof(int), sizeof(long int), sizeof(long long), sizeof(unsigned long *), sizeof(long *), sizeof(long), sizeof(uint)); 
 
double a=125e+6;
uint b=0xffffffff;
double c=(double)b;
int d=(int)b;

//printf("a=%d  %u   %d size=%ld\n", a, b , d, sizeof(uint));
printf("a=%f %u %d %f size=%ld\n", a,b,d, c,sizeof(uint));

 
}

