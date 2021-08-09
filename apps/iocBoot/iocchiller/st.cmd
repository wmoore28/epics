#!../../bin/linux-x86_64/chiller
################################################################################
< envPaths
################################################################################
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

drvAsynIPPortConfigure("SER5", "hallb-moxa4:4005")

## debugging...
# ECAL - Anova A40
# asynSetTraceMask("SER5",-1,0x09)
# asynSetTraceIOMask("SER5",-1,0x02)

dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")#dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")
#dbLoadRecords("db/anova.db", "P=HPS_ECAL:,R=CHILLER:,PORT=SER5")

dbLoadRecords("db/Lauda_ECO.db","P=HPS_ECAL:CHILLER,PORT=SER5")

#dbLoadRecords("db/asynRecord.db","P=DOGGY, R=:ASYN,PORT=SER5,ADDR=1,IMAX=2000,OMAX=2000")

dbLoadRecords("db/ecalInterlock.template","P=HPSECAL:,R=INTLK1,PV=tempSensorA,LOW=60,HIGH=75,CTRL=HPSECAL:OFF,CTRLVAL=1")
dbLoadRecords("db/ecalInterlock.template","P=HPSECAL:,R=INTLK2,PV=tempSensorI,LOW=60,HIGH=75,CTRL=HPSECAL:OFF,CTRLVAL=1")

cd ${TOP}/iocBoot/${IOC}

dbLoadRecords("hps-ecal-chiller.alias")

## autosave setup
< save_restore.cmd

dbl > pv.list
iocInit

## Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
