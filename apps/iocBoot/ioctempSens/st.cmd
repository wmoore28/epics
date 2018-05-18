#!../../bin/linux-x86_64/tempSens
################################################################################
< envPaths
################################################################################
cd ${TOP}

epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/proto")

## Register all support components
dbLoadDatabase("dbd/tempSens.dbd")
tempSens_registerRecordDeviceDriver(pdbbase)

## Setup port
drvAsynIPPortConfigure("SER1", "hallb-moxa4:4001")
asynOctetSetOutputEos("SER1", 0, "\r")

## Debugging
#asynSetTraceMask("SER1",-1,0x09)
#asynSetTraceIOMask("SER1",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
dbLoadRecords("db/asynRecord.db", "P=tempSensor:,R=ASYN,PORT=SER1,ADDR=,IMAX=80,OMAX=80")
dbLoadTemplate("db/tempSens.substitutions")

cd ${TOP}/iocBoot/${IOC}

< save_restore.cmd

dbl > tempSens_pv.list
iocInit

## Autosave startup
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
create_monitor_set("tempSens_settings.req", 30)
