#!../../bin/linux-x86/chiller

############################################################################
< envPaths
############################################################################

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

# 9600 8-N-1, No Flow Ctrl
drvAsynIPPortConfigure("SER1","hallb-moxa1:4006")

## debugging...
# Anova
asynSetTraceMask("SER1",-1,0x09)
asynSetTraceIOMask("SER1",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
dbLoadRecords("db/anova.db", "P=HPS_FE:,R=CHILLER:,PROTO=anova.proto,PORT=SER1")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
#< save_restore.cmd

#dbl > pv.list
iocInit

## autosave startup
#create_monitor_set("anova_settings.req", 30, "P=CHILL:,R=")

## Handle autosave 'commands' contained in loaded databases.
#makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=${IOC}:")
#create_monitor_set("info_settings.req", 30, "P=${IOC}:")
