#!../../bin/linux-x86_64/chiller
################################################################################
< envPaths
################################################################################
epicsEnvSet("IOC_ALIAS","iocsvtChiller")

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

## ECAL, FE Boards, SVT
#drvAsynIPPortConfigure("SER5", "hallb-moxa4:4005") 

# A20 (FE):
drvAsynIPPortConfigure("SER6", "hallb-moxa4:4006")

# PRESTO (Hybrids):
drvAsynIPPortConfigure("SER7", "hallb-moxa4:4007")

# A40 (Hybrids):
#drvAsynIPPortConfigure("SER8", "hallb-moxa4:4008")

# LaudaXT (Hybrids):
#drvAsynIPPortConfigure("SER9", "hallb-moxa4:4009")

## debugging...
# Anova
# asynSetTraceMask("SER6",-1,0x09)
# asynSetTraceIOMask("SER6",-1,0x2)
# Thermo Scientific
# asynSetTraceMask("SER5",-1,0x09)
# asynSetTraceIOMask("SER5",-1,0x04)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC_ALIAS}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC_ALIAS}:")
## ECAL, FE Boards, SVT
#dbLoadRecords("db/thermoSci.db", "P=HPS_ECAL:,R=CHILLER:,PORT=SER5")

dbLoadRecords("db/anova.db", "P=HPS_FE:,R=CHILLER:,PORT=SER6")

# PRESTO (Hybrids):
dbLoadRecords("db/presto.db", "P=HPS_SVT:,R=CHILLER:,PORT=SER7")

# a40 *hYBRIDS):
#dbLoadRecords("db/anova.db", "P=HPS_SVT:,R=CHILLER:,PORT=SER8")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
#< save_restore_svt.cmd

dbl > pv.list
iocInit

## autosave startup
# create_monitor_set("anova_settings.req", 30, "P=HPS_FE:,R=CHILLER:")
# create_monitor_set("presto_settings.req", 30, "P=HPS_SVT:R=CHILLER:")

## Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC_ALIAS}:")
create_monitor_set("info_settings.req", 30, "P=${IOC_ALIAS}:")
