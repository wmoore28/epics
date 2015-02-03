TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#USR_CFLAGS += -I/usr/include        #Path to snmp if ness.
USR_CFLAGS += `net-snmp-config --cflags`
USR_CFLAGS += -DNETSNMP_NO_INLINE

USR_LDFLAGS += `net-snmp-config --libs`
PROD_LDLIBS += `net-snmp-config --libs`

USR_CFLAGS += $(shell $(PERL) ../getNetSNMPversion.pl)
USR_CPPFLAGS += $(shell $(PERL) ../getNetSNMPversion.pl)

#==================================================
# Build an IOC support library
LIBRARY_IOC_Linux += devSnmp

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord
# install devXxxSoft.dbd into <top>/dbd
DBD += devSnmp.dbd

# The following are compiled and added to the Support library

devSnmp_SRCS += snmpRegister.cpp
devSnmp_SRCS += snmpSessShow.c
devSnmp_SRCS += devSnmp.cpp

devSnmp_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# build an ioc application

PROD_IOC_Linux = snmp

# snmp.dbd will be created and installed
DBD += snmp.dbd

# snmp.dbd will be made up from these files:
snmp_DBD += base.dbd
snmp_DBD += devSnmp.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
snmp_SRCS += snmp_registerRecordDeviceDriver.cpp
snmp_SRCS_DEFAULT += snmpMain.cpp
snmp_SRCS_vxWorks += -nil-

# The following adds support from base/src/vxWorks
snmp_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

snmp_LIBS += devSnmp

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # This builds sncExample as a component of snmp
    snmp_SNCFLAGS += +r
    snmp_DBD += sncExample.dbd
    snmp_SRCS += sncExample.stt
    snmp_LIBS += seq pv

    # The following builds sncProgram as a standalone application
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

snmp_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

