TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Build the IOC application
PROD_IOC_vxWorks = classc2

# classc2.dbd will be created and installed
DBD += classc2.dbd

# classc2.dbd will include these files:
classc2_DBD += base.dbd
classc2_DBD += devIocStats.dbd

# classc2_registerRecordDeviceDriver.cpp derives from classc2.dbd
classc2_SRCS += classc2_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
classc2_SRCS_DEFAULT += classc2Main.cpp
classc2_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
classc2_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from our support library
classc2_LIBS += SIS38XX mca
#classc2_LIBS += STR7201
classc2_LIBS += calc
classc2_LIBS += busy
classc2_LIBS += sscan
classc2_LIBS += vme
classc2_LIBS += devIocStats
classc2_LIBS += std
classc2_LIBS += asyn
classc2_LIBS += seq pv
classc2_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

