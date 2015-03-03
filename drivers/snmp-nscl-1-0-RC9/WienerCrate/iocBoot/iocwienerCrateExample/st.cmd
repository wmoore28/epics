#!../../bin/darwin-x86/wienerCrateExample

###############################################################################
# Set up environment
# Need to add run-time expansion for crate support
epicsEnvSet("P","$(P=wienerCrate:)")
epicsEnvSet("R","$(R=1:)")
< envPaths
epicsEnvSet("MIBDIRS", "+$(TOP)/mibs")
epicsEnvSet("WCR_PREF", "admin WIENER-CRATE-MIB::")

###############################################################################
# Register all support components
cd "${TOP}"
dbLoadDatabase "dbd/wienerCrateExample.dbd"
wienerCrateExample_registerRecordDeviceDriver pdbbase

###############################################################################
# Load record instances
dbLoadRecords("db/wienerCrate.db","P=$(P),R=$(R),CRATE=192.168.92.73")

###############################################################################
# Start EPICS
cd "${TOP}/iocBoot/${IOC}"
iocInit
