TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#LIBRARY_IOC_DEFAULT += -nil-
LIBRARY_IOC_vxWorks += frwd_scalerSupport
# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd
DBD += frwd_scalerSupport.dbd
frwd_scalerSupport_DBD += base.dbd
frwd_scalerSupport_DBD += asyn.dbd

#frwd_scalerSupport_DBD += drvAsynIPPort.dbd
frwd_scalerSupport_DBD += stdSupport.dbd
frwd_scalerSupport_DBD += calcSupport.dbd
frwd_scalerSupport_DBD += busySupport.dbd 
frwd_scalerSupport_DBD += sscanSupport.dbd 
frwd_scalerSupport_DBD += asSupport.dbd
frwd_scalerSupport_DBD += devSequencer.dbd
#frwd_scalerSupport_DBD += stream.dbd
#frwd_scalerSupport_DBD += streamSynApps.dbd
frwd_scalerSupport_DBD += vmeVXSupport.dbd
frwd_scalerSupport_DBD += std.dbd


frwd_scalerSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


#=============================
# Build the IOC application

##PROD_IOC = frwd_scaler
PROD_IOC_vxWorks = frwd_scaler
# frwd_scaler.dbd will be created and installed
DBD += frwd_scaler.dbd

# frwd_scaler.dbd will be made up from these files:
frwd_scaler_DBD += frwd_scalerSupport.dbd

# frwd_scaler_registerRecordDeviceDriver.cpp derives from frwd_scaler.dbd

# Build the main IOC entry point on workstation OSs.
frwd_scaler_SRCS_DEFAULT += frwd_scalerMain.cpp
#scaler_d_SRCS_vxWorks += -nil-
frwd_scaler_SRCS_vxWorks += frwd_scaler_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
frwd_scaler_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
frwd_scaler_LIBS += frwd_scalerSupport
frwd_scaler_LIBS += asyn
frwd_scaler_LIBS += mca
frwd_scaler_LIBS += calc
frwd_scaler_LIBS += busy
frwd_scaler_LIBS += sscan
frwd_scaler_LIBS += autosave
frwd_scaler_LIBS += vme
frwd_scaler_LIBS += std
#frwd_scaler_LIBS += stream streamSynApps
frwd_scaler_LIBS += asyn
frwd_scaler_LIBS += seqDev seq pv 

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into frwd_scalerSupport
##    sncExample_SNCFLAGS += +r
##    frwd_scaler_DBD += sncExample.dbd
##    frwd_scalerSupport_SRCS += sncExample.stt
#    frwd_scaler_restart_SNCFLAGS += +r
    frwd_scalerSupport_DBD += frwd_scalerSNC.dbd
    frwd_scalerSupport_SRCS += frwd_scaler_restart.st
    frwd_scaler_SRCS += frwd_scaler_restart.st
    frwd_scalerSupport_LIBS += seq pv
##    frwd_scaler_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
frwd_scaler_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

