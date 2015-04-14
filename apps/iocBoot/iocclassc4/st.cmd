## classc4 vxWorks startup file

cd "$IOC_root_classc4"

< cdCommands
< ../network

cd topbin

## You may have to change classc4 to something else
## everywhere it appears in this file
ld 0,0, "classc4.munch"

## Register all support components
cd top
dbLoadDatabase "dbd/classc4.dbd"
classc4_registerRecordDeviceDriver pdbbase

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "5000000")
epicsEnvSet( "EPICS_CA_ADDR_LIST", "129.57.255.4")

## Load record instances
dbLoadRecords("db/scaler.db")
dbLoadRecords("db/frwd_scaler.db")
dbLoadRecords("db/stopper.db")
##dbLoadRecords("db/fcup_gain.db")

##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=0")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=1")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=2")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=3")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=4")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=5")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=6")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=7")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=8")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=9")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=10")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=11")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=12")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=13")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=14")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=15")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=16")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=17")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=18")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=19")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=20")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=21")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=22")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=23")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=24")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=25")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=26")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=27")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=28")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=29")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=30")
##dbLoadRecords("db/svt_scan_scaler_macro.db","FIFO=200, CHAN=31")

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
  
#dbLoadRecords("db/motor.db","motor_name=hps, card=0, slot=3, srev=2000, urev=0.2, direction=Pos, velo=0.2, accl=0.5")

dbLoadRecords("db/motor.db","motor_name=beam_stop, card=0, slot=0, srev=2000, urev=5.08, direction=Pos, velo=2.5, accl=0.1")

dbLoadRecords("db/motor.db","motor_name=harp_2H02A, card=0, slot=2, srev=2000, urev=2.54, direction=Pos, velo=0.5, accl=0.01")
dbLoadRecords("db/scan.db","motor_name=harp_2H02A, start_at=3.0, end_at=9.5, start_speed=0.5, scan_speed=0.04, acq_time=0.1")

dbLoadRecords("db/motor.db","motor_name=viewer, card=0, slot=1,srev=2000,urev=2.54,direction=Neg,velo=0.03,accl=0.01")
##dbLoadRecords("db/motor.db","motor_name=hps_target, card=0, slot=1,srev=2000,urev=2.54,direction=Neg,velo=0.5,accl=0.01")


dbLoadRecords("db/motor.db","motor_name=hps_collimator,card=0,slot=3,srev=2000,urev=0.2,direction=Pos,velo=0.2,accl=0.5")
dbLoadRecords("db/scan.db","motor_name=hps_collimator,start_at=4.22,end_at=4.82,start_speed=0.2,scan_speed=0.02,acq_time=0.07")

#dbLoadRecords("db/radiators.db")
dbLoadRecords("db/viewer.db")
dbLoadRecords("db/hps_collimators.db")
#$dbLoadRecords("db/hps_target.db")


# Load IOC status records
dbLoadRecords("db/iocAdminVxWorks.db","IOC=classc4")
#dbLoadRecords("db/save_restoreStatus.db", "P=classc4:")

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

STR7201Setup(2, 0x08000000, 221, 6)
STR7201Config(0,32,4096,1,1)
STR7201Config(1,32,16,1,1)

##recScalerdebug=0
##devScalerdebug=0
# Joerger VSC setup parameters:
#     (1)cards, (2)base address(ext, 256-byte boundary),
#     (3)interrupt vector (0=disable or  64 - 255)
#mv162
##VSCSetup(2, 0x02000100, 200)
VSCSetup(2, 0x0a000000, 200)
#ppc
##VSCSetup(2, 0x0a000000, 200)

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
#omsSetup(int num_cards,  /* maximum number of cards in rack */
#         void *addrs,    /* Base Address(0x0-0xb000 on 4K boundary) */
#         unsigned vector,/* noninterrupting(0), valid vectors(64-255) */
#         int int_level,  /* interrupt level (1-6) */
#         int scan_rate)  /* polling rate - 1-60 Hz */
omsSetup(2, 0x8000, 180, 5, 10)


cd startup
#< save_restore.cmd
iocInit "../resource.def"

## Autosave startup (issues rewriting existing files)
#iocshCmd("makeAutosaveFiles()")
#create_monitor_set("info_positions.req", 5, "P=classc4:")
#create_monitor_set("info_settings.req", 30, "P=classc4:")
#create_monitor_set("sixty_hz_settings.req", 30)

##dbpf "fcup_offset","144.46"
##dbpf "fcup_slope","9071"
##dbpf "fcup_offset","63.08"
dbpf "fcup_offset","74."
dbpf "fcup_slope","905.937"


## Start any sequence programs
#seq &sncExample, "user=levon"
seq &reset_motor, "name=beam_stop_reset, motor_name=beam_stop"

seq &reset_motor, "name=harp_2H02A_reset, motor_name=harp_2H02A"
seq &harp_scan_generic, "name=harp_2H02A_scan, motor_name=harp_2H02A"

seq &reset_motor, "name=viewer_reset, motor_name=viewer"
##seq &reset_motor, "name=hps_target_reset, motor_name=hps_target"

seq &reset_motor, "name=hps_collimator_reset, motor_name=hps_collimator"
seq &harp_scan_generic, "name=hps_collimator_scan, motor_name=hps_collimator"

seq &sixtyHz
#seq &frwd_scaler_restart
#seq &scaler_restart

