#!/bin/bash

base=$1
ch=$2
db=$3

for i in `seq 1 2`; do
	side=""
	if [ $i == 1 ] 
	then
		for j in `seq 0 17`; do
			echo "$1:top:$j:$ch $db"
		done
	else
		for j in `seq 20 37`; do
			echo "$1:bot:$j:$ch $db"
		done
	fi	
		
done
	
