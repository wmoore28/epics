TOP=../..

include $(TOP)/configure/CONFIG

# Build the IOC application
#PROD_IOC = chicane
PROD_IOC_Linux = chicane

# chicane.dbd will be created and installed
DBD += chicane.dbd

chicane_DBD += asSupport.dbd
chicane_DBD += devIocStats.dbd

# chicane_registerRecordDeviceDriver.cpp derives from chicane.dbd
chicane_SRCS += chicane_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
chicane_SRCS_DEFAULT += chicaneMain.cpp
chicane_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#chicane_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

chicane_SRCS += chicane.st
chicane_LIBS += seq pv
chicane_LIBS += autosave
chicane_LIBS += devIocStats
chicane_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES

