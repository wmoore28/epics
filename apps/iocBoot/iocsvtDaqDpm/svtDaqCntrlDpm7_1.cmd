#!../../bin/linux-x86/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqCntrlDpm7_1")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbControlDpm.db","DPM=7,NR=1")
dbLoadRecords("db/dbControlDpmStatus.db","DPM=7,NR=1")
dbLoadRecords ("db/dbHybLVIrd_v125.db")
dbLoadRecords ("db/dbHybLVIrd_avdd.db")
dbLoadRecords ("db/dbHybLVIrd_dvdd.db")
dbLoadRecords "db/dbHybLVVf_v125.db"
dbLoadRecords "db/dbHybLVVf_avdd.db"
dbLoadRecords "db/dbHybLVVf_dvdd.db"
dbLoadRecords "db/dbHybLVVn_v125.db"
dbLoadRecords "db/dbHybLVVn_avdd.db"
dbLoadRecords "db/dbHybLVVn_dvdd.db"
dbLoadRecords "db/dbHybLVStat.db"



var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
