TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += btaSupport
###LIBRARY_IOC_vxWorks += btaSupport

# Install devXxxSoft.dbd into <top>/dbd


DBD += btaSupport.dbd
btaSupport_DBD += base.dbd
btaSupport_DBD += asyn.dbd

btaSupport_DBD += histogramRecord.dbd
#btaSupport_DBD += btaSupport.dbd
btaSupport_DBD += stdSupport.dbd
btaSupport_DBD += calcSupport.dbd
btaSupport_DBD += busySupport.dbd 
btaSupport_DBD += sscanSupport.dbd 
btaSupport_DBD += asSupport.dbd
btaSupport_DBD += devSequencer.dbd
btaSupport_DBD += stream.dbd
btaSupport_DBD += streamSynApps.dbd
btaSupport_DBD += std.dbd



btaSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


#=============================
# Build the IOC application

PROD_IOC = bta
##PROD_IOC_vxWorks = bta
# bta.dbd will be created and installed
DBD += bta.dbd

# bta.dbd will be made up from these files:
bta_DBD += btaSupport.dbd

# bta_registerRecordDeviceDriver.cpp derives from bta.dbd

# Build the main IOC entry point on workstation OSs.
bta_SRCS_DEFAULT += btaMain.cpp

bta_SRCS_vxWorks += bta_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
###bta_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
#bta_LIBS += btaSupport
bta_LIBS += calc
bta_LIBS += busy
bta_LIBS += sscan
bta_LIBS += autosave
bta_LIBS += std
bta_LIBS += stream streamSynApps
bta_LIBS += asyn
bta_LIBS += seqDev seq pv 
bta_LIBS += softDevIoc
# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file

ifneq ($(SNCSEQ),)
    # Build sncExample into btaSupport
#    btaSNC_SNCFLAGS += +r
#    bta_SNCFLAGS += +m
#    bta_test_SNCFLAGS += +m

    btaSupport_DBD += btaSNC.dbd
    btaSupport_SRCS += bta.st
    btaSupport_SRCS += bta_test.st
#    bta_SRCS += bta.st
#    bta_SRCS += bta_test.st
    btaSupport_LIBS += seq pv
#    bta_LIBS += seq pv

    # Build sncProgram as a standalone program
#    PROD_HOST += sncBTA
#    bta_SNCFLAGS += +m
#    bta_SNCFLAGS += +m    
#    sncB_SRCS += bta.st
#    bta_LIBS += seq pv
#    bta_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link to the EPICS Base libraries
bta_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

