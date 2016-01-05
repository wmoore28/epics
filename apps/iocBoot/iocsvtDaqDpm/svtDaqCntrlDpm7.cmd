#!../../bin/linux-x86_64/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqCntrlDpm7")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbControlDpm.db","DPM=7,NR=0")
dbLoadRecords("db/dbControlDpmStatus.db","DPM=7,NR=0")
dbLoadRecords "db/dbHybT.db"
dbLoadRecords "db/dbFebTemp.db"
dbLoadRecords "db/dbHybLVVSetRd_v125.db"
dbLoadRecords "db/dbHybLVVSetRd_avdd.db"
dbLoadRecords "db/dbHybLVVSetRd_dvdd.db"
dbLoadRecords "db/dbFebLayer.db"




var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
