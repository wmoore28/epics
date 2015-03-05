#!../../bin/linux-x86/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqDpm6")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbDataDpmEventCount.db","DPM=6")
dbLoadRecords("db/dbDataDpmTrigCount.db","DPM=6")
dbLoadRecords("db/dbDataDpm.db","DPM=6")
dbLoadRecords("db/dbDataDpmLink.db","DPM=6,DP=0")
dbLoadRecords("db/dbDataDpmLink.db","DPM=6,DP=1")
dbLoadRecords("db/dbDataDpmLink.db","DPM=6,DP=2")
dbLoadRecords("db/dbDataDpmLink.db","DPM=6,DP=3")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=6,DP=0")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=6,DP=1")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=6,DP=2")
dbLoadRecords("db/dbDataDpmHybNum.db","DPM=6,DP=3")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=6,DP=0")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=6,DP=1")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=6,DP=2")
dbLoadRecords("db/dbDataDpmFebNum.db","DPM=6,DP=3")

var mySubDebug 1

#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
