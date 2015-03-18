#!/bin/bash
if [ -z "$1" ]
then
	echo "fillHybTemplate.sh <template file>"
	exit
fi
for i in `seq 0 17`
do
	sed "s/HYBRIDTEMPLATE/top:$i/g" $1
done
for i in `seq 20 37`
do
	sed "s/HYBRIDTEMPLATE/bot:$i/g" $1
done
