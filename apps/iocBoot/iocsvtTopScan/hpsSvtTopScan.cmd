#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC}:")

epicsEnvSet("PREFIX","")

epicsEnvSet("SVTTOP_MOTOR","$(PREFIX)hps:svt_top:motor")
# Load DB for scan using sscan EPICS record
dbLoadRecords("$(SSCAN)/sscanApp/Db/standardScans.db","P=$(SVTTOP_MOTOR):,MAXPTS1=2000,MAXPTS2=1000,MAXPTS3=1000,MAXPTS4=10,MAXPTSH=2000")
dbLoadRecords("$(SSCAN)/sscanApp/Db/saveData.db","P=$(SVTTOP_MOTOR):")
dbLoadRecords("$(SSCAN)/sscanApp/Db/scanProgress.db","P=$(SVTTOP_MOTOR):scanProgress:")

dbLoadRecords("db/beamCheck4scan.db","PREF='',R=$(SVTTOP_MOTOR)")

cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")

< hpsSvtTopScan_save_restore.cmd

set_pass0_restoreFile("hpsSvtTopScan.sav")
set_pass1_restoreFile("hpsSvtTopScan.sav")

#
iocInit
# autosave startup
create_monitor_set("hpsSvtTopScan.req", 30, "PREF=${PREFIX}")

# Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=xxx:")
#create_monitor_set("info_settings.req", 30, "P=xxx:")

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor
saveData_Init("saveData.req", "P=$(SVTTOP_MOTOR):")
seq &scanProgress, "S=$(SVTTOP_MOTOR):,P=$(SVTTOP_MOTOR):scanProgress:" 

dbpf("$(SVTTOP_MOTOR):scan1.R1PV", "$(SVTTOP_MOTOR).RBV")
dbpf("$(SVTTOP_MOTOR):scan1.P1PV", "$(SVTTOP_MOTOR).VAL")
dbpf("$(SVTTOP_MOTOR):scan1.D01PV", "$(SVTTOP_MOTOR).RBV")

dbpf("$(SVTTOP_MOTOR):scan1.D02PV", "scalerS12b")
dbpf("$(SVTTOP_MOTOR):scan1.D03PV", "scalerS13b")
dbpf("$(SVTTOP_MOTOR):scan1.D04PV", "scalerS14b")
dbpf("$(SVTTOP_MOTOR):scan1.D05PV", "scalerS15b")
dbpf("$(SVTTOP_MOTOR):scan1.D06PV", "scaler_calc1")
dbpf("$(SVTTOP_MOTOR):scan1.D07PV", "hallb_IPM2H02_XPOS")
dbpf("$(SVTTOP_MOTOR):scan1.D08PV", "hallb_IPM2H02_YPOS")
dbpf("$(SVTTOP_MOTOR):scan1.D09PV", "hallb_IPM2H01_CUR")

dbpf("$(SVTTOP_MOTOR):scan1.T1PV", "$(SVTTOP_MOTOR):beamCheckBusy")
