#!../../bin/linux-x86_64/svtDaqDpm

#< envPaths
< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqDpm2")

## Load record instances
dbLoadRecords("db/dbDataDpmStatus.db","DPM=2")
dbLoadRecords("db/dbDataDpmEventState.db","DPM=2")
dbLoadRecords("db/dbDataDpmBlockCount.db","DPM=2")
dbLoadRecords("db/dbDataDpmSystemState.db","DPM=2")
dbLoadRecords("db/dbDataDpmBurnCount.db","DPM=2")
dbLoadRecords("db/dbDataDpmInsertedFrames.db","DPM=2")
dbLoadRecords("db/dbDataDpmEBEventErrorCount.db","DPM=2")
dbLoadRecords("db/dbDataDpmEventCount.db","DPM=2")
dbLoadRecords("db/dbDataDpmTrigCount.db","DPM=2")
dbLoadRecords("db/dbDataDpm.db","DPM=2")
dbLoadRecords("db/dbHybSyncDataDpmAll.db","DPM=2,HYB=0")
dbLoadRecords("db/dbHybSyncDataDpmAll.db","DPM=2,HYB=1")
dbLoadRecords("db/dbHybSyncDataDpmAll.db","DPM=2,HYB=2")
dbLoadRecords("db/dbHybSyncDataDpmAll.db","DPM=2,HYB=3")
dbLoadRecords("db/dbHybSyncDataDpm.db","DPM=2,HYB=0")
dbLoadRecords("db/dbHybSyncDataDpm.db","DPM=2,HYB=1")
dbLoadRecords("db/dbHybSyncDataDpm.db","DPM=2,HYB=2")
dbLoadRecords("db/dbHybSyncDataDpm.db","DPM=2,HYB=3")
dbLoadRecords("db/dbDataDpmLink.db","DPM=2,DP=0")
dbLoadRecords("db/dbDataDpmLink.db","DPM=2,DP=1")
dbLoadRecords("db/dbDataDpmLink.db","DPM=2,DP=2")
dbLoadRecords("db/dbDataDpmLink.db","DPM=2,DP=3")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=2,DP=0")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=2,DP=1")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=2,DP=2")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=2,DP=3")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=2,DP=0")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=2,DP=1")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=2,DP=2")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=2,DP=3")

var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
