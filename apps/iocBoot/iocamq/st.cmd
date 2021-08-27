#!../../bin/linux-x86_64/amq

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/amq.dbd"
amq_registerRecordDeviceDriver pdbbase

ConnectMQ("tcp://clon00:61616","clasrun.clasprod.daq.HallB_DAQ")

## Load record instances

#The RAWMESG key means don't parse for JSON, but writes the whole message into
#a waveform PV up to NELM characters. TYPE must be CHAR.
#Eg. dbLoadRecords("db/amqStringArray.db","P=B,K=RAWMSG,N=200")

#Now PVs pulling from json objects
#There are 4 types:
#1 Int
#2 Double
#3 Array of Ints
#4 Array of Doubles
#5 String

#Types 1 and 2 for into aiRecords
#Types 3,4,5 go into waveformRecords (with FTVL=DBR_LONG, DBR_DOUBLE, DBR_CHAR respectively) 

#The required macros are:
#P = Prefix
#K = json key
#N = No of elements in the array, if required

#dbLoadRecords("db/amqStringArray.db","P=B_DAQ:RAWMSG,K=RAWMSG,N=1000,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")

dbLoadRecords("db/amqIntArray.db",   "P=B_DAQ_HPS:VTP:prescale,K=hps1vtp_VTPHPS_PRESCALES,N=32,TH=10,THH=30,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqDoubleArray.db","P=B_DAQ_HPS:VTP:rate,K=hps1vtp_VTPHPS_TRIGGERBITS,N=32,TH=10,THH=30,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqDoubleArray.db","P=B_DAQ_HPS:TSGTP:rate,K=HPS11_TSGTPSLOT21,N=32,TH=10,THH=30,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqDoubleArray.db","P=B_DAQ_HPS:TSFP:rate,K=HPS11_TSFPSLOT21,N=32,TH=10,THH=30,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqDouble.db",     "P=B_DAQ_HPS:TS:livetime,K=HPS11_TSLIVETIMESLOT21,TH=10,THH=30,HSV=NO_ALARM,HHSV=NO_ALARM")

dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot03,K=hps1vtp_VTP_SERDES_SLOT3,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot04,K=hps1vtp_VTP_SERDES_SLOT4,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot05,K=hps1vtp_VTP_SERDES_SLOT5,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot06,K=hps1vtp_VTP_SERDES_SLOT6,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot07,K=hps1vtp_VTP_SERDES_SLOT7,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot08,K=hps1vtp_VTP_SERDES_SLOT8,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot09,K=hps1vtp_VTP_SERDES_SLOT9,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot10,K=hps1vtp_VTP_SERDES_SLOT10,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot14,K=hps1vtp_VTP_SERDES_SLOT14,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot15,K=hps1vtp_VTP_SERDES_SLOT15,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot16,K=hps1vtp_VTP_SERDES_SLOT16,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot17,K=hps1vtp_VTP_SERDES_SLOT17,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot18,K=hps1vtp_VTP_SERDES_SLOT18,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot19,K=hps1vtp_VTP_SERDES_SLOT19,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS1:serdes:slot20,K=hps1vtp_VTP_SERDES_SLOT20,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")

dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot03:,INP=B_DAQ_HPS:HPS1:serdes:slot03")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot04:,INP=B_DAQ_HPS:HPS1:serdes:slot04")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot05:,INP=B_DAQ_HPS:HPS1:serdes:slot05")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot06:,INP=B_DAQ_HPS:HPS1:serdes:slot06")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot07:,INP=B_DAQ_HPS:HPS1:serdes:slot07")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot08:,INP=B_DAQ_HPS:HPS1:serdes:slot08")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot09:,INP=B_DAQ_HPS:HPS1:serdes:slot09")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot10:,INP=B_DAQ_HPS:HPS1:serdes:slot10")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot14:,INP=B_DAQ_HPS:HPS1:serdes:slot14")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot15:,INP=B_DAQ_HPS:HPS1:serdes:slot15")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot16:,INP=B_DAQ_HPS:HPS1:serdes:slot16")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot17:,INP=B_DAQ_HPS:HPS1:serdes:slot17")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot18:,INP=B_DAQ_HPS:HPS1:serdes:slot18")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot19:,INP=B_DAQ_HPS:HPS1:serdes:slot19")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS1:serdes:slot20:,INP=B_DAQ_HPS:HPS1:serdes:slot20")

dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot03,K=hps2vtp_VTP_SERDES_SLOT3,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot04,K=hps2vtp_VTP_SERDES_SLOT4,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot05,K=hps2vtp_VTP_SERDES_SLOT5,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot06,K=hps2vtp_VTP_SERDES_SLOT6,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot07,K=hps2vtp_VTP_SERDES_SLOT7,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot08,K=hps2vtp_VTP_SERDES_SLOT8,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot09,K=hps2vtp_VTP_SERDES_SLOT9,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot10,K=hps2vtp_VTP_SERDES_SLOT10,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot14,K=hps2vtp_VTP_SERDES_SLOT14,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot15,K=hps2vtp_VTP_SERDES_SLOT15,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot16,K=hps2vtp_VTP_SERDES_SLOT16,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot17,K=hps2vtp_VTP_SERDES_SLOT17,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot18,K=hps2vtp_VTP_SERDES_SLOT18,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot19,K=hps2vtp_VTP_SERDES_SLOT19,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")
dbLoadRecords("db/amqIntArray.db"    "P=B_DAQ_HPS:HPS2:serdes:slot20,K=hps2vtp_VTP_SERDES_SLOT20,N=10,TH=0,THH=0,HSV=NO_ALARM,HHSV=NO_ALARM")

dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot03:,INP=B_DAQ_HPS:HPS2:serdes:slot03")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot04:,INP=B_DAQ_HPS:HPS2:serdes:slot04")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot05:,INP=B_DAQ_HPS:HPS2:serdes:slot05")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot06:,INP=B_DAQ_HPS:HPS2:serdes:slot06")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot07:,INP=B_DAQ_HPS:HPS2:serdes:slot07")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot08:,INP=B_DAQ_HPS:HPS2:serdes:slot08")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot09:,INP=B_DAQ_HPS:HPS2:serdes:slot09")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot10:,INP=B_DAQ_HPS:HPS2:serdes:slot10")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot14:,INP=B_DAQ_HPS:HPS2:serdes:slot14")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot15:,INP=B_DAQ_HPS:HPS2:serdes:slot15")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot16:,INP=B_DAQ_HPS:HPS2:serdes:slot16")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot17:,INP=B_DAQ_HPS:HPS2:serdes:slot17")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot18:,INP=B_DAQ_HPS:HPS2:serdes:slot18")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot19:,INP=B_DAQ_HPS:HPS2:serdes:slot19")
dbLoadRecords("db/array-serdes-latency.template","P=B_DAQ_HPS:,R=HPS2:serdes:slot20:,INP=B_DAQ_HPS:HPS2:serdes:slot20")

dbLoadRecords("db/amqFloatArray.db", "P=B_DAQ:STA:hps1,K=STA:hps1,N=4,TH=20,THH=60,HSV=MINOR,HHSV=NO_ALARM")
dbLoadRecords("db/amqFloatArray.db", "P=B_DAQ:STA:hps2,K=STA:hps2,N=4,TH=20,THH=60,HSV=MINOR,HHSV=NO_ALARM")
dbLoadRecords("db/amqRocsRate.db",   "R=hps1,DESC=hps1")
dbLoadRecords("db/amqRocsRate.db",   "R=hps2,DESC=hps2")

dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:VTP:prescale:,INP=B_DAQ_HPS:VTP:prescale")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:VTP:rate:,INP=B_DAQ_HPS:VTP:rate")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:TSGTP:rate:,INP=B_DAQ_HPS:TSGTP:rate")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:TSFP:rate:,INP=B_DAQ_HPS:TSFP:rate")

dbLoadTemplate("db/hps-trigger-fractions.substitutions")

dbLoadRecords("db/amqDoubleArray.db","P=B_HW_HPS11_DSC2_Slot6:c,K=HPS11_DSC2SLOT6_TDC_UNGATED,N=16,TH=0,THH=30,HSV=NO_ALARM,HHSV=MAJOR")
dbLoadRecords("db/array-to-scalar-16.template","P=B_HW_HPS11_DSC2_Slot6:,INP=B_HW_HPS11_DSC2_Slot6:c")

cd ${TOP}/iocBoot/${IOC}

dbLoadRecords("hps-neutron.alias")

< save_restore.cmd

iocInit

makeAutosaveFiles()
create_monitor_set("info_positions.req", 5, "P=${IOC}")
create_monitor_set("info_settings.req", 30, "P=${IOC}")

epicsEnvSet("PREFIX","B_DAQ_HPS:VTP:prescale:")
< trigbit-descriptions.cmd
epicsEnvSet("PREFIX","B_DAQ_HPS:VTP:rate:")
< trigbit-descriptions.cmd
epicsEnvSet("PREFIX","B_DAQ_HPS:TSGTP:rate:")
< trigbit-descriptions.cmd
dbpf("B_DAQ_HPS:TSFP:rate:15.DESC","Faraday Cup")
dbpf("B_DAQ_HPS:TSFP:rate:01.DESC","N/A")

#Need this to start responding to messages after all records are defined
StartMQ()

dbl > pv.list
