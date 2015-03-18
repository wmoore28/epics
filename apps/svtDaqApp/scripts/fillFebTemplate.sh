#!/bin/bash
if [ -z "$1" ]
then
	echo "fillFebTemplate.sh <template file>"
	exit
fi
for i in `seq 0 9`
do
	sed "s/FEBTEMPLATE/$i/g" $1
done
