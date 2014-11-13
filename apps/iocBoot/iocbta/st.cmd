## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocbta"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change bta to something else
## everywhere it appears in this file
ld 0,0, "bta.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/bta.dbd"
bta_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/user.substitutions"
#dbLoadRecords "db/dbSubExample.db", "user=levon"
dbLoadRecords("db/bta_suppl.db","hall=B,ioc=classc6")

## Set this to see messages from mySub
#mySubDebug = 1

## Run this to trace the stages of iocInit
#traceIocInit

cd startup
iocInit

## Start any sequence programs
#seq &sncExample, "user=levon"

#seq &bta, "hall=B,ioc=classc6"

