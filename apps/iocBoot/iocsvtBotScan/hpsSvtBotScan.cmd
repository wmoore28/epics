#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

epicsEnvSet("PREFIX","")

epicsEnvSet("SVTBOT_MOTOR","$(PREFIX)hps:svt_bot:motor")
# Load DB for scan using sscan EPICS record
dbLoadRecords("$(SSCAN)/sscanApp/Db/standardScans.db","P=$(SVTBOT_MOTOR):,MAXPTS1=2000,MAXPTS2=1000,MAXPTS3=1000,MAXPTS4=10,MAXPTSH=2000")
dbLoadRecords("$(SSCAN)/sscanApp/Db/saveData.db","P=$(SVTBOT_MOTOR):")
dbLoadRecords("$(SSCAN)/sscanApp/Db/scanProgress.db","P=$(SVTBOT_MOTOR):scanProgress:")

dbLoadRecords("db/beamCheck4scan.db","PREF='',R=$(SVTBOT_MOTOR)")

cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")

< hpsSvtBotScan_save_restore.cmd

set_pass0_restoreFile("hpsSvtBotScan.sav")
set_pass1_restoreFile("hpsSvtBotScan.sav")

#
iocInit
# autosave startup
create_monitor_set("hpsSvtBotScan.req", 30, "PREF=${PREFIX}")

# Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=xxx:")
#create_monitor_set("info_settings.req", 30, "P=xxx:")

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor
saveData_Init("saveData.req", "P=$(SVTBOT_MOTOR):")
seq &scanProgress, "S=$(SVTBOT_MOTOR):,P=$(SVTBOT_MOTOR):scanProgress:" 

dbpf("$(SVTBOT_MOTOR):scan1.R1PV", "$(SVTBOT_MOTOR).RBV")
dbpf("$(SVTBOT_MOTOR):scan1.P1PV", "$(SVTBOT_MOTOR).VAL")
dbpf("$(SVTBOT_MOTOR):scan1.D01PV", "$(SVTBOT_MOTOR).RBV")

dbpf("$(SVTBOT_MOTOR):scan1.T1PV", "$(SVTBOT_MOTOR):beamCheckBusy")
