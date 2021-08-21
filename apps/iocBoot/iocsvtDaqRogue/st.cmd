#!../../bin/linux-x86_64/svtDaq

< envPaths

# rogue runs on clonfarm2/clonfarm3:
epicsEnvSet("EPICS_CA_ADDR_LIST","129.57.167.90 129.57.167.103 129.57.163.255")

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/svtDaq.dbd"
svtDaq_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")

dbLoadRecords("db/dbFlangeAll.db")
dbLoadRecords("db/dbFebAll.db")
dbLoadRecords("db/dbBiasAll.db")
dbLoadRecords("db/dbHybridAll.db")
dbLoadRecords("db/dbHybCurrent.db")
dbLoadRecords("db/dbHybridCurrentAll.db")
dbLoadRecords("db/dbHybSyncAll.db")
dbLoadRecords("db/dbSemAll.db")
dbLoadRecords("db/dbDataDpmAll.db")

cd ${TOP}/iocBoot/${IOC}
iocInit

