#!../../bin/linux-x86_64/chicane

< envPaths
cd ${TOP}

dbLoadDatabase "dbd/chicane.dbd"
chicane_registerRecordDeviceDriver pdbbase

dbLoadRecords "db/chicane.db", "P=hps_chicane"
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

cd ${TOP}/iocBoot/${IOC}

< save_restore.cmd

iocInit

makeAutosaveFiles()
create_monitor_set("chicane_settings.req",30,"P=hps_chicane")

seq seqChicane, "P=hps_chicane"

