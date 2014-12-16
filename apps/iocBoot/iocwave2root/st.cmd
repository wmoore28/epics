#!../../bin/linux-x86/wave2root

## You may have to change pxi to something else
## everywhere it appears in this file

< envPaths
cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/wave2root.dbd"
wave2root_registerRecordDeviceDriver pdbbase

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=$(IOC)")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")


## Load record instances
dbLoadTemplate "db/wave2root.substitutions"


cd ${TOP}/iocBoot/${IOC}
iocInit

