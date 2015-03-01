#!../../bin/linux-x86/svtDaqDpm

#< envPaths
< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqDpm0")

## Load record instances
dbLoadRecords("db/dbDataDpmEventCount.db","DPM=0")
dbLoadRecords("db/dbDataDpm.db","DPM=0")
dbLoadRecords("db/dbDataDpmLink.db","DPM=0,DP=0")
dbLoadRecords("db/dbDataDpmLink.db","DPM=0,DP=1")
dbLoadRecords("db/dbDataDpmLink.db","DPM=0,DP=2")
dbLoadRecords("db/dbDataDpmLink.db","DPM=0,DP=3")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=0,DP=0")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=0,DP=1")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=0,DP=2")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=0,DP=3")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=0,DP=0")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=0,DP=1")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=0,DP=2")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=0,DP=3")

var mySubDebug 1

##traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
