TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

USR_CFLAGS += `net-snmp-config --cflags`
USR_CFLAGS += -DNETSNMP_NO_INLINE

USR_LDFLAGS += `net-snmp-config --libs`
PROD_LDLIBS += `net-snmp-config --libs`

USR_CFLAGS += $(shell $(PERL) $(DEVSNMP)/snmpApp/src/getNetSNMPversion.pl)
USR_CPPFLAGS += $(shell $(PERL) $(DEVSNMP)/snmpApp/src/getNetSNMPversion.pl)


#=============================
# Build the IOC support library

LIBRARY_IOC_Linux += LVMPODSupport

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord
# Install  LVMPODSupport.dbd into <top>/dbd
DBD += LVMPODSupport.dbd

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
LVMPODSupport_SRCS += initTrace.c
LVMPODSupport_SRCS += LVMPOD_TestCrate.cpp
LVMPODSupport_SRCS += drvMPOD.cpp 
LVMPODSupport_SRCS += drvGlobalMPOD.cpp 
LVMPODSupport_SRCS += LVMPODCrate.cpp
LVMPODSupport_SRCS += LVMPOD.cpp

LVMPODSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_Linux = LVMPOD

# LVMPOD.dbd will be created and installed
DBD += LVMPOD.dbd
#USR_DBDFLAGS += -I  $(EPICS)/support/snmp/dbd

# LVMPOD.dbd will be made up from these files:
#LVMPOD_DBD += base.dbd
#LVMPOD_DBD += devSnmp.dbd
#LVMPOD_DBD += LVMPODSupport.dbd


# LVMPOD_registerRecordDeviceDriver.cpp derives from LVMPOD.dbd
LVMPOD_SRCS += LVMPOD_registerRecordDeviceDriver.cpp


#INCLUDES += -I../

# Build the main IOC entry point on workstation OSs.
LVMPOD_SRCS_DEFAULT += LVMPODMain.cpp
LVMPOD_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#LVMPOD_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
LVMPOD_LIBS += LVMPODSupport

#devSnmp_DIR = $(EPICS)/support/snmp/lib/$(EPICS_HOST_ARCH)/
#devSnmp_DIR = $(APP)/../support/snmp-nscl-1.0.RC6/lib/$(EPICS_HOST_ARCH)/
LVMPOD_LIBS += devSnmp

LVMPOD_LIBS += std
LVMPOD_LIBS += busy
LVMPOD_LIBS += calc autosave
LVMPOD_LIBS += sscan
LVMPOD_LIBS += asyn
LVMPOD_LIBS += seq pv

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into LVMPODSupport
#    sncExample_SNCFLAGS += +r
#    LVMPOD_DBD += sncExample.dbd
#    LVMPODSupport_SRCS += sncExample.stt
#    LVMPODSupport_LIBS += seq pv
#    LVMPOD_LIBS += seq pv

    # Build sncProgram as a standalone program
#    PROD_HOST += sncProgram
#    sncProgram_SNCFLAGS += +m
#    sncProgram_SRCS += sncProgram.st
#    sncProgram_LIBS += seq pv
#    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
LVMPOD_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

