#!../../bin/linux-x86/chiller

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

drvAsynIPPortConfigure("SER5", "hallb-moxa1:4005")

## debugging...
# ECAL - Anova A40
# asynSetTraceMask("SER5",-1,0x09)
# asynSetTraceIOMask("SER5",-1,0x02)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
dbLoadRecords("db/anova.db", "P=HPS_ECAL:,R=CHILLER:,PORT=SER5")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
< save_restore.cmd

dbl > pv.list
iocInit

## Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
