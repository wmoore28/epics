#!/usr/local/clas12/release/0.1/epics/drivers/CAEN_HV/level0/IocShell/O.linux-x86/ioccaen
# TODO: correct paths as needed (nerses, wmoore)

< envPaths.cmd
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/ioccaen.dbd")
ioccaen_registerRecordDeviceDriver(pdbbase)

Init_CAEN()

# hvhps1
Start_CAEN(1, "129.57.167.100")
## hvecal1
#Start_CAEN(2, "129.57.167.53")
# hvecal4
Start_CAEN(2, "129.57.167.190")

## Load record instances
cd ${DB}
dbLoadRecords("ecal_01.db")
dbLoadRecords("bm_01.db")
dbLoadRecords("bm_02.db")

#cd ${TOP}/iocBoot/${IOC}
cd /home/nerses/ECAL/iocBoot/iocCAEN_HV
iocInit()

