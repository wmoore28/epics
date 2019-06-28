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

dbLoadRecords("db/amqFloatArray.db", "P=B_DAQ:STA:hps1,K=STA:hps1,N=4,TH=20,THH=60,HSV=MINOR,HHSV=NO_ALARM")
dbLoadRecords("db/amqFloatArray.db", "P=B_DAQ:STA:hps2,K=STA:hps2,N=4,TH=20,THH=60,HSV=MINOR,HHSV=NO_ALARM")
dbLoadRecords("db/amqRocsRate.db",   "R=hps1,DESC=hps1")
dbLoadRecords("db/amqRocsRate.db",   "R=hps2,DESC=hps2")

dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:VTP:prescale:,INP=B_DAQ_HPS:VTP:prescale")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:VTP:rate:,INP=B_DAQ_HPS:VTP:rate")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:TSGTP:rate:,INP=B_DAQ_HPS:TSGTP:rate")
dbLoadRecords("db/array-to-scalar-32.template","P=B_DAQ_HPS:TSFP:rate:,INP=B_DAQ_HPS:TSFP:rate")

dbLoadTemplate("db/hps-trigger-fractions.substitutions")

cd ${TOP}/iocBoot/${IOC}

iocInit

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
