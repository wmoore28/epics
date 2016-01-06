#!../../bin/linux-x86_64/flasher

< envPaths
cd ${TOP}

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

## Register all support components
dbLoadDatabase("dbd/flasher.dbd")
flasher_registerRecordDeviceDriver(pdbbase)

## Configure devices
drvAsynIPPortConfigure("L1","B_HPS_FLASHER1:9764",0,0,0)
drvAsynIPPortConfigure("L2","B_HPS_FLASHER2:9764",0,0,0)

## Comment these for verbose output - for debugging purposes.
#asynSetTraceMask("L1", 0, 4)
#asynSetTraceIOMask("L1", 0, 6)
#asynSetTraceIOTruncateSize("L1", 0, 1000)
#asynSetTraceMask("L2", 0, 4)
#asynSetTraceIOMask("L2", 0, 6)
#asynSetTraceIOTruncateSize("L2", 0, 1000)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=$(IOC)")
dbLoadRecords("db/flasher.db","P=B_HPS_ECAL_FLASHER_TOP,R=:asyn,PORT=L1,NCHAN=224");
dbLoadRecords("db/flasher.db","P=B_HPS_ECAL_FLASHER_BOT,R=:asyn,PORT=L2,NCHAN=224");

cd ${TOP}/iocBoot/${IOC}
iocInit
