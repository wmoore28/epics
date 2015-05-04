#!/bin/bash

base=$1
type=$2
db=$3

declare -a chs=("anap" "anan" "digi")

for i in `seq 0 9`; do
	for ch in "${chs[@]}"; do 
		echo "$base:$i:$ch:$type $db"
	done
done


