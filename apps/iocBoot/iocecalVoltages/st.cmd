#!../../bin/linux-x86/ioccaen

< envPaths
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/ioccaen.dbd")
ioccaen_registerRecordDeviceDriver(pdbbase)

# call to run sy1527Init()
Init_CAEN()

# call to run sy1527Start(), sy1527GetMap(), sy1527PrintMap()

# hvhps2:
Start_CAEN(1, "129.57.160.93")

# hvhps1:
#Start_CAEN(2, "129.57.160.80")

# hvecal4:
#Start_CAEN(3, "129.57.167.190")

## Load record instances
dbLoadRecords("${DEVIOCSTATS}/db/iocAdminSoft.db", "IOC=iocecalVoltages")
dbLoadRecords("db/ecalHV.db")
dbLoadRecords("db/ecalHV-onoff.db","SIDE=TOP,ONOFF=ON,VAL=1")
dbLoadRecords("db/ecalHV-onoff.db","SIDE=TOP,ONOFF=OFF,VAL=0")
dbLoadRecords("db/ecalHV-onoff.db","SIDE=BOT,ONOFF=ON,VAL=1")
dbLoadRecords("db/ecalHV-onoff.db","SIDE=BOT,ONOFF=OFF,VAL=0")

# THESE ARE IN SLOT 15 of HVHPS2:
#dbLoadRecords("db/bm_01.db")
dbLoadTemplate("db/bm_hvhps2.substitutions")

# THESE ARE IN SLOT 13 of HVECAL4:
#dbLoadRecords("db/bm_02.db") # <-- this ones' numbersing are wrong, still for SLOT 00
#dbLoadTemplate("db/bm_hvecal4.substitutions")

# THESE ARE IN SLOT 00 of HVHPS1: 
#dbLoadTemplate("db/bm_hvhps1.substitutions")

#asSetFilename("ecal.acf")

cd ${TOP}/iocBoot/${IOC}
iocInit()

