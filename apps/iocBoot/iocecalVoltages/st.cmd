#!../../bin/linux-x86/ioccaen

< envPaths
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/ioccaen.dbd")
ioccaen_registerRecordDeviceDriver(pdbbase)

# call to run sy1527Init()
Init_CAEN()

# call to run sy1527Start(), sy1527GetMap(), sy1527PrintMap()
Start_CAEN(1, "129.57.160.80")
Start_CAEN(2, "129.57.167.190")

## Load record instances
dbLoadRecords("${DEVIOCSTATS}/db/iocAdminSoft.db", "IOC=iocecalVoltages")
dbLoadRecords("db/ecalHV.db")
dbLoadRecords("db/bm_01.db")
dbLoadRecords("db/bm_02.db")

cd ${TOP}/iocBoot/${IOC}
iocInit()
