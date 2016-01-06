#!../../bin/linux-x86_64/chicane

< envPaths
cd ${TOP}

dbLoadDatabase "dbd/chicane.dbd"
chicane_registerRecordDeviceDriver pdbbase

dbLoadRecords "db/chicane.db", "P=hps_chicane"
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")

cd ${TOP}/iocBoot/${IOC}

iocInit

seq seqChicane, "P=hps_chicane"

