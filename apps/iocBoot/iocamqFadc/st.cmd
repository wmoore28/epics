#!../../bin/linux-x86_64/amq

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/amq.dbd"
amq_registerRecordDeviceDriver pdbbase

ConnectMQ("tcp://clon00:61616","clasrun.clasprod.scalers.fadc")

dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl03:c,K=HPS1_FADC250SLOT3,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl04:c,K=HPS1_FADC250SLOT4,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl05:c,K=HPS1_FADC250SLOT5,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl06:c,K=HPS1_FADC250SLOT6,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl07:c,K=HPS1_FADC250SLOT7,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl08:c,K=HPS1_FADC250SLOT8,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl09:c,K=HPS1_FADC250SLOT9,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl10:c,K=HPS1_FADC250SLOT10,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl14:c,K=HPS1_FADC250SLOT14,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl15:c,K=HPS1_FADC250SLOT15,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl16:c,K=HPS1_FADC250SLOT16,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl17:c,K=HPS1_FADC250SLOT17,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl18:c,K=HPS1_FADC250SLOT18,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl19:c,K=HPS1_FADC250SLOT19,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS1_FADC_Sl20:c,K=HPS1_FADC250SLOT20,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")

dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl03:c,K=HPS2_FADC250SLOT3,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl04:c,K=HPS2_FADC250SLOT4,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl05:c,K=HPS2_FADC250SLOT5,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl06:c,K=HPS2_FADC250SLOT6,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl07:c,K=HPS2_FADC250SLOT7,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl08:c,K=HPS2_FADC250SLOT8,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl09:c,K=HPS2_FADC250SLOT9,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl10:c,K=HPS2_FADC250SLOT10,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl14:c,K=HPS2_FADC250SLOT14,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl15:c,K=HPS2_FADC250SLOT15,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl16:c,K=HPS2_FADC250SLOT16,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl17:c,K=HPS2_FADC250SLOT17,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl18:c,K=HPS2_FADC250SLOT18,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl19:c,K=HPS2_FADC250SLOT19,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS2_FADC_Sl20:c,K=HPS2_FADC250SLOT20,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")

dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl03_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl03:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl04_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl04:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl05_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl05:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl06_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl06:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl07_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl07:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl08_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl08:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl09_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl09:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl10_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl10:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl14_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl14:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl15_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl15:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl16_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl16:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl17_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl17:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl18_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl18:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl19_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl19:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS1_FADC_,R=Sl20_Ch,S=:c,INP=B_HW_HPS1_FADC_Sl20:c")

dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl03_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl03:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl04_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl04:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl05_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl05:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl06_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl06:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl07_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl07:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl08_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl08:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl09_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl09:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl10_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl10:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl14_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl14:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl15_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl15:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl16_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl16:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl17_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl17:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl18_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl18:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl19_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl19:c")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS2_FADC_,R=Sl20_Ch,S=:c,INP=B_HW_HPS2_FADC_Sl20:c")

dbLoadRecords("db/hps-hodo-fadc-aliases.db")
#dbLoadRecords("db/hps-ecal-fadc-aliases.db")

cd ${TOP}/iocBoot/${IOC}

iocInit

#Need this to start responding to messages after all records are defined
StartMQ()

dbl > pv.list
