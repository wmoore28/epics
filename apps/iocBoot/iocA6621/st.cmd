#!../../bin/linux-x86/A6621

## You may have to change A6621 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/A6621.dbd"
A6621_registerRecordDeviceDriver pdbbase

## Configure devices
drvAsynIPPortConfigure("L0",129.57.160.95:1234,0,0,0)
#asynSetTraceMask("L0",-1,0x09)
#asynSetTraceIOMask("L0",-1,0x02)
asynOctetSetOutputEos("L0",0,"\r\n")
asynOctetSetInputEos("L0",0,"\n")

## Load record instances
dbLoadRecords("./A6621.db","PV=HPSECALLV,PORT=L0,ADDR=24,IMAX=2000,OMAX=2000")

cd ${TOP}/iocBoot/${IOC}
iocInit

