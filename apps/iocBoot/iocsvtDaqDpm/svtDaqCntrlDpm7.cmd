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
dbLoadRecords "db/dbFebAll.db"
dbLoadRecords "db/dbFlangeAll.db"
dbLoadRecords "db/dbBiasAll.db"
dbLoadRecords "db/dbHybridAll.db"
dbLoadRecords "db/dbHybSyncAll.db"
dbLoadRecords "db/dbHybridCurrentAll.db"
dbLoadRecords "db/dbDataDpmAll.db"
dbLoadRecords("db/dbHybCurrent.db","FEB=0")
dbLoadRecords("db/dbHybCurrent.db","FEB=1")
dbLoadRecords("db/dbHybCurrent.db","FEB=2")
dbLoadRecords("db/dbHybCurrent.db","FEB=3")
dbLoadRecords("db/dbHybCurrent.db","FEB=4")
dbLoadRecords("db/dbHybCurrent.db","FEB=5")
dbLoadRecords("db/dbHybCurrent.db","FEB=6")
dbLoadRecords("db/dbHybCurrent.db","FEB=7")
dbLoadRecords("db/dbHybCurrent.db","FEB=8")
dbLoadRecords("db/dbHybCurrent.db","FEB=9")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=0")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=1")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=2")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=3")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=4")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=5")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=6")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=7")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=8")
dbLoadRecords("db/dbFebHeartbeat.db","FEB=9")



var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
