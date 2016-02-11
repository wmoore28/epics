#!/bin/bash


base="SVT:daq:feb"
names="sem_error_stat sem_heartbeat_stat"
lim_high=(1 2)
lim_hihi=(1 2)
lim_low=(-1 0)
lim_lolo=(-1 0)

iname=0
for n in $names
do
    for i in `seq 0 9`
    do
	name="$base:$i:$n"
	echo "Set $name for feb $i to high ${lim_high[*]}"
	caput "$name.LOW" ${lim_low[iname]}
	caput "$name.LOLO" ${lim_lolo[iname]}
	caput "$name.HIGH" ${lim_high[iname]}
	caput "$name.HIHI" ${lim_hihi[iname]}
	caput "$name.LSV" MINOR
	caput "$name.HSV" MINOR
	caput "$name.LLSV" MAJOR
	caput "$name.HHSV" MAJOR
    done
    ((iname = $iname + 1))
done
