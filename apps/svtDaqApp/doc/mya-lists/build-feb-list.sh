#!/bin/bash

./build-feb-list-record.sh SVT:lv:fe v_sens 0.005
./build-feb-list-record.sh SVT:lv:fe v_term 0.005
./build-feb-list-record.sh SVT:lv:fe v_set 0.005
./build-feb-list-record.sh SVT:lv:fe v_set:fbk 0.005
./build-feb-list-record.sh SVT:lv:fe stat 1
./build-feb-list-record.sh SVT:lv:fe i_rd 0.01
