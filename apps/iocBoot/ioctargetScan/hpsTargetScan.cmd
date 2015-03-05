#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

epicsEnvSet("PREFIX","")

epicsEnvSet("TARGET_MOTOR","$(PREFIX)hps:target:motor")
# Load DB for scan using sscan EPICS record
dbLoadRecords("$(SSCAN)/sscanApp/Db/standardScans.db","P=$(TARGET_MOTOR):,MAXPTS1=2000,MAXPTS2=1000,MAXPTS3=1000,MAXPTS4=10,MAXPTSH=2000")
dbLoadRecords("$(SSCAN)/sscanApp/Db/saveData.db","P=$(TARGET_MOTOR):")
dbLoadRecords("$(SSCAN)/sscanApp/Db/scanProgress.db","P=$(TARGET_MOTOR):scanProgress:")

dbLoadRecords("db/beamCheck4scan.db","PREF='',R=$(TARGET_MOTOR)")

cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")

< hpsTargetScan_save_restore.cmd

set_pass0_restoreFile("hpsTargetScan.sav")
set_pass1_restoreFile("hpsTargetScan.sav")

#
iocInit
# autosave startup
create_monitor_set("hpsTargetScan.req", 30, "PREF=${PREFIX}")

# Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=xxx:")
#create_monitor_set("info_settings.req", 30, "P=xxx:")

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor
saveData_Init("saveData.req", "P=$(TARGET_MOTOR):")
seq &scanProgress, "S=$(TARGET_MOTOR):,P=$(TARGET_MOTOR):scanProgress:" 

dbpf("$(TARGET_MOTOR):scan1.R1PV", "$(TARGET_MOTOR).RBV")
dbpf("$(TARGET_MOTOR):scan1.P1PV", "$(TARGET_MOTOR).VAL")
dbpf("$(TARGET_MOTOR):scan1.D01PV", "$(TARGET_MOTOR).RBV")

dbpf("$(TARGET_MOTOR):scan1.T1PV", "$(TARGET_MOTOR):beamCheckBusy")
