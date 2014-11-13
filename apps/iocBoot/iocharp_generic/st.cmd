## Example vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "/home/levon/controls/R3.14.12.3/apps/iocBoot/iocharp_generic"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change harp_generic to something else
## everywhere it appears in this file
ld 0,0, "harp_generic.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/harp_generic.dbd"
harp_generic_registerRecordDeviceDriver pdbbase


#
#
# OMS stepper motor driver
#
recMotordebug = 11
devOMSdebug   = 11
drvOMSdebug   = 11
#
# OMS VME driver setup parameters: 
#     (1)cards, (2)base address(short, 16-byte boundary), 
#     (3)interrupt vector (0=disable or  64 - 255), (4)interrupt level (1 - 6),
#     (5)motor task polling rate (min=1Hz,max=60Hz)
omsSetup(2, 0x8000, 180, 5, 60)
#omsSetup(1, 0x2000, 180, 5, 10)

## Load record instances
#cd "${TOP}/iocBoot/${IOC}"
#dbLoadTemplate "db/omsMotor.substitutions"
#dbLoadRecords "db/omsMotor.db", "user=hovanes"

#cd dbLoadRecords("db/motor.db","motor_name=hps, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")


dbLoadRecords("db/motor.db","motor_name=harp_2h00, card=0, slot=0, srev=2000, urev=5.08, direction=Pos, velo=2.5, accl=0.1")
dbLoadRecords("db/scan.db","motor_name=harp_2h00, start_at=1, end_at=40.0, start_speed=2.5, scan_speed=0.4, acq_time=1")


dbLoadRecords("db/motor.db","motor_name=harp_2c21, card=0, slot=1, srev=2000, urev=2.54, direction=Neg, velo=5.0, accl=0.1")
dbLoadRecords("db/scan.db","motor_name=harp_2c21, start_at=25, end_at=60.0, start_speed=5.0, scan_speed=0.5, acq_time=0.1")

dbLoadRecords("db/motor.db","motor_name=harp_tagger, card=0, slot=2, srev=2000, urev=2.54, direction=Neg, velo=0.5, accl=0.01")
dbLoadRecords("db/scan.db","motor_name=harp_tagger, start_at=18, end_at=58.0, start_speed=5.0, scan_speed=0.5, acq_time=0.07")

dbLoadRecords("db/motor.db","motor_name=collimator, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")

dbLoadRecords("db/radiators.db")
dbLoadRecords("db/convertors.db")
dbLoadRecords("db/collimators.db")


## Load record instances
#dbLoadTemplate "db/harp_generic.substitutions"
#dbLoadRecords "db/harp_generic.db", "user=levon"

cd startup
iocInit


seq &reset_motor, "name=up_2c21_reset, motor_name=harp_2c21"
seq &harp_scan_generic, "name=up_2c21_scan, motor_name=harp_2c21"

seq &reset_motor, "name=h_tagger_reset, motor_name=harp_tagger"
seq &harp_scan_generic, "name=h_tagger_scan, motor_name=harp_tagger"

seq &reset_motor, "name=harp_2h00_reset, motor_name=harp_2h00"
seq &harp_scan_generic, "name=harp_2h00_scan, motor_name=harp_2h00"

seq &reset_motor, "name=collimator_reset, motor_name=collimator"
