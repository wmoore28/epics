TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

##LIBRARY_IOC += classc8Support

# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd

# Compile and add the code to the support library
##classc8Support_SRCS += xxxRecord.c
##classc8Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
##classc8Support_SRCS += dbSubExample.c
##classc8Support_SRCS += classc8Hello.c
##classc8Support_SRCS += initTrace.c

##classc8Support_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

##PROD_IOC = classc8
PROD_IOC_vxWorks = classc8
# classc8.dbd will be created and installed
DBD += classc8.dbd

# classc8.dbd will be made up from these files:
##classc8_DBD += base.dbd
##classc8_DBD += xxxSupport.dbd
##classc8_DBD += dbSubExample.dbd
##classc8_DBD += classc8Hello.dbd
##classc8_DBD += initTrace.dbd

classc8_DBD += harp_genericSupport.dbd





# classc8_registerRecordDeviceDriver.cpp derives from classc8.dbd
##classc8_SRCS += classc8_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
classc8_SRCS_DEFAULT += classc8Main.cpp
classc8_SRCS_vxWorks += -nil-
classc8_SRCS_vxWorks += classc8_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
classc8_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
##classc8_LIBS += classc8Support

classc8_LIBS += asyn
classc8_LIBS += mca
classc8_LIBS += calc
classc8_LIBS += busy
classc8_LIBS += sscan
classc8_LIBS += autosave
classc8_LIBS += std
classc8_LIBS += stream streamSynApps
classc8_LIBS += asyn
classc8_LIBS += seqDev seq pv 
classc8_LIBS += Aerotech
classc8_LIBS += Attocube
classc8_LIBS += oms
classc8_LIBS += Mclennan
classc8_LIBS += Micos
classc8_LIBS += MicroMo
classc8_LIBS += PI
classc8_LIBS += Acs
classc8_LIBS += Ims
classc8_LIBS += Newport
classc8_LIBS += softMotor
classc8_LIBS += motorSimSupport
classc8_LIBS += SmartMotor
classc8_LIBS += KohzuMotor
classc8_LIBS += motor
classc8_LIBS += devIocStats

classc8_LIBS += seqDev seq pv

classc8_LIBS += harp_genericSupport

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into classc8Support
##    sncExample_SNCFLAGS += +r
##    classc8_DBD += sncExample.dbd
##    classc8Support_SRCS += sncExample.stt
    classc8Support_LIBS += seq pv
##    classc8_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
classc8_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

