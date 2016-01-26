TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# build an ioc application

PROD_IOC_Linux = mpodCrates
# mpodCrates.dbd will be created and installed
DBD += mpodCrates.dbd

# mpodCrates.db will be made up from these files:
mpodCrates_DBD += base.dbd
mpodCrates_DBD += devSnmp.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
mpodCrates_SRCS += mpodCrates_registerRecordDeviceDriver.cpp
mpodCrates_SRCS_DEFAULT += mpodCratesMain.cpp
mpodCrates_SRCS_vxWorks += -nil-

# The following adds support from base/src/vxWorks
#mpodCrates_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

mpodCrates_LIBS +=  devSnmp    #main devSnmp lib

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # This builds sncExample as a component of snmp
#    mpodCrates_SNCFLAGS += +r
#    mpodCrates_DBD += sncExample.dbd
#    mpodCrates_SRCS += sncExample.stt
#    mpodCrates_LIBS += seq pv

    # The following builds sncProgram as a standalone application
#    PROD_HOST += sncProgram
#    sncProgram_SNCFLAGS += +m
#    sncProgram_SRCS += sncProgram.st
#    sncProgram_LIBS += seq pv
#    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

mpodCrates_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

