#!/bin/bash
if [ -z "$1" ]
then
	echo "allFebCaput.sh part1 part2 value"
	exit
fi
for i in `seq 0 9`
do
	caput "$1:$i:$2" $3
done
