#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC}")

epicsEnvSet("PREFIX","")
### Motors
dbLoadTemplate "db/xpsHallB.substitutions"
dbLoadRecords "db/hpsMotorAliases.db"	, "P=HPS-XPS:, pref=${PREFIX}"
dbLoadRecords "db/hps_targets.db"	, "pref=${PREFIX}"
dbLoadRecords "db/svt_positions.db"	, "pref=${PREFIX}"


# asyn port, IP address, IP port, number of axes, 
# active poll period (ms), idle poll period (ms), 
# enable set position, set position settling time (ms)
XPSCreateController("HPS-XPS", "hpsxps", 5001, 8, 10, 500, 0, 500)


# XPS asyn port,  axis, groupName.positionerName, stepSize(1/0.00215 mm)
# for MRES=0.0127mm  stepSize=1/0.0127
# for integer number for stepSize , MRES = 0.012658228, stepSize = 79
XPSCreateAxis("HPS-XPS", 0, "SVT_TOP.Y",	"79")
XPSCreateAxis("HPS-XPS", 1, "SVT_BOT.Y",   	"79")
XPSCreateAxis("HPS-XPS", 2, "HPS_TARGET.Y",	"79")

cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")


#
iocInit

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor

