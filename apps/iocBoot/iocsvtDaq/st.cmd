#!../../bin/linux-x86/svtDaq

#< envPaths_x86
< envPaths

cd ${TOP}


## Register all support components
dbLoadDatabase "dbd/svtDaq.dbd"
svtDaq_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")

dbLoadRecords "db/dbHybT.db"
dbLoadRecords "db/dbHybLVIrd_v125.db"
dbLoadRecords "db/dbHybLVIrd_avdd.db"
dbLoadRecords "db/dbHybLVIrd_dvdd.db"
dbLoadRecords "db/dbHybLVVf_v125.db"
dbLoadRecords "db/dbHybLVVf_avdd.db"
dbLoadRecords "db/dbHybLVVf_dvdd.db"
dbLoadRecords "db/dbHybLVVn_v125.db"
dbLoadRecords "db/dbHybLVVn_avdd.db"
dbLoadRecords "db/dbHybLVVn_dvdd.db"
dbLoadRecords "db/dbHybLVVSetRd_v125.db"
dbLoadRecords "db/dbHybLVVSetRd_avdd.db"
dbLoadRecords "db/dbHybLVVSetRd_dvdd.db"
dbLoadRecords "db/dbHybLVStat.db"
dbLoadRecords "db/dbFebTemp.db"
dbLoadRecords "db/dbHybSync.db"
dbLoadRecords "db/dbDpmMap.db"
dbLoadRecords "db/dbFebLayer.db"
dbLoadRecords "db/dbSVT.db"
dbLoadRecords("db/dbHybSyncBase.db")
dbLoadRecords("db/dbHybSyncPeak.db")



## Set this to see messages from mySub
var mySubDebug 0

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncExample, "user=rootHost"
#seq sncExample, "user=trackerHost"



