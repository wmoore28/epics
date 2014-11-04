#!/bin/csh

echo - 0 -
source ~/.cshrc
echo - 1 -
source ~/.login
echo - 2 -
setenv DISPLAY ":0.1"
echo - 3 -
setenv PATH "${PATH}:/home/epics/R3.13.4/epicsB/prod/app/general/alh/oncall_pager"
echo - 4 -
setenv EPICS_CA_ADDR_LIST "129.57.96.7 129.57.163.255 129.57.208.90 129.57.57.188 129.57.96.81"
echo - 5 -

printenv |sort
