#!../../bin/linux-x86/chiller

############################################################################
< envPaths
############################################################################

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

drvAsynIPPortConfigure("SER2", "hallb-moxa1:4007")
## Set terminators for using asyn directly
asynOctetSetInputEos( "SER2", 0, "\r")
asynOctetSetOutputEos("SER2", 0, "\r\n")

## debugging...
# Presto
#asynSetTraceMask("SER2",-1,0x09)
#asynSetTraceIOMask("SER2",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}-svt")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}-svt:")
dbLoadRecords("db/presto.db", "P=HPS_SVT:,R=CHILLER:,PORT=SER2")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
< save_restore_presto.cmd

iocInit

## autosave startup
create_monitor_set("presto_settings.req", 30, "P=HPS_SVT:,R=CHILLER:")

## Handle autosave 'commands' contained in loaded databases.
#makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=${IOC}:")
#create_monitor_set("info_settings.req", 30, "P=${IOC}:")
