TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += A6621Support

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Compile and add the code to the support library
A6621Support_SRCS += xxxRecord.c
A6621Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
A6621Support_SRCS += dbSubExample.c
A6621Support_SRCS += A6621Hello.c
A6621Support_SRCS += initTrace.c

A6621Support_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = A6621
# A6621.dbd will be created and installed
DBD += A6621.dbd

# A6621.dbd will be made up from these files:
A6621_DBD += base.dbd
A6621_DBD += xxxSupport.dbd
A6621_DBD += dbSubExample.dbd
A6621_DBD += A6621Hello.dbd
A6621_DBD += initTrace.dbd

# A6621_registerRecordDeviceDriver.cpp derives from A6621.dbd
A6621_SRCS += A6621_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
A6621_SRCS_DEFAULT += A6621Main.cpp
A6621_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#A6621_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
A6621_LIBS += A6621Support

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into A6621Support
    sncExample_SNCFLAGS += +r
    A6621_DBD += sncExample.dbd
    A6621Support_SRCS += sncExample.stt
    A6621Support_LIBS += seq pv
    A6621_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
A6621_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

