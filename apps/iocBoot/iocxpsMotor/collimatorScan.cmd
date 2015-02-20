#!../../bin/linux-x86/xpsMotor


< envPaths

cd ${TOP}

dbLoadDatabase("dbd/xpsMotor.dbd")
xpsMotor_registerRecordDeviceDriver(pdbbase)

# Load IOC status records
dbLoadRecords("db/iocAdminSoft.db","IOC=COLSCAN")

epicsEnvSet("PREFIX","")
epicsEnvSet("COLL_MOTOR","$(PREFIX)US1-2-BOT:m1")

# Load IO records for XPS chassis
dbLoadTemplate "db/collimatorScan.substitutions"

# Load DB for scan using sscan EPICS record
dbLoadRecords("db/standardScans.db","P=$(COLL_MOTOR):,MAXPTS1=2000,MAXPTS2=1000,MAXPTS3=1000,MAXPTS4=10,MAXPTSH=2000")
dbLoadRecords("db/saveData.db","P=$(COLL_MOTOR):")
dbLoadRecords("db/scanProgress.db","P=$(COLL_MOTOR):scanProgress:")
dbLoadRecords("db/beamCheck4scan.db","PREF='',R=$(COLL_MOTOR)")


cd ${TOP}/iocBoot/${IOC}
#asSetFilename("ca_security.txt")

# Open port for XPS IO ports 
XPSAuxConfig("US1-2-BOT", "us1-2-bot", 5001, 50)

cd ${TOP}/iocBoot/${IOC}

< collimatorScan_save_restore.cmd

set_pass0_restoreFile("collimatorScan.sav")
set_pass1_restoreFile("collimatorScan.sav")

#
iocInit
# autosave startup
create_monitor_set("collimatorScan.req", 30, "PREF=${PREFIX}")

# Handle autosave 'commands' contained in loaded databases.
makeAutosaveFiles()
#create_monitor_set("info_positions.req", 5, "P=xxx:")
#create_monitor_set("info_settings.req", 30, "P=xxx:")

# Launch sequencer for to do scan progress and save data
cd ${TOP}/iocBoot/iocxpsMotor
saveData_Init("saveData.req", "P=$(COLL_MOTOR):")
seq &scanProgress, "S=$(COLL_MOTOR):,P=$(COLL_MOTOR):scanProgress:" 

