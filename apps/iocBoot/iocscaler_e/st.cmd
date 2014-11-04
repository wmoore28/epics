## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocscaler_e"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change scaler_e to something else
## everywhere it appears in this file
ld 0,0, "scaler_e.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/scaler_e.dbd"
scaler_e_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/scaler_e.substitutions"
#dbLoadRecords "db/scaler_e.db"

recScalerdebug=0
devScalerdebug=0
# Joerger VSC setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
#mv162
#VSCSetup(2, 0x02000000, 200)
#ppc
VSCSetup(3, 0x0a000000, 200)

cd startup
iocInit

## Start any sequence programs
#seq &sncxxx, "user=levon"

#seq &scaler_e_restart

