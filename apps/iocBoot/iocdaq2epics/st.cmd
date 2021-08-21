#!../../bin/linux-x86_64/amq

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/amq.dbd"
amq_registerRecordDeviceDriver pdbbase

dbLoadRecords("db/daq2epics.db","P=B_DAQ_HPS")

cd ${TOP}/iocBoot/${IOC}

iocInit();

