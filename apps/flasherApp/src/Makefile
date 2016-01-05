TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================

#=============================
# Build the IOC application

PROD_IOC = flasher
# flasher.dbd will be created and installed
DBD += flasher.dbd

# flasher.dbd will be made up from these files:
flasher_DBD += base.dbd
flasher_DBD += devIocStats.dbd
flasher_DBD += asyn.dbd
flasher_DBD += drvAsynIPPort.dbd
flasher_DBD += stream.dbd
flasher_DBD += system.dbd

# flasher_registerRecordDeviceDriver.cpp derives from flasher.dbd
flasher_SRCS += flasher_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
flasher_SRCS_DEFAULT += flasherMain.cpp
flasher_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#flasher_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
flasher_LIBS += devIocStats
flasher_LIBS += stream
flasher_LIBS += asyn

# Finally link to the EPICS Base libraries
flasher_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

