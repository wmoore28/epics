#!../../bin/linux-x86/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqDtm1")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbDataDtm.db","DTM=1")
dbLoadRecords("db/dbDataDtmStatus.db","DTM=1")
dbLoadRecords("db/dbDataDtmTrigCount.db","DTM=1")
dbLoadRecords("db/dbDataDtmReadCount.db","DTM=1")
dbLoadRecords("db/dbDataDtmMinTrigPeriod.db","DTM=1")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=0")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=1")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=2")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=3")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=4")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=5")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=6")
dbLoadRecords("db/dbDataDtmAckCount.db","DTM=1,DPM=7")


var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
