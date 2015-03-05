TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#=============================
# Build the IOC application

PROD_IOC_vxWorks = classc4
# classc4.dbd will be created and installed
DBD += classc4.dbd

# classc4.dbd will be made up from these files:
classc4_DBD += harp_genericSupport.dbd
classc4_DBD += sixty_hzSupport.dbd
classc4_DBD += scalerSupport.dbd
classc4_DBD += frwd_scalerSupport.dbd
classc4_DBD += devIocStats.dbd
classc4_DBD += asSupport.dbd


# Build the main IOC entry point on workstation OSs.
classc4_SRCS_DEFAULT += classc4Main.cpp
classc4_SRCS_vxWorks += classc4_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
classc4_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
classc4_LIBS += harp_genericSupport
classc4_LIBS += sixty_hzSupport
classc4_LIBS += scalerSupport
classc4_LIBS += frwd_scalerSupport

classc4_LIBS += mca
classc4_LIBS += calc
classc4_LIBS += busy
classc4_LIBS += sscan
classc4_LIBS += autosave
classc4_LIBS += oms
classc4_LIBS += motor
classc4_LIBS += vme
classc4_LIBS += mcaSIS
classc4_LIBS += mcaCanberra
classc4_LIBS += std
classc4_LIBS += devIocStats
classc4_LIBS += asyn

ifdef IPAC
classc4_LIBS += Ipac TyGSOctal
endif

classc4_LIBS += seqDev seq pv 

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    classc4Support_LIBS += seq pv
endif

# Finally link to the EPICS Base libraries
classc4_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

