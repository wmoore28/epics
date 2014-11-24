#!/usr/local/clas12/release/0.1/epics/drivers/CAEN_HV/level0/IocShell/O.linux-x86/ioccaen
## You may have to change snmp to something else
## everywhere it appears in this file
< envPaths
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/ioccaen.dbd")
ioccaen_registerRecordDeviceDriver(pdbbase)

Init_CAEN()

# hvhps1
#Start_CAEN(1,  "129.57.167.100") 
Start_CAEN(1,  "129.57.167.80") 
## hvecal1
#Start_CAEN(2,  "129.57.167.53") 
# hvecal4
Start_CAEN(2,  "129.57.167.190") 


## Load record instances
#dbLoadRecords("db/test.db","HOST=129.57.86.248")

cd ${DB}
dbLoadRecords("ecal_01.db")
dbLoadRecords("bm_01.db")
dbLoadRecords("bm_02.db")

## Set this to see messages from mySub
#var mySubDebug 1

#cd ${TOP}/iocBoot/${IOC}
cd /home/nerses/ECAL/iocBoot/iocCAEN_HV
iocInit()
#
#
#
