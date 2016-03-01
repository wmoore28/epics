#!../../bin/linux-x86_64/iocscalers

############################################################################
< envPaths
############################################################################

cd ${TOP}

## Setup scalers
Init_SCALERS()

Start_SCALERS_CRATE("0",  "hps11") 
#Start_SCALERS_CRATE("1",  "hps12") 
Start_SCALERS_CRATE("2",  "hps1") 
Start_SCALERS_CRATE("3",  "hps2") 

## Register all support components
dbLoadDatabase("dbd/iocscalers.dbd")
iocscalers_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/jscalers.db")
dbLoadRecords("db/smi_scaler_records.db")
dbLoadRecords("db/waveform2calc.db")

cd ${TOP}/iocBoot/${IOC}

iocInit
