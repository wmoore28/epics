#!/bin/bash


# remove stuff

cat datadpm.txt | grep SVT\: | grep -v sub | grep -v dna | grep -v layer | grep -v poll | grep -v \:side | grep -v \:type | grep -v fanout | grep -v SVT\:process | grep -v hb\_check | grep -v ioc | grep -v systemstate | grep -v \:state | grep -v socketstatus | grep -v \:status > datadpm.txt.all




cat datadtm.txt | grep SVT\: | grep -v sub | grep -v dna | grep -v layer | grep -v poll | grep -v \:side | grep -v \:type | grep -v fanout | grep -v SVT\:process | grep -v hb\_check | grep -v ioc | grep -v systemstate | grep -v \:state | grep -v socketstatus | grep -v \:status > datadtm.txt.all

