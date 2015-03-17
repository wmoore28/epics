#!/bin/bash
if [ -z "$1" ]
then
	echo "allHybCaput.sh part1 part2 value"
	exit
fi
for i in `seq 0 17`
do
	caput "$1:top:$i:$2" $3
done
for i in `seq 20 37`
do
	caput "$1:bot:$i:$2" $3
done
