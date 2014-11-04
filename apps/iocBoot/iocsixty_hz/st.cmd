## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocsixty_hz"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change sixty_hz to something else
## everywhere it appears in this file
ld 0,0, "sixty_hz.munch"



## Register all support components
cd top
dbLoadDatabase "dbd/sixty_hz.dbd"
sixty_hz_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/sixty_hz.substitutions"
#dbLoadRecords "db/sixty_hz.db"

dbLoadRecords("db/sixty_hz_common.db", "FIFO=4096, HALF_FIFO=2048")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=0")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=1")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=2")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=3")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=4")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=5")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=6")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=7")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=8")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=9")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=10")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=11")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=12")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=13")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=14")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=15")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=16")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=17")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=18")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=19")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=20")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=21")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=22")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=23")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=24")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=25")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=26")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=27")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=28")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=29")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=30")
dbLoadRecords("db/sixty_hz_macro.db", "FIFO=4096, HALF_FIFO=2048, CHAN=31")




# SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
devSTR7201Debug = 0
drvSTR7201Debug = 0
#ppc
STR7201Setup(5, 0x08000000, 221, 6)
STR7201Config(0,32,4096)
STR7201Config(4,32,16)
###


cd startup
iocInit

## Start any sequence programs
#seq &sncxxx, "user=levon"
#seq &sixtyHz
seq &sixtyHz
