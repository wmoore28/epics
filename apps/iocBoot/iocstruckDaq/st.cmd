## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "$IOC_root_classc8"

< cdCommands
< ../network

cd topbin

## You may have to change struckDaq to something else
## everywhere it appears in this file
ld 0,0, "struckDaq.munch"



## Register all support components
cd top
dbLoadDatabase "dbd/struckDaq.dbd"
struckDaq_registerRecordDeviceDriver pdbbase

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "500000")

## Load record instances

dbLoadRecords("db/struckDaqCommon.db", "FIFO=4096, HALF_FIFO=2048")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=0")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=1")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=2")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=3")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=4")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=5")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=6")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=7")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=8")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=9")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=10")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=11")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=12")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=13")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=14")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=15")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=16")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=17")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=18")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=19")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=20")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=21")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=22")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=23")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=24")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=25")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=26")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=27")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=28")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=29")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=30")
dbLoadRecords("db/struckDaq.db", "FIFO=4096, HALF_FIFO=2048, CHAN=31")



# SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
devSTR7201Debug = 0
drvSTR7201Debug = 0
#ppc
STR7201Setup(1, 0x08000000, 221, 6)
STR7201Config(0,32,4096)
###


cd startup
iocInit

## Start any sequence programs
seq &struckDaq
