TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += chicaneSupport

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Compile and add the code to the support library
chicaneSupport_SRCS += xxxRecord.c
chicaneSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
chicaneSupport_SRCS += dbSubExample.c
chicaneSupport_SRCS += chicaneHello.c
chicaneSupport_SRCS += initTrace.c

chicaneSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = chicane
# chicane.dbd will be created and installed
DBD += chicane.dbd

# chicane.dbd will be made up from these files:
chicane_DBD += base.dbd
chicane_DBD += xxxSupport.dbd
chicane_DBD += dbSubExample.dbd
chicane_DBD += chicaneHello.dbd
chicane_DBD += initTrace.dbd

# chicane_registerRecordDeviceDriver.cpp derives from chicane.dbd
chicane_SRCS += chicane_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
chicane_SRCS_DEFAULT += chicaneMain.cpp
chicane_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#chicane_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
chicane_LIBS += chicaneSupport

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into chicaneSupport
    sncExample_SNCFLAGS += +r
    chicane_DBD += sncExample.dbd
    chicaneSupport_SRCS += sncExample.stt
    chicaneSupport_LIBS += seq pv
    chicane_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
chicane_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

