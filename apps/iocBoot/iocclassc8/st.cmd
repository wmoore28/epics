## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "$IOC_root_classc8"

< cdCommands
< ../network

cd topbin

## You may have to change classc8 to something else
## everywhere it appears in this file
ld 0,0, "classc8.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/classc8.dbd"
classc8_registerRecordDeviceDriver pdbbase

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "5000000")

# SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
devSTR7201Debug = 0
drvSTR7201Debug = 0
#ppc
##STR7201Setup(5, 0x08000000, 221, 6)
##STR7201Config(0,32,4096)
##STR7201Config(0,32,4096)
##STR7201Config(4,32,16)
##STR7201Config(4,32,16)
###

STR7201Setup(1, 0x08000000, 221, 6)
STR7201Config(0,32,4096,1,1)
#STR7201Config(1,32,16,1,1)




# Load IOC status records
#dbLoadRecords("db/iocAdminVxWorks.db","IOC=classc8")
#dbLoadRecords("../support/devIocStats-3.1.12/db/iocAdminVxWorks.db","IOC=classc8")

#
cd startup
iocInit

## Start any sequence programs

#seq &sixtyHz
