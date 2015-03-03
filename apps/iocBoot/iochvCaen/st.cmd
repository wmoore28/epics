#!../../bin/linux-x86/hvCaen

# scanOnce requests are placed in a ring buffer.
# This command can be used to set the size for the ring buffer.
# The default is 1000. It should rarely be necessary to override this default.
# Normally the ring buffer overflow messages appear when the scanOnce task fails.
#scanOnceSetQueueSize 2000
scanOnceSetQueueSize 1000

< envPaths
epicsEnvSet("PREFIX","")
epicsEnvSet("MIB","WIENER-CRATE-MIB::")
epicsEnvSet("WO", "WIENER-CRATE-MIB::output")

# Error Log To Console 0 or 1
eltc 1

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/hvCaen.dbd"
hvCaen_registerRecordDeviceDriver pdbbase

# detUsePrefix "prefix"
detUsePrefix ${PREFIX}

devSnmpSetParam(DebugLevel, 1)
#devSnmpSetMaxOidsPerReq("halldmpod6", 1)
#devSnmpSetSnmpVersion("halldmpod6","SNMP_VERSION_2c")
#devSnmpSetParam(ReadStarvationMSec, 60000)
#devSnmpSetParam(PassivePollMSec, 1500)
#devSnmpSetParam(SetSkipReadbackMSec, 50000000)

#detConfigureCrate "Detector", "URI"
detConfigureCrate "SVT", "sqlite://${TOP}/hvCaenApp/src/svt_voltages.db"

# Automatically generate EPICS DB for CAEN HV Chassis
detDbLoadRecords

#dbLoadRecords "db/hybLV.db"
#dbLoadRecords "db/svtOnOff.db" 
#dbLoadRecords "db/svtBiasSetpoints.db"
dbLoadRecords "db/dbFlangeSwitch.db"
dbLoadRecords "db/dbFebSwitch.db"
dbLoadRecords "db/dbHVSwitch.db"
dbLoadRecords "db/dbHVset.db"

## Load devIocStats
dbLoadRecords("db/iocAdminSoft.db", "IOC=${IOC}")

cd ${TOP}/iocBoot/${IOC}
iocInit


