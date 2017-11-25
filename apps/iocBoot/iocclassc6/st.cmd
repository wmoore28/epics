## iocclassc6 vxWorks startup file

## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
cd "$IOC_root_classc6"

< cdCommands
#< ../nfsCommands
< ../network
#< ../users

cd topbin

## You may have to change classc6 to something else
## everywhere it appears in this file
ld 0,0, "classc6.munch"
#ld < classc6.munch

## Register all support components
cd top
dbLoadDatabase "dbd/classc6.dbd"
classc6_registerRecordDeviceDriver pdbbase

epicsEnvSet( "EPICS_CA_ADDR_LIST", "129.57.255.12")

## Load IOC status records
dbLoadRecords("${DEVIOCSTATS}/db/iocAdminVxWorks.db","IOC=iocclassc6")

# Hovanes's addresses increment by 0x01000000
#
# 0x8000000 is SIS3820, 64 MB
# 0x9000000 is SIS3801

drvSIS3801Config("STRKBOM", 0x08000000, 220, 6, 16, 32)
#drvSIS3801Config("STRKHEL", 0x09000000, 220, 6, 32768, 32)
drvSIS3801Config("STRKHEL", 0x09000000, 220, 6, 144, 32)

#drvSIS3801Config("STRKHEL", 0x08000000, 220, 6, 32768, 32)
##drvSIS3820Config("STRKHEL", 0x08000000, 220, 6, 32768, 32, 0, 0)

#drvSIS3801Config("STRKBOM", 0x09000000, 220, 6, 16, 32)
##drvSIS3801Config("STRKBOM", 0x08001000, 220, 6, 16, 32)
##drvSIS3820Config("STRKBOM", 0x08001000, 220, 6, 16, 32, 0, 0)


# MOLLER:
dbLoadRecords("$(STD)/stdApp/Db/scaler32.db", "P=HEL_, S=SC, DTYP=Asyn Scaler, OUT=@asyn(STRKHEL), FREQ=25000000")
dbLoadRecords("$(MCA)/db/SIS38XX.template", "P=HEL_, SCALER=HEL_SC, PORT=STRKHEL")

# BOM:
dbLoadRecords("$(STD)/stdApp/Db/scaler32.db", "P=bom_, S=sc, DTYP=Asyn Scaler, OUT=@asyn(STRKBOM), FREQ=25000000")
dbLoadRecords("$(MCA)/db/SIS38XX.template", "P=bom_, SCALER=bom_sc, PORT=STRKBOM")

# 32768
#
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=0,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=3,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=5,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=6,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=7,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=8,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=9,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=10,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=11,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=16,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=20,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro.db","FIFO=144,CHAN=24,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=0,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=7,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=8,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=9,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=10,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=11,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=16,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=20,PORT=STRKHEL")
dbLoadRecords("db/asym_scaler_macro_sums.db","FIFO=144,CHAN=24,PORT=STRKHEL")

# MOLLER from classc1 in 7-14:
dbLoadRecords("db/moller_setup.db")
dbLoadRecords("db/asym_scaler_common.db")
dbLoadRecords("db/asym_fdbk.db")
dbLoadRecords("db/polarization.db")


# BOM from classc6 in 7-14:
dbLoadRecords("db/bom_scaler.db","scaler=bom_sc,PORT=STRKBOM,FIFO=16")
dbLoadRecords("db/bom_stop_start.db","scaler=bom_sc")
dbLoadRecords("db/bom_read_control.db","scaler=bom_sc")
#dbLoadRecords("db/bom_sum.db","scaler=bom_sc")

cd startup
iocInit


# BOM, copied from classc1 in hps:
dbpf "bom_Dwell", "1.0"
dbpf "bom_ReadAll.SCAN","Passive"
# Hovanes says this is only for new drvSIS3820 driver:
seq &SIS38XX_SNL, "P=bom_, R=sc_, NUM_SIGNALS=32, FIELD=READ"



#seq &SIS38XX_SNL, "P=HEL_, R=SC_, NUM_SIGNALS=32, FIELD=READ"

# MOLLER, from classc1 in 7-14:
#dbpf "moller_accumulate","1"
seq &asym
#seq &kepco_seq
#seq &quad_current
#seq &moller_setup

