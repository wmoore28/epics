##
## The following is needed if your board support package doesn't at boot time
## automatically cd to the directory containing its startup script
##
cd "$IOC_root_classc2"

############################################################################
< cdCommands
############################################################################
< ../network
############################################################################
cd topbin
ld < classc2.munch
cd top

## Register all support components
dbLoadDatabase("dbd/classc2.dbd")
classc2_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "EPICS_CA_ADDR_LIST", "129.57.255.4")

#################################################################
### FROM CLASSC4:
### Struck Scalers 
##drvSIS3801Config("Port name",
##                  baseAddress,
##                  interruptVector,
##                  int interruptLevel,
##                  channels,
##                  signals)
##drvSIS3801Config("SIS38XX_0", 0x08000000, 221, 6, 4096, 32)
#################################################################

#################################################################
### FROM CLASSC2:
## Setup Struck scalers
##
## SIS 8201/7201 scaler (STRUCK scaler) setup parameters:
##     (1)cards, (2)base address(ext, 256-byte boundary),
##     (3)interrupt vector (0=disable or  64 - 255)
#devSTR7201Debug = 0
#drvSTR7201Debug = 0
##ppc
#STR7201Setup(14, 0x08000000, 220, 6)
##
##STR7201Config(0,32,512,0)
##STR7201Config(1,32,512,0)
#STR7201Config(2,32,512,0)
##STR7201Config(3,32,512,0)
##STR7201Config(4,32,512,0)
##STR7201Config(5,32,512,0)
#STR7201Config(6,32,512,0)
#STR7201Config(7,32,512,0)
#STR7201Config(8,32,512,0)
######STR7201Config(9,32,512,0)
######STR7201Config(10,32,512,0)
######STR7201Config(11,32,512,0)
##STR7201Config(12,32,1,0)
#STR7201Config(13,32,1,0)
#################################################################


dbLoadRecords("t_scaler.db")
dbLoadRecords("t_stop_start.db")
dbLoadRecords("t_read_control.db")


## IOC monitoring, etc
dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminVxWorks.db", "IOC=iocclassc2")

cd startup

iocInit "../resource.def"


## 
## Start any sequence programs
## 

#seq &t_scalers

