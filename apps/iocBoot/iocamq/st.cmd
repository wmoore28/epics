#!../../bin/linux-x86_64/amq

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/amq.dbd"
amq_registerRecordDeviceDriver pdbbase

#
ConnectMQ("tcp://clon00:61616","clasrun.clasprod.scalers.fadc")

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
