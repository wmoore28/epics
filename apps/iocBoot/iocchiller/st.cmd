#!../../bin/linux-x86/chiller

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

# drvAsynSerialPortConfigure("SER8","/dev/tty_dgrp_D_7",0,0,0)
drvAsynIPPortConfigure("SER5", "hallb-moxa1:4005")

## debugging...
# Anova
# asynSetTraceMask("SER8",-1,0x09)
# asynSetTraceIOMask("SER8",-1,0x2)
# Thermo Scientific
# asynSetTraceMask("SER5",-1,0x09)
# asynSetTraceIOMask("SER5",-1,0x04)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
# dbLoadRecords("db/anova.db", "P=CHILL:,R=,PROTO=anova.proto,PORT=SER8")
dbLoadRecords("db/thermoSci.db", "P=HPS_ECAL:,R=CHILLER:,PORT=SER5")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
< save_restore.cmd

dbl > pv.list
iocInit

## autosave startup
# create_monitor_set("anova_settings.req", 30, "P=CHILL:,R=")

## Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
