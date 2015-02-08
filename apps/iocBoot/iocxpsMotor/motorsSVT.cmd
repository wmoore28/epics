#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
#dbLoadRecords("db/iocAdminSoft.db","IOC=HPSXPS")

epicsEnvSet("PREFIX","")
### Motors
dbLoadTemplate "db/xpsHallB.substitutions"
dbLoadRecords "db/targets.db", "P=HPS-XPS:, R=m1, pref=${PREFIX}"


#epicsEnvSet("COLL_MOTOR","$(PREFIX)US1-2-BOT:m1")
#epicsEnvSet("CONV_MOTOR","$(PREFIX)US1-2-BOT:m2")
# Load DB for scan using sscan EPICS record
#dbLoadRecords("db/standardScans.db","P=$(CONV_MOTOR):,MAXPTS1=2000,MAXPTS2=1000,MAXPTS3=1000,MAXPTS4=10,MAXPTSH=2000")
#dbLoadRecords("db/saveData.db","P=$(CONV_MOTOR):")
#dbLoadRecords("db/scanProgress.db","P=$(CONV_MOTOR):scanProgress:")

# asyn port, IP address, IP port, number of axes, 
# active poll period (ms), idle poll period (ms), 
# enable set position, set position settling time (ms)
XPSCreateController("HPS-XPS", "hpsxps", 5001, 8, 10, 500, 0, 500)


# XPS asyn port,  axis, groupName.positionerName, stepSize(1/0.00215 mm)
# for MRES=0.0127mm  stepSize=1/0.0127
# for integer number for stepSize , MRES = 0.012658228, stepSize = 79
XPSCreateAxis("HPS-XPS", 0, "S.TestSVT",   "79")

cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")

#< motorsHallD_save_restore.cmd

#set_pass0_restoreFile("motorsHallD.sav")
#set_pass1_restoreFile("motorsHallD.sav")

#
iocInit
# autosave startup
#create_monitor_set("motorsHallD.req", 30, "PREF=${PREFIX}")

# Handle autosave 'commands' contained in loaded databases.
#makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=xxx:")
#create_monitor_set("info_settings.req", 30, "P=xxx:")

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor
#saveData_Init("saveData.req", "P=$(CONV_MOTOR):")
#seq &scanProgress, "S=$(CONV_MOTOR):,P=$(CONV_MOTOR):scanProgress:" 

