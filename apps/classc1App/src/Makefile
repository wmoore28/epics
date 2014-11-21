TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#=============================
# Build the IOC application

PROD_IOC_vxWorks = classc1
# classc1.dbd will be created and installed
DBD += classc1.dbd

# classc1.dbd will be made up from these files:
classc1_DBD += harp_genericSupport.dbd
classc1_DBD += scaler_cSupport.dbd
classc1_DBD += scaler_dSupport.dbd
classc1_DBD += scaler_eSupport.dbd
##classc1_DBD += asymSupport.dbd
classc1_DBD += bomSupport.dbd
classc1_DBD += devIocStats.dbd
##classc1_DBD += xy240.dbd

# Build the main IOC entry point on workstation OSs.
classc1_SRCS_DEFAULT += classc1Main.cpp
classc1_SRCS_vxWorks += classc1_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
classc1_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
classc1_LIBS += harp_genericSupport
classc1_LIBS += scaler_cSupport
classc1_LIBS += scaler_dSupport
classc1_LIBS += scaler_eSupport
##classc1_LIBS += asymSupport
classc1_LIBS += bomSupport

classc1_LIBS += mca
classc1_LIBS += calc
classc1_LIBS += busy
classc1_LIBS += sscan
classc1_LIBS += autosave
classc1_LIBS += oms
classc1_LIBS += motor
classc1_LIBS += vme
classc1_LIBS += mcaSIS
classc1_LIBS += mcaCanberra
classc1_LIBS += std
classc1_LIBS += devIocStats
##classc1_LIBS += xycomDigital
classc1_LIBS += asyn

ifdef IPAC
classc1_LIBS += Ipac TyGSOctal
endif

classc1_LIBS += seqDev seq pv 

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    classc1Support_LIBS += seq pv
endif

# Finally link to the EPICS Base libraries
classc1_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

