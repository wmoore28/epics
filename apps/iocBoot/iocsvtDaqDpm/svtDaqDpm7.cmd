#!../../bin/linux-x86_64/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqDpm7")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbDataDpmStatus.db","DPM=7")
dbLoadRecords("db/dbDataDpmEventState.db","DPM=7")
dbLoadRecords("db/dbDataDpmBlockCount.db","DPM=7")
dbLoadRecords("db/dbDataDpmSystemState.db","DPM=7")
dbLoadRecords("db/dbDataDpmBurnCount.db","DPM=7")
dbLoadRecords("db/dbDataDpmInsertedFrames.db","DPM=7")
dbLoadRecords("db/dbDataDpmEBEventErrorCount.db","DPM=7")
dbLoadRecords("db/dbDataDpmEventCount.db","DPM=7")
dbLoadRecords("db/dbDataDpmTrigCount.db","DPM=7")
dbLoadRecords("db/dbDataDpm.db","DPM=7")
dbLoadRecords("db/dbDataDpmLink.db","DPM=7,DP=0")
dbLoadRecords("db/dbDataDpmLink.db","DPM=7,DP=1")
dbLoadRecords("db/dbDataDpmLink.db","DPM=7,DP=2")
dbLoadRecords("db/dbDataDpmLink.db","DPM=7,DP=3")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=7,DP=0")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=7,DP=1")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=7,DP=2")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=7,DP=3")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=7,DP=0")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=7,DP=1")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=7,DP=2")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=7,DP=3")
dbLoadRecords "db/dbHybSync.db"
dbLoadRecords("db/dbHybSyncBase.db")
dbLoadRecords("db/dbHybSyncPeak.db")

var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
