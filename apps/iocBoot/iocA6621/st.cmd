#!../../bin/linux-x86_64/A6621

## You may have to change A6621 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/A6621.dbd"
A6621_registerRecordDeviceDriver pdbbase

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/proto")

## Configure devices
drvAsynIPPortConfigure("L0",129.57.160.95:1234,0,0,0)
#drvAsynIPPortConfigure("L0",hallb-gpib01.jlab.org:1234,0,0,0)

#asynSetTraceMask("L0",-1,0x09)
#asynSetTraceIOMask("L0",-1,0x02)
asynOctetSetOutputEos("L0",0,"\r\n")
asynOctetSetInputEos("L0",0,"\n")

## Load record instances
## Call one for each with sector, layer and GPIB ID
dbLoadRecords("db/A6621.db","P=HPSECALLV,PORT=L0,ADDR=24,IMAX=2000,OMAX=2000")

#dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

cd ${TOP}/iocBoot/${IOC}

< save_restore.cmd

asSetFilename("ecal.acf")

iocInit();

makeAutosaveFiles()
create_monitor_set("A6621_settings.req",30,"P=HPSECALLV")

