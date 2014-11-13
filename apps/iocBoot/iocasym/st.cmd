## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocasym"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change asym to something else
## everywhere it appears in this file
ld 0,0, "asym.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/asym.dbd"
asym_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/asym.substitutions"
dbLoadRecords "db/asym_scaler_common.db"

dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=0")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=3")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=5")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=6")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=7")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=8")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=9")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=10")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=11")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=16")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=20")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=24")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=0")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=7")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=8")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=9")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=10")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=11")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=16")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=20")
dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=24")



dbLoadRecords("db/asym_fdbk.db")
dbLoadRecords("db/polarization.db")


# SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
devSTR7201Debug = 0
drvSTR7201Debug = 0
#ppc
STR7201Setup(1, 0x08000000, 220, 6)
STR7201Config(0,32,32768,0)




cd startup
iocInit

## Start any sequence programs
#seq &sncxxx, "user=levon"

seq &asym

