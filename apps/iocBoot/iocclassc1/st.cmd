## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "$IOC_root_classc1/iocBoot/iocclassc1"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change classc1 to something else
## everywhere it appears in this file
ld 0,0, "classc1.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/classc1.dbd"
classc1_registerRecordDeviceDriver pdbbase

##epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "5000000")

## Load record instances
##dbLoadTemplate "db/user.substitutions"
##dbLoadRecords "db/dbSubExample.db", "user=levon"

dbLoadRecords("db/bom_scaler.db", "scaler=bom_sc,slot=0,FIFO=16")
dbLoadRecords("db/bom_stop_start.db", "scaler=bom_sc")
dbLoadRecords("db/bom_read_control.db", "scaler=bom_sc")
dbLoadRecords("db/bom_sum.db", "scaler=bom_sc")


##dbLoadRecords "db/asym_scaler_common.db"

##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=0")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=3")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=5")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=6")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=7")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=8")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=9")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=10")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=11")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=16")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=20")
##dbLoadRecords("db/asym_scaler_macro.db","FIFO=32768, CHAN=24")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=0")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=7")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=8")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=9")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=10")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=11")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=16")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=20")
##dbLoadRecords("db/asym_scaler_macro_sums.db","CHAN=24")

##dbLoadRecords("db/asym_fdbk.db")
##dbLoadRecords("db/polarization.db")

##dbLoadRecords("db/moller_setup.db")
##dbLoadRecords("db/moeller_target.db")


#cd dbLoadRecords("db/motor.db","motor_name=hps, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")


##dbLoadRecords("db/motor.db","motor_name=harp_2h00, card=0, slot=0, srev=2000, urev=5.08, direction=Pos, velo=2.5, accl=0.1")
##dbLoadRecords("db/scan.db","motor_name=harp_2h00, start_at=1, end_at=40.0, start_speed=2.5, scan_speed=0.4, acq_time=1")


dbLoadRecords("db/motor.db","motor_name=harp_2c21, card=0, slot=2, srev=2000, urev=2.54, direction=Neg, velo=5.0, accl=0.1")
dbLoadRecords("db/scan.db","motor_name=harp_2c21, start_at=25, end_at=60.0, start_speed=5.0, scan_speed=0.5, acq_time=0.1")

dbLoadRecords("db/motor.db","motor_name=harp_tagger, card=0, slot=1, srev=2000, urev=2.54, direction=Neg, velo=0.5, accl=0.01")
dbLoadRecords("db/scan.db","motor_name=harp_tagger, start_at=18, end_at=58.0, start_speed=5.0, scan_speed=0.5, acq_time=0.07")

##dbLoadRecords("db/motor.db","motor_name=collimator, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")

dbLoadRecords("db/radiators.db")
#dbLoadRecords("db/convertors.db")
#dbLoadRecords("db/hps_collimators.db")

dbLoadRecords("db/scaler_c.db")
dbLoadRecords("db/scaler_d.db")
dbLoadRecords("db/scaler_e.db")


# Load IOC status records
dbLoadRecords("db/iocAdminVxWorks.db","IOC=classc1")
#dbLoadRecords("../support/devIocStats-3.1.12/db/iocAdminVxWorks.db","IOC=classc1")



# SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
devSTR7201Debug = 0
drvSTR7201Debug = 0
#ppc
STR7201Setup(1, 0x08000000, 220, 6)
##STR7201Config(0,32,16,1,1)
STR7201Config(0,32,16,0,1)

#
# Scaler debug switches
#
recScalerdebug=0
devScalerdebug=0
# Joerger VSC setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
#mv162
#VSCSetup(2, 0x02000000, 200)
#ppc
VSCSetup(3, 0x0a000000, 200)
#
# OMS vme8/vme44 debug switches
#
recMotordebug = 0
devOMSdebug   = 0
drvOMSdebug   = 0
#
# OMS VME driver setup parameters: 
#     (1)cards, (2)axis per card, (3)base address(short, 16-byte boundary), 
#     (4)interrupt vector (0=disable or  64 - 255), (5)interrupt level (1 - 6),
#     (6)motor task polling rate (min=1Hz,max=60Hz)
omsSetup(2, 0x8000, 180, 5, 10)


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




## Set this to see messages from mySub
#mySubDebug = 1

## Run this to trace the stages of iocInit
#traceIocInit

cd startup
iocInit

# set some initial values:
##dbpf "fcup_offset","144.46"
##dbpf "fcup_slope","9071"
#dbpf "fcup_slope","9267"
##dbpf "moller_accumulate","1"
#dbpf "scaler.CNT","1"
#dbpf "scaler_d.CNT","1"
#dbpf "scaler_d_mode.VAL","1"
#dbpf "display_d_mode.VAL","1"

## Start any sequence programs
#seq &sncExample, "user=levon"

##seq &asym
#seq &moller_setup
#seq &moeller_target

seq &reset_motor, "name=up_2c21_reset, motor_name=harp_2c21"
seq &harp_scan_generic, "name=up_2c21_scan, motor_name=harp_2c21"

seq &reset_motor, "name=h_tagger_reset, motor_name=harp_tagger"
seq &harp_scan_generic, "name=h_tagger_scan, motor_name=harp_tagger"

##seq &reset_motor, "name=harp_2h00_reset, motor_name=harp_2h00"
##seq &harp_scan_generic, "name=harp_2h00_scan, motor_name=harp_2h00"

##seq &reset_motor, "name=collimator_reset, motor_name=collimator"

#seq &scaler_c_restart
#seq &scaler_d_restart
#seq &scaler_e_restart
