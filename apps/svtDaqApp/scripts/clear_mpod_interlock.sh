#!/bin/bash

for j in `seq 5 8`; do
    for i in `seq -w 00 15`; do
        snmpset -v2c -m +WIENER-CRATE-MIB -M +/usr/clas12/hps/dev/apps/iocBoot/iochvCaen/ -c guru hpsmpod outputSwitch.u$j$i i 10
    done
done
