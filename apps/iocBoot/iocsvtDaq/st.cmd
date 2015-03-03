#!../../bin/linux-x86/svtDaq

## < envPaths_x86
< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaq.dbd"
svtDaq_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
#dbLoadRecords "db/hybLV.db"
#dbLoadRecords "db/dbSubExample.db", "user=trackerHost"
dbLoadRecords "db/dbHybT.db"
dbLoadRecords "db/dbHybLV.db"
dbLoadRecords "db/dbHybLVStat.db"
dbLoadRecords "db/dbFebTemp.db"
dbLoadRecords "db/dbHybSwitch.db"
dbLoadRecords "db/dbSvtDaqMap.db"
dbLoadRecords "db/dbHybSync.db"
dbLoadRecords "db/dbDpmMap.db"
dbLoadRecords "db/dbFebPhysMap.db"
dbLoadRecords "db/dbSVT.db"
#dbLoadRecords "db/dbSVTtest.db"

## Set this to see messages from mySub
var mySubDebug 0

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit
