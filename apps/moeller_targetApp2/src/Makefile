TOP=../..

include $(TOP)/configure/CONFIG

LIBRARY_IOC_vxWorks += moeller_targetSupport

DBD += moeller_targetSupport.dbd

# Build the IOC application
PROD_IOC_vxWorks = moeller_target

# moeller_target.dbd will be created and installed
DBD += moeller_target.dbd

moeller_targetSupport_DBD += moeller_targetSupport.dbd
moeller_targetSupport_DBD += moeller_targetSNC.dbd

# moeller_target_registerRecordDeviceDriver.cpp derives from moeller_target.dbd
moeller_targetSupport_SRCS += moeller_target_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
moeller_target_SRCS_DEFAULT += moeller_targetMain.cpp
moeller_target_SRCS_vxWorks += moeller_target_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
moeller_target_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

moeller_targetSupport_SRCS += moeller_target.st
moeller_target_LIBS += seq pv
moeller_target_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES

