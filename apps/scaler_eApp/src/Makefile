TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library


LIBRARY_IOC_vxWorks += scaler_eSupport
# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd
DBD += scaler_eSupport.dbd
scaler_eSupport_DBD += base.dbd
scaler_eSupport_DBD += asyn.dbd

#scaler_eSupport_DBD += drvAsynIPPort.dbd
scaler_eSupport_DBD += stdSupport.dbd
scaler_eSupport_DBD += calcSupport.dbd
scaler_eSupport_DBD += busySupport.dbd 
scaler_eSupport_DBD += sscanSupport.dbd 
scaler_eSupport_DBD += asSupport.dbd
#scaler_eSupport_DBD += stream.dbd
#scaler_eSupport_DBD += streamSynApps.dbd
scaler_eSupport_DBD += vmeVXSupport.dbd
scaler_eSupport_DBD += std.dbd



scaler_eSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


#=============================
# Build the IOC application

##PROD_IOC = scaler_e
PROD_IOC_vxWorks = scaler_e
# scaler_e.dbd will be created and installed
DBD += scaler_e.dbd

# scaler_e.dbd will be made up from these files:
scaler_e_DBD += scaler_eSupport.dbd

# scaler_e_registerRecordDeviceDriver.cpp derives from scaler_e.dbd

# Build the main IOC entry point on workstation OSs.
scaler_e_SRCS_DEFAULT += scaler_eMain.cpp

scaler_e_SRCS_vxWorks += scaler_e_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
scaler_e_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
scaler_e_LIBS += scaler_eSupport
scaler_e_LIBS += asyn
scaler_e_LIBS += mca
scaler_e_LIBS += calc
scaler_e_LIBS += busy
scaler_e_LIBS += sscan
scaler_e_LIBS += autosave
scaler_e_LIBS += vme
scaler_e_LIBS += std
#scaler_e_LIBS += stream streamSynApps
scaler_e_LIBS += asyn
scaler_e_LIBS += seq pv 

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into scaler_eSupport
##    sncExample_SNCFLAGS += +r
##    scaler_e_DBD += sncExample.dbd
##    scaler_eSupport_SRCS += sncExample.stt
#    scaler_e_restart_SNCFLAGS += +r
    scaler_eSupport_DBD += scaler_eSNC.dbd
    scaler_eSupport_SRCS += scaler_e_restart.st
    scaler_e_SRCS += scaler_e_restart.st
    scaler_eSupport_LIBS += seq pv
##    scaler_e_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
scaler_e_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

