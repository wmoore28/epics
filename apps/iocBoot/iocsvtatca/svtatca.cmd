#!../../bin/linux-x86_64/tempSens
################################################################################
< envPaths
################################################################################
cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/tempSens.dbd")
tempSens_registerRecordDeviceDriver(pdbbase)

cd ${TOP}/iocBoot/${IOC}

dbLoadRecords("svtatca.db", "P=SVT:atca1:1:DPM0:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:DPM1:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:DPM2:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:DPM3:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:DTM:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:RTM:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:1:CEN:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:DPM0:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:DPM1:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:DPM2:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:DPM3:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:DTM:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:RTM:i_rd")
dbLoadRecords("svtatca.db", "P=SVT:atca1:2:CEN:i_rd")

iocInit

