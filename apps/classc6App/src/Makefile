TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

##LIBRARY_IOC += classc6Support


# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd

# Compile and add the code to the support library
##classc6Support_SRCS += xxxRecord.c
##classc6Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
##classc6Support_SRCS += dbSubExample.c
##classc6Support_SRCS += classc6Hello.c
##classc6Support_SRCS += initTrace.c

##classc6Support_LIBS += $(EPICS_BASE_IOC_LIBS)







#=============================
# Build the IOC application

##PROD_IOC = classc6
PROD_IOC_vxWorks = classc6
# classc6.dbd will be created and installed
DBD += classc6.dbd

# classc6.dbd will be made up from these files:
##classc6_DBD += base.dbd
##classc6_DBD += xxxSupport.dbd
##classc6_DBD += dbSubExample.dbd
##classc6_DBD += classc6Hello.dbd
##classc6_DBD += initTrace.dbd
##classc6_DBD += sixty_hzSupport.dbd
classc6_DBD += btaSupport.dbd
classc6_DBD += devIocStats.dbd



# classc6_registerRecordDeviceDriver.cpp derives from classc6.dbd
##classc6_SRCS += classc6_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
classc6_SRCS_DEFAULT += classc6Main.cpp
classc6_SRCS_vxWorks += -nil-
classc6_SRCS_vxWorks += classc6_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
classc6_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
##classc6_LIBS += classc6Support

classc6_LIBS += mca
classc6_LIBS += calc
classc6_LIBS += busy
classc6_LIBS += sscan
classc6_LIBS += autosave
classc6_LIBS += std
classc6_LIBS += stream streamSynApps
classc6_LIBS += asyn



classc6_LIBS += mcaSIS
classc6_LIBS += mcaCanberra

classc6_LIBS += devIocStats

classc6_LIBS += seqDev seq pv 

##classc6_LIBS += sixty_hzSupport
classc6_LIBS += btaSupport


# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into classc6Support
##    sncExample_SNCFLAGS += +r
##    classc6_DBD += sncExample.dbd
##    classc6Support_SRCS += sncExample.stt
##    classc6Support_LIBS += seq pv
##    classc6_LIBS += seq pv
    classc6Support_LIBS += seq pv
    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
classc6_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

