#!../../bin/linux-x86/svtDaqDpm

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
dbLoadRecords("db/dbDataDpmEventCount.db","DPM=2")
dbLoadRecords("db/dbDataDpmTrigCount.db","DPM=2")
dbLoadRecords("db/dbDataDpm.db","DPM=2")
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

var mySubDebug 1

##traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
