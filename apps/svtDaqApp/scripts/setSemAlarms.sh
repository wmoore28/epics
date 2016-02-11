#!/bin/bash


base="SVT:daq:feb"
names="sem_error_stat sem_heartbeat_stat"
lim_high=(0.0 1.0)
lim_hihi=(0.0 1.0)
lim_low=(0.0 1.0)
lim_lolo=(0.0 1.0)

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
    done
    ((iname = $iname + 1))
done
