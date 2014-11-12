## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "$IOC_root_classc8/iocBoot/iocclassc8"

< cdCommands_clon10
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change classc8 to something else
## everywhere it appears in this file
ld 0,0, "classc8.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/classc8.dbd"
classc8_registerRecordDeviceDriver pdbbase

## Load record instances
##dbLoadTemplate "db/user.substitutions"
##dbLoadRecords "db/dbSubExample.db", "user=levon"

## Set this to see messages from mySub
#mySubDebug = 1

## Run this to trace the stages of iocInit
#traceIocInit

#cd dbLoadRecords("db/motor.db","motor_name=hps, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")


dbLoadRecords("db/motor.db","motor_name=harp_2h00, card=0, slot=0, srev=2000, urev=5.08, direction=Pos, velo=2.5, accl=0.1")
dbLoadRecords("db/scan.db","motor_name=harp_2h00, start_at=1, end_at=40.0, start_speed=2.5, scan_speed=0.4, acq_time=1")


dbLoadRecords("db/motor.db","motor_name=harp_2c21, card=0, slot=1, srev=2000, urev=2.54, direction=Neg, velo=5.0, accl=0.1")
dbLoadRecords("db/scan.db","motor_name=harp_2c21, start_at=25, end_at=60.0, start_speed=5.0, scan_speed=0.5, acq_time=0.1")

dbLoadRecords("db/motor.db","motor_name=harp_tagger, card=0, slot=2, srev=2000, urev=2.54, direction=Neg, velo=0.5, accl=0.01")
dbLoadRecords("db/scan.db","motor_name=harp_tagger, start_at=18, end_at=58.0, start_speed=5.0, scan_speed=0.5, acq_time=0.07")

dbLoadRecords("db/motor.db","motor_name=collimator, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")

#dbLoadRecords("db/radiators.db")
#dbLoadRecords("db/convertors.db")
#dbLoadRecords("db/hps_collimators.db")



# Load IOC status records
dbLoadRecords("db/iocAdminVxWorks.db","IOC=classc8")
#dbLoadRecords("../support/devIocStats-3.1.12/db/iocAdminVxWorks.db","IOC=classc8")

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
omsSetup(2, 0x8000, 180, 5, 60)

cd startup
iocInit

## Start any sequence programs
#seq &sncExample, "user=levon"

seq &reset_motor, "name=up_2c21_reset, motor_name=harp_2c21"
seq &harp_scan_generic, "name=up_2c21_scan, motor_name=harp_2c21"

seq &reset_motor, "name=h_tagger_reset, motor_name=harp_tagger"
seq &harp_scan_generic, "name=h_tagger_scan, motor_name=harp_tagger"

seq &reset_motor, "name=harp_2h00_reset, motor_name=harp_2h00"
seq &harp_scan_generic, "name=harp_2h00_scan, motor_name=harp_2h00"

seq &reset_motor, "name=collimator_reset, motor_name=collimator"

