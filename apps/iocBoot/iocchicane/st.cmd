#!../../bin/linux-x86/chicane

< envPaths
cd ${TOP}

dbLoadDatabase "dbd/chicane.dbd"
chicane_registerRecordDeviceDriver pdbbase

dbLoadRecords "db/chicane.db", "P=a"

cd ${TOP}/iocBoot/${IOC}

iocInit

seq seqChicane, "P=a"

