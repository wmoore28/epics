TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

##LIBRARY_IOC += sixty_hzSupport
#LIBRARY_IOC_DEFAULT += -nil-
LIBRARY_IOC_vxWorks += sixty_hzSupport

# xxxRecord.h will be created from xxxRecord.dbd
##DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
##DBD += xxxSupport.dbd
DBD += sixty_hzSupport.dbd
sixty_hzSupport_DBD += base.dbd
sixty_hzSupport_DBD += asyn.dbd

sixty_hzSupport_DBD += stdSupport.dbd
sixty_hzSupport_DBD += calcSupport.dbd
sixty_hzSupport_DBD += busySupport.dbd 
sixty_hzSupport_DBD += sscanSupport.dbd 
sixty_hzSupport_DBD += asSupport.dbd
sixty_hzSupport_DBD += devSequencer.dbd
#sixty_hzSupport_DBD += stream.dbd
#sixty_hzSupport_DBD += streamSynApps.dbd
sixty_hzSupport_DBD += vmeVXSupport.dbd
sixty_hzSupport_DBD += std.dbd

sixty_hzSupport_DBD += mcaSupport.dbd
sixty_hzSupport_DBD += mcaSISSupport.dbd
#sixty_hzSupport_DBD += mcaCanberraSupport.dbd
sixty_hzSupport_DBD += stdVXSupport.dbd


# Compile and add the code to the support library
##sixty_hzSupport_SRCS += xxxRecord.c
##sixty_hzSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
##sixty_hzSupport_SRCS += dbSubExample.c
##sixty_hzSupport_SRCS += sixty_hzHello.c
##sixty_hzSupport_SRCS += initTrace.c
sixty_hzSupport_SRCS += fftmisc.c
sixty_hzSupport_SRCS += fourierf.c

sixty_hzSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

##PROD_IOC = sixty_hz
PROD_IOC_vxWorks = sixty_hz
# sixty_hz.dbd will be created and installed
DBD += sixty_hz.dbd

# sixty_hz.dbd will be made up from these files:
sixty_hz_DBD += sixty_hzSupport.dbd

# sixty_hz_registerRecordDeviceDriver.cpp derives from sixty_hz.dbd
#sixty_hz_SRCS += sixty_hz_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
sixty_hz_SRCS_DEFAULT += sixty_hzMain.cpp
#sixty_hz_SRCS_vxWorks += -nil-
sixty_hz_SRCS_vxWorks += sixty_hz_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
sixty_hz_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
sixty_hz_LIBS += sixty_hzSupport 
sixty_hz_LIBS += asyn
sixty_hz_LIBS += mca
sixty_hz_LIBS += calc
sixty_hz_LIBS += busy
sixty_hz_LIBS += sscan
sixty_hz_LIBS += autosave
sixty_hz_LIBS += vme
sixty_hz_LIBS += std
#sixty_hz_LIBS += stream streamSynApps
sixty_hz_LIBS += asyn
sixty_hz_LIBS += seqDev seq pv 

sixty_hz_LIBS += mcaSIS
#sixty_hz_LIBS += mcaCanberra


# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into sixty_hzSupport
##    sncExample_SNCFLAGS += +r
##    sixty_hz_DBD += sncExample.dbd
##    sixty_hzSupport_SRCS += sncExample.stt
##    sixty_hzSupport_LIBS += seq pv
##    sixty_hz_LIBS += seq pv

    # Build sncProgram as a standalone program
##    PROD_HOST += sncProgram
##    sncProgram_SNCFLAGS += +m
##    sncProgram_SRCS += sncProgram.st
##    sncProgram_LIBS += seq pv
##    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

#      sixty_hz_SNCFLAGS += +r
      sixty_hzSupport_DBD += sixty_hzSNC.dbd
      sixty_hzSupport_SRCS += sixtyHz.st
      sixty_hz_SRCS += sixtyHz.st
      sixty_hzSupport_LIBS += seq pv

endif

# Finally link to the EPICS Base libraries
sixty_hz_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

