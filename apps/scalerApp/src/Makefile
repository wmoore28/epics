TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#LIBRARY_IOC_DEFAULT += -nil-
LIBRARY_IOC_vxWorks += scalerSupport
# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd
DBD += scalerSupport.dbd
scalerSupport_DBD += base.dbd
scalerSupport_DBD += asyn.dbd

#scalerSupport_DBD += drvAsynIPPort.dbd
scalerSupport_DBD += stdSupport.dbd
scalerSupport_DBD += calcSupport.dbd
scalerSupport_DBD += busySupport.dbd 
scalerSupport_DBD += sscanSupport.dbd 
scalerSupport_DBD += asSupport.dbd
scalerSupport_DBD += devSequencer.dbd
#scalerSupport_DBD += stream.dbd
#scalerSupport_DBD += streamSynApps.dbd
scalerSupport_DBD += vmeVXSupport.dbd
scalerSupport_DBD += std.dbd



scalerSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


#=============================
# Build the IOC application

##PROD_IOC = scaler
PROD_IOC_vxWorks = scaler
# scaler.dbd will be created and installed
DBD += scaler.dbd

# scaler.dbd will be made up from these files:
scaler_DBD += scalerSupport.dbd

# scaler_registerRecordDeviceDriver.cpp derives from scaler.dbd

# Build the main IOC entry point on workstation OSs.
scaler_SRCS_DEFAULT += scalerMain.cpp
#scaler_SRCS_vxWorks += -nil-
scaler_SRCS_vxWorks += scaler_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
scaler_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
scaler_LIBS += scalerSupport
scaler_LIBS += asyn
scaler_LIBS += mca
scaler_LIBS += calc
scaler_LIBS += busy
scaler_LIBS += sscan
scaler_LIBS += autosave
scaler_LIBS += vme
scaler_LIBS += std
#scaler_LIBS += stream streamSynApps
scaler_LIBS += asyn
scaler_LIBS += seqDev seq pv 


# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into scalerSupport
##    sncExample_SNCFLAGS += +r
##    scaler_DBD += sncExample.dbd
#    scaler_restart_SNCFLAGS += +r
#    scaler_warning_SNCFLAGS += +r
    scalerSupport_DBD += scalerSNC.dbd
    scalerSupport_SRCS += scaler_restart.st
    scalerSupport_SRCS += scaler_warning.st
    scaler_SRCS += scaler_restart.st
    scaler_SRCS += scaler_warning.st
    scalerSupport_LIBS += seq pv
##    scaler_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
scaler_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

