#!../../bin/linux-x86_64/svtDaqDpm

## You may have to change svtDaqDpm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaqDpm.dbd"
svtDaqDpm_registerRecordDeviceDriver pdbbase



## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=iocsvtDaqCntrlDpm7_2")

## Load record instances
#dbLoadRecords("db/xxx.db","user=trackerHost")
dbLoadRecords("db/dbControlDpm.db","SCANFREQ=5,DPM=7,NR=2")
dbLoadRecords("db/dbControlDpmStatus.db","SCANFREQ=5,DPM=7,NR=2")
dbLoadRecords ("db/dbSem.db","FEB=0")
dbLoadRecords ("db/dbSem.db","FEB=1")
dbLoadRecords ("db/dbSem.db","FEB=2")
dbLoadRecords ("db/dbSem.db","FEB=3")
dbLoadRecords ("db/dbSem.db","FEB=4")
dbLoadRecords ("db/dbSem.db","FEB=5")
dbLoadRecords ("db/dbSem.db","FEB=6")
dbLoadRecords ("db/dbSem.db","FEB=7")
dbLoadRecords ("db/dbSem.db","FEB=8")
dbLoadRecords ("db/dbSem.db","FEB=9")
dbLoadRecords "db/dbSemAll.db"




var mySubDebug 0
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=trackerHost"
