
# executable path is below...
# ../../bin/linux-x86/snmp

< envPaths
cd "${TOP}"
epicsEnvSet("MIBDIRS", "+$(TOP)/mibs")
epicsEnvSet("W", "WIENER-CRATE-MIB::")

dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/snmp.db","DEV=TestChan,HOST=192.168.54.62,CHAN=u300,GROUP=0")

cd "${TOP}/iocBoot/${IOC}"
iocInit()
