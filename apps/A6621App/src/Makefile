TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC application

PROD_IOC = A6621
# A6621.dbd will be created and installed
DBD += A6621.dbd

# A6621.dbd will be made up from these files:
A6621_DBD += base.dbd

A6621_DBD += drvAsynIPPort.dbd
A6621_DBD += stream.dbd
A6621_DBD += asSupport.dbd
A6621_DBD += devIocStats.dbd

# A6621_registerRecordDeviceDriver.cpp derives from A6621.dbd
A6621_SRCS += A6621_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
A6621_SRCS_DEFAULT += A6621Main.cpp
A6621_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#A6621_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

A6621_LIBS += autosave 
A6621_LIBS += stream
A6621_LIBS += devIocStats

# asyn should always go last:
A6621_LIBS += asyn

# Finally link to the EPICS Base libraries
A6621_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

