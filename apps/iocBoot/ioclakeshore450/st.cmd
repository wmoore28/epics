#!../../bin/linux-x86/lakeshore450

## You may have to change lakeshore450 to something else
## everywhere it appears in this file

< envPaths
cd ${TOP}

epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/proto")

## Register all support components
dbLoadDatabase("dbd/lakeshore450.dbd")
lakeshore450_registerRecordDeviceDriver(pdbbase)

## Setup port
drvAsynIPPortConfigure("SER3", "hallb-moxa1:4003")
drvAsynIPPortConfigure("SER4", "hallb-moxa1:4004")

## Set this to see debug messages from asyn
#asynSetTraceMask("SER3",-1,0x09)
#asynSetTraceIOMask("SER3",-1,0x2)
#asynSetTraceMask("SER4",-1,0x09)
#asynSetTraceIOMask("SER4",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
dbLoadRecords("db/lakeshore450.db", "P=HPS:, R=LS450_1:, PORT=SER3")
dbLoadRecords("db/lakeshore450.db", "P=HPS:, R=LS450_2:, PORT=SER4")

cd ${TOP}/iocBoot/${IOC}

## Autosave settings/restore sets
#< save_restore.cmd

dbl > lakeshore450_pv.list
iocInit

## Autosave startup
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
#create_monitor_set("lakeshore_settings.req", 30)

