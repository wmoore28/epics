TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#LIBRARY_IOC_DEFAULT += -nil-
LIBRARY_IOC_vxWorks += harp_genericSupport
# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd
DBD += harp_genericSupport.dbd
harp_genericSupport_DBD += base.dbd
harp_genericSupport_DBD += asyn.dbd
#harp_genericSupport_DBD += drvAsynIPPort.dbd
harp_genericSupport_DBD += stdSupport.dbd
harp_genericSupport_DBD += calcSupport.dbd
harp_genericSupport_DBD += busySupport.dbd 
harp_genericSupport_DBD += sscanSupport.dbd 
harp_genericSupport_DBD += asSupport.dbd
#harp_genericSupport_DBD += devSequencer.dbd
#harp_genericSupport_DBD += stream.dbd
#harp_genericSupport_DBD += streamSynApps.dbd
harp_genericSupport_DBD += std.dbd

harp_genericSupport_DBD += MiscVx.dbd

harp_genericSupport_DBD += motorSupport.dbd
#harp_genericSupport_DBD += devAcsMotor.dbd
#harp_genericSupport_DBD += devImsMotor.dbd
#harp_genericSupport_DBD += devMclennanMotor.dbd
#harp_genericSupport_DBD += devMicos.dbd
#harp_genericSupport_DBD += devMicroMo.dbd
#harp_genericSupport_DBD += devNewport.dbd
#harp_genericSupport_DBD += devPIMotor.dbd   
harp_genericSupport_DBD += devOms.dbd
#harp_genericSupport_DBD += devSoftMotor.dbd
#harp_genericSupport_DBD += motorSimSupport.dbd
#harp_genericSupport_DBD += devSmartMotorMotor.dbd
#harp_genericSupport_DBD += devKohzuMotor.dbd
#harp_genericSupport_DBD += devAttocube.dbd
#harp_genericSupport_DBD += devAerotech.dbd
#harp_genericSupport_DBD += drvAsynSerialPort.dbd

harp_genericSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


#=============================
# Build the IOC application

#PROD_IOC_DEFAULT = -nil-
PROD_IOC_vxWorks = harp_generic
# harp_generic.dbd will be created and installed
DBD += harp_generic.dbd

# harp_generic.dbd will be made up from these files:
harp_generic_DBD += harp_genericSupport.dbd

# harp_generic_registerRecordDeviceDriver.cpp derives from harp_generic.dbd

# Build the main IOC entry point on workstation OSs.
harp_generic_SRCS_DEFAULT += harp_genericMain.cpp
#harp_generic_SRCS_vxWorks += -nil-
harp_generic_SRCS_vxWorks += harp_generic_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
harp_generic_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
harp_generic_LIBS += harp_genericSupport

#harp_generic_LIBS += asyn
harp_generic_LIBS += mca
harp_generic_LIBS += calc
harp_generic_LIBS += busy
harp_generic_LIBS += sscan
harp_generic_LIBS += autosave
harp_generic_LIBS += std
#harp_generic_LIBS += stream streamSynApps
harp_generic_LIBS += asyn
harp_generic_LIBS += seq pv 
#harp_generic_LIBS += Aerotech
#harp_generic_LIBS += Attocube
harp_generic_LIBS += oms
#harp_generic_LIBS += Mclennan
#harp_generic_LIBS += Micos
#harp_generic_LIBS += MicroMo
#harp_generic_LIBS += PI
#harp_generic_LIBS += Acs
#harp_generic_LIBS += Ims
#harp_generic_LIBS += Newport
#harp_generic_LIBS += softMotor
#harp_generic_LIBS += motorSimSupport
#harp_generic_LIBS += SmartMotor
#harp_generic_LIBS += KohzuMotor
harp_generic_LIBS += motor

ifdef IPAC
harp_generic_LIBS += Ipac TyGSOctal
endif

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into harp_genericSupport
#    harp_scan_generic_SNCFLAGS += +r    
#    reset_motor_SNCFLAGS += +r
    harp_genericSupport_DBD += harp_genericSNC.dbd
    harp_genericSupport_SRCS += harp_scan_generic.st
    harp_genericSupport_SRCS += reset_motor.st
    harp_generic_SRCS += harp_scan_generic.st
    harp_generic_SRCS += reset_motor.st
    harp_genericSupport_LIBS += seq pv

#    harp_generic_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
#    #PROD_HOST_DEFAULT += -nil-
#    PROD_HOST += harp_genericProgram
#    harp_genericProgram_SNCFLAGS += +m
#    harp_genericProgram_SRCS += harp_scan_generic.st
#    harp_genericProgram_SRCS += reset_motor.st
#    harp_genericProgram_LIBS += seq pv
#    harp_genericProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

#    harp_generic_SNCFLAGS += +m
#    harp_generic_SRCS_vxWorks += harp_scan_generic.st
#    harp_generic_SRCS_vxWorks += reset_motor.st
#    harp_generic_LIBS += seq pv
#    harp_generic_LIBS += $(EPICS_BASE_HOST_LIBS)

endif

# Finally link to the EPICS Base libraries
harp_generic_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

