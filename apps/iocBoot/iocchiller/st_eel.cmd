#!../../bin/linux-x86_64/chiller
################################################################################
< envPaths
################################################################################
epicsEnvSet("IOC_ALIAS","iocsvtChillerEEL")

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

drvAsynIPPortConfigure("SER6", "hallb-moxa8:4006")
#drvAsynIPPortConfigure("SER8", "hallb-moxa8:4008")

# asynSetTraceMask("SER6",-1,0x09)
# asynSetTraceIOMask("SER6",-1,0x2)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC_ALIAS}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC_ALIAS}:")

dbLoadRecords("db/anova.db", "P=HPS_EELA20:,R=CHILLER:,PORT=SER6")
#dbLoadRecords("db/anova.db", "P=HPS_SVT:,R=CHILLER:,PORT=SER8")

cd ${TOP}/iocBoot/${IOC}

dbl > pv.list
iocInit

