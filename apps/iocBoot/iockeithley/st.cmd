#!../../bin/linux-x86/keithley6221

## You may have to change keithley6221 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/proto")

## Register all support components
dbLoadDatabase)"dbd/keithley6221.dbd")
keithley6221_registerRecordDeviceDriver(pdbbase)

## Setup port
drvAsynIPPortConfigure("SER2", "hallb-moxa1:4002")

## Set this to see messages from asyn
#asynSetTraceMask("SER2",-1,0x09)
#asynSetTraceIOMask("SER2",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/keithley6221.db", "P=K, R=6221:, PORT=SER2")

cd ${TOP}/iocBoot/${IOC}
dbl > keithley_pv.list
iocInit

seq &check_voltage

