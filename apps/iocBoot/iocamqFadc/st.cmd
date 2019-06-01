#!../../bin/linux-x86_64/amq

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/amq.dbd"
amq_registerRecordDeviceDriver pdbbase

ConnectMQ("tcp://clon00:61616","clasrun.clasprod.scalers.fadc")

dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl10:c,K=HPS1_FADC250SLOT10,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl10:c,K=HPS2_FADC250SLOT10,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl10_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl10:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl10_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl10:c")
dbLoadRecords("db/hps-hodo-fadc-aliases.db")

cd ${TOP}/iocBoot/${IOC}

iocInit

#Need this to start responding to messages after all records are defined
StartMQ()

dbl > pv.list
