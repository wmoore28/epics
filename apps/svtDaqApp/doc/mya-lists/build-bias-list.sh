#!/bin/bash

./build-bias-list-record.sh SVT:bias i_rd 0.000001
./build-bias-list-record.sh SVT:bias v_sens 0.1
./build-bias-list-record.sh SVT:bias v_term 0.1
./build-bias-list-record.sh SVT:bias stat 1
./build-bias-list-record.sh SVT:bias v_set:fbk 0.1

