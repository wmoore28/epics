#!../../bin/linux-x86/HVCAENx527

## You may have to change HVCAENx527 to something else
## everywhere it appears in this file

< envPaths

# Error Log To Console 0 or 1
eltc 1

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/HVCAENx527.dbd"
HVCAENx527_registerRecordDeviceDriver pdbbase

CAENx527ConfigureCreate "hv0", "halltesthv"
CAENx527ConfigureCreate "hv1", "halldcaenhv1"


## Load record instances
#dbLoadTemplate "db/userHost.substitutions"
#dbLoadRecords "db/dbSubExample.db", "user=nersesHost"

CAENx527DbLoadRecords


## Set this to see messages from mySub
#var mySubDebug 1

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncExample, "user=nersesHost"
