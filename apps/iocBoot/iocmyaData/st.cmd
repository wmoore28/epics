#!../../bin/linux-x86/myaData

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/myaData.dbd"
myaData_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

dbLoadRecords("db/harpScanData.db", "P=HB_BEAM:SCAN:,R=2c21:")
dbLoadRecords("db/harpScanData.db", "P=HB_BEAM:SCAN:,R=tagger:")
dbLoadRecords("db/harpScanData.db", "P=HB_BEAM:SCAN:,R=2H02A:")
dbLoadRecords("db/wireScanData.db", "P=HPS_SVT:SCAN:,R=")

cd ${TOP}/iocBoot/${IOC}

## autosave setup
< save_restore.cmd

iocInit

## autosave startup
create_monitor_set("harpScanDataAll.req", 30)
create_monitor_set("wireScanData.req", 30, "P=HPS_SVT:SCAN:,R=")

## Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}:")
create_monitor_set("info_settings.req", 30, "P=${IOC}:")