# Setup the PV to be written in the file
dbpf("$(COLL_MOTOR):scan1.R1PV", "$(COLL_MOTOR).RBV")
dbpf("$(COLL_MOTOR):scan1.P1PV", "$(COLL_MOTOR).VAL")
dbpf("$(COLL_MOTOR):scan1.D01PV", "$(COLL_MOTOR).RBV")
dbpf("$(COLL_MOTOR):scan1.D02PV", "iochdcol:TOD")
dbpf("$(COLL_MOTOR):scan1.D03PV", "IBCAD00CRCUR6")
dbpf("$(COLL_MOTOR):scan1.D04PV", "PSC:disc:scaler:1")
dbpf("$(COLL_MOTOR):scan1.D05PV", "PSC:disc:scaler:2")
dbpf("$(COLL_MOTOR):scan1.D06PV", "PSC:disc:scaler:3")
dbpf("$(COLL_MOTOR):scan1.D07PV", "PSC:disc:scaler:4")
dbpf("$(COLL_MOTOR):scan1.D08PV", "PSC:disc:scaler:5")
dbpf("$(COLL_MOTOR):scan1.D09PV", "PSC:disc:scaler:6")
dbpf("$(COLL_MOTOR):scan1.D10PV", "PSC:disc:scaler:7")
dbpf("$(COLL_MOTOR):scan1.D11PV", "PSC:disc:scaler:8")
dbpf("$(COLL_MOTOR):scan1.D12PV", "PSC:disc:scaler:9")
dbpf("$(COLL_MOTOR):scan1.D13PV", "PSC:disc:scaler:10")
dbpf("$(COLL_MOTOR):scan1.D14PV", "PSC:disc:scaler:11")
dbpf("$(COLL_MOTOR):scan1.D15PV", "PSC:disc:scaler:12")
dbpf("$(COLL_MOTOR):scan1.D16PV", "PSC:disc:scaler:13")
dbpf("$(COLL_MOTOR):scan1.D17PV", "PSC:disc:scaler:14")
dbpf("$(COLL_MOTOR):scan1.D18PV", "PSC:disc:scaler:15")
dbpf("$(COLL_MOTOR):scan1.D19PV", "PSC:disc:scaler:16")
dbpf("$(COLL_MOTOR):scan1.D20PV", "HALO:g:col:l:rate")
dbpf("$(COLL_MOTOR):scan1.D21PV", "HALO:g:col:t:rate")
dbpf("$(COLL_MOTOR):scan1.D22PV", "HALO:g:col:r:rate")
dbpf("$(COLL_MOTOR):scan1.D23PV", "HALO:g:col:b:rate")
dbpf("$(COLL_MOTOR):scan1.D24PV", "HALO:g:tgt:l:rate")
dbpf("$(COLL_MOTOR):scan1.D25PV", "HALO:g:tgt:t:rate")
dbpf("$(COLL_MOTOR):scan1.D26PV", "HALO:g:tgt:r:rate")
dbpf("$(COLL_MOTOR):scan1.D27PV", "HALO:g:tgt:b:rate")
dbpf("$(COLL_MOTOR):scan1.D28PV", "IOCHDCOL:VMICADC1_1")
dbpf("$(COLL_MOTOR):scan1.D29PV", "IOCHDCOL:VMICADC2_1")
dbpf("$(COLL_MOTOR):scan1.D30PV", "IOCHDCOL:VMICADC3_1")
dbpf("$(COLL_MOTOR):scan1.D31PV", "IOCHDCOL:VMICADC4_1")
dbpf("$(COLL_MOTOR):scan1.D32PV", "IOCHDCOL:VMICADC1_2")
dbpf("$(COLL_MOTOR):scan1.D33PV", "IOCHDCOL:VMICADC2_2")
dbpf("$(COLL_MOTOR):scan1.D34PV", "IOCHDCOL:VMICADC3_2")
dbpf("$(COLL_MOTOR):scan1.D35PV", "IOCHDCOL:VMICADC4_2")
dbpf("$(COLL_MOTOR):scan1.D36PV", "ST:disc:scaler:1")
dbpf("$(COLL_MOTOR):scan1.D37PV", "ST:disc:scaler:2")
dbpf("$(COLL_MOTOR):scan1.D38PV", "ST:disc:scaler:3")
dbpf("$(COLL_MOTOR):scan1.D39PV", "ST:disc:scaler:4")
dbpf("$(COLL_MOTOR):scan1.D40PV", "ST:disc:scaler:5")
dbpf("$(COLL_MOTOR):scan1.D41PV", "ST:disc:scaler:6")
dbpf("$(COLL_MOTOR):scan1.D42PV", "ST:disc:scaler:7")
dbpf("$(COLL_MOTOR):scan1.D43PV", "ST:disc:scaler:8")
dbpf("$(COLL_MOTOR):scan1.D44PV", "ST:disc:scaler:9")
dbpf("$(COLL_MOTOR):scan1.D45PV", "ST:disc:scaler:10")
dbpf("$(COLL_MOTOR):scan1.D46PV", "ST:disc:scaler:11")
dbpf("$(COLL_MOTOR):scan1.D47PV", "ST:disc:scaler:12")
dbpf("$(COLL_MOTOR):scan1.D48PV", "ST:disc:scaler:13")
dbpf("$(COLL_MOTOR):scan1.D49PV", "ST:disc:scaler:14")
dbpf("$(COLL_MOTOR):scan1.D50PV", "ST:disc:scaler:15")
dbpf("$(COLL_MOTOR):scan1.D51PV", "ST:disc:scaler:16")
dbpf("$(COLL_MOTOR):scan1.D52PV", "ST:disc:scaler:17")
dbpf("$(COLL_MOTOR):scan1.D53PV", "ST:disc:scaler:18")
dbpf("$(COLL_MOTOR):scan1.D54PV", "ST:disc:scaler:19")
dbpf("$(COLL_MOTOR):scan1.D55PV", "ST:disc:scaler:20")
dbpf("$(COLL_MOTOR):scan1.D56PV", "ST:disc:scaler:21")
dbpf("$(COLL_MOTOR):scan1.D57PV", "ST:disc:scaler:22")
dbpf("$(COLL_MOTOR):scan1.D58PV", "ST:disc:scaler:23")
dbpf("$(COLL_MOTOR):scan1.D59PV", "ST:disc:scaler:24")
dbpf("$(COLL_MOTOR):scan1.D60PV", "ST:disc:scaler:25")
dbpf("$(COLL_MOTOR):scan1.D61PV", "ST:disc:scaler:26")
dbpf("$(COLL_MOTOR):scan1.D62PV", "ST:disc:scaler:27")
dbpf("$(COLL_MOTOR):scan1.D63PV", "ST:disc:scaler:28")
dbpf("$(COLL_MOTOR):scan1.D64PV", "ST:disc:scaler:29")
dbpf("$(COLL_MOTOR):scan1.D65PV", "ST:disc:scaler:30")
dbpf("$(COLL_MOTOR):scan1.D66PV", "US1-2-BOT:XPSAuxAi0")
dbpf("$(COLL_MOTOR):scan1.D67PV", "US1-2-BOT:XPSAuxAi2")
dbpf("$(COLL_MOTOR):scan1.D68PV", "US1-2-BOT:XPSAuxAi3")
dbpf("$(COLL_MOTOR):scan1.D69PV", "US1-2-BOT:XPSAuxAi3")

dbpf("$(COLL_MOTOR):scan1.T1PV", "$(COLL_MOTOR):beamCheckBusy")


#dbpf("$(COLL_MOTOR):scan1.P1SP", "-130.0")
#dbpf("$(COLL_MOTOR):scan1.P1EP",  "-90.0")
#dbpf("$(COLL_MOTOR):scan1.P1SI", "1.0")
#dbpf("$(COLL_MOTOR):scan1.PDLY", "1")
#dbpf("$(COLL_MOTOR):scan1.DDLY", "2.0")

#dbpf("$(COLL_MOTOR):saveData_fileSystem", "/gluex/data/CollimatorScans")
#dbpf("$(COLL_MOTOR):saveData_subDir", "sscanData")
#dbpf("$(COLL_MOTOR):saveData_baseName", "scan_")
#
