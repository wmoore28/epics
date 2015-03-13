#!../../bin/linux-x86/wave2root

## You may have to change pxi to something else
## everywhere it appears in this file

< envPaths
cd $(TOP)

## Register all support components
dbLoadDatabase "dbd/wave2root.dbd"
wave2root_registerRecordDeviceDriver pdbbase

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "1000000")

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=$(IOC)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC):")


## Load record instances
dbLoadTemplate "db/wave2root.substitutions"


cd $(TOP)/iocBoot/$(IOC)

< save_restore.cmd
iocInit

## Autosave startup
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=$(IOC):")
create_monitor_set("info_settings.req", 30, "P=$(IOC):")
