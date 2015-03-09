TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

#=============================
# Build the IOC application

PROD_IOC_vxWorks = classc8
# classc8.dbd will be created and installed 
DBD += classc8.dbd

# classc8.dbd will be made up from these files:
#classc8_DBD += harp_genericSupport.dbd
classc8_DBD += sixty_hzSupport.dbd
#classc8_DBD += scalerSupport.dbd
#classc8_DBD += frwd_scalerSupport.dbd
classc8_DBD += devIocStats.dbd
classc8_DBD += asSupport.dbd


# Build the main IOC entry point on workstation OSs.
classc8_SRCS_DEFAULT += classc8Main.cpp
classc8_SRCS_vxWorks += classc8_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
classc8_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
#classc8_LIBS += harp_genericSupport
classc8_LIBS += sixty_hzSupport
#classc8_LIBS += scalerSupport
#classc8_LIBS += frwd_scalerSupport

#classc8_LIBS += devIocStats

classc8_LIBS += mca
classc8_LIBS += calc
classc8_LIBS += busy
classc8_LIBS += sscan
classc8_LIBS += autosave
classc8_LIBS += oms
classc8_LIBS += motor
classc8_LIBS += vme
classc8_LIBS += mcaSIS
classc8_LIBS += mcaCanberra
classc8_LIBS += std
#classc8_LIBS += devIocStats
classc8_LIBS += asyn
classc8_LIBS += devIocStats

ifdef IPAC
classc8_LIBS += Ipac TyGSOctal
endif

classc8_LIBS += seqDev seq pv 

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    classc8Support_LIBS += seq pv
endif

# Finally link to the EPICS Base libraries
classc8_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

