#!/bin/bash

filename="$1"
all="$1.all"

# remove stuff
cat $filename | grep SVT\: | grep -v sub | grep -v dna | grep -v layer | grep -v poll | grep -v \:side | grep -v \:type | grep -v fanout | grep -v SVT\:process | grep -v hb\_check > $all

# build individual files

hyb_temp="$1.hyb_temp"
cat $all | grep temp0 > $hyb_temp

feb_temp="$1.feb_temp"
cat $all | grep temp\:fe > $feb_temp

avdd_temp="$1.avdd"
cat $all | grep SVT\:lv | grep avdd > $avdd_temp

dvdd_temp="$1.dvdd"
cat $all | grep SVT\:lv | grep dvdd > $dvdd_temp

v125_temp="$1.v125"
cat $all | grep SVT\:lv | grep v125 > $v125_temp

dpm_map="$1.dpm_map"
cat $all | grep SVT\:lv | grep dpm > $dpm_map

datapath_map="$1.datapath_map"
cat $all | grep SVT\:lv | grep datapath > $datapath_map

