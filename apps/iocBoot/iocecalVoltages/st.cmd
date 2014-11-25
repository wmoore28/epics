#!../../bin/linux-x86/ioccaen

< envPaths
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/ioccaen.dbd")
ioccaen_registerRecordDeviceDriver(pdbbase)

# call to run sy1527Init()
Init_CAEN()

# call to run sy1527Start(), sy1527GetMap(), sy1527PrintMap()
Start_CAEN(1, "hvhps1")
Start_CAEN(2, "hvecal4")

## Load record instances
dbLoadRecords("db/ecal_01.db")
dbLoadRecords("db/bm_01.db")
dbLoadRecords("db/bm_02.db")

cd ${TOP}/iocBoot/${IOC}
iocInit()
