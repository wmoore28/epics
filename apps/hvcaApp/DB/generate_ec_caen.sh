#!/bin/bash 

rm -f ec_caen.dat

group=0
mf=4
slot=0
ch=0

for i in ec1.dat ec2.dat ec3.dat ec4.dat ec5.dat ec6.dat
  do
  slot=$[$group*9]
  group=$[$group+1]
  cut -d ' ' -f 1 $i | while read NAME
    do
    s=`printf "%02d" "$slot"`
    c=`printf "%02d" "$ch"`
    echo "${NAME}_CAEN      0$group 1 01 0$mf $s 03 $c -1548.0   1.5   1.3    61.0    61.0 -2550.0 -2500.0" >> ec_caen.dat
    
    ch=$[$ch+1]
    [ $ch -eq 24 ] && {
	ch=0
	slot=$[$slot+1]
    }
    [ $slot -eq 16 ] && {
	ch=0
	slot=0
	mf=$[$mf+1]
	echo ---------------------------------- 
	echo ch=$ch slot=$slot mf=$mf
	echo ---------------------------------- 
    }
  done
done

#rm -f xxxx*
