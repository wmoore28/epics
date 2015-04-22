#!/bin/bash

if [ -z "$1" ]
then 
	echo "need a file"
	exit
fi

declare -a chs=("avdd" "dvdd" "v125" "datapath" "dpm")


for j in `seq 0 9`
do 
  for c in "${chs[@]}"
	do
	`awk '{print;}' $1 | grep \lv:$j\: | grep $c > $1.$c.$j`
  done
done


#for i in "${arr[@]}"
#do 
#	echo "$i"
