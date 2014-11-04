## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocscaler"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change scaler to something else
## everywhere it appears in this file
ld 0,0, "scaler.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/scaler.dbd"
scaler_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadTemplate "db/scaler.substitutions"
#dbLoadRecords "db/scaler.db"

#recScalerdebug=0
#devScalerdebug=0
devScaler_VSDebug=0
devScalerDebug=0
# Joerger VSC setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
#mv162
#VSCSetup(2, 0x02000000, 200)
#ppc
VSCSetup(1, 0x0a000000, 200)

#/*****************************************************
#* VSCSetup()
#* User (startup file) calls this function to configure
#* us for the hardware.
#*****************************************************/
#void VSCSetup(int num_cards,    /* maximum number of cards in crate */
#           void *addrs,         /* Base Address(0x100-0xffffff00, 256-byte boundary) */
#           unsigned vector)     /* noninterrupting(0), valid vectors(64-255) */




#VSCscaler_debug(int card, int numReads, int waitLoops)
#VSCscaler_debug(0, 1, 0)

cd startup
iocInit


## Start any sequence programs
#seq &sncxxx, "user=levon"

#seq &scaler_restart

