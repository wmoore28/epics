#!../../bin/linux-x86_64/alarm

## You may have to change alarm to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/alarm.dbd"
alarm_registerRecordDeviceDriver pdbbase

## Load record instances
## Call one for each with sector, layer and GPIB ID
dbLoadRecords("db/alarm.db")

dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC}")

cd ${TOP}/iocBoot/${IOC}

< save_restore.cmd

iocInit();

makeAutosaveFiles()
create_monitor_set("alarm_settings.req",30)

