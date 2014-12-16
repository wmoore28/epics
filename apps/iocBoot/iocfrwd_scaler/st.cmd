## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocfrwd_scaler"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change frwd_scaler to something else
## everywhere it appears in this file
ld 0,0, "frwd_scaler.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/frwd_scaler.dbd"
frwd_scaler_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/frwd_scaler.substitutions"
dbLoadRecords "db/frwd_scaler.db"

recScalerdebug=0
devScalerdebug=0
# Joerger VSC setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
VSCSetup(2, 0x02000000, 200)
#VSCSetup(2, 0x0a000000, 200)

cd startup
iocInit

## Start any sequence programs
#seq &sncxxx, "user=levon"

#seq &frwd_scaler_restart
