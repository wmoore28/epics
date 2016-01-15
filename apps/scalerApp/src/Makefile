TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC_vxWorks += scalerSupport

# scalerSupport.dbd will be created and installed
DBD += scalerSupport.dbd

# scalerSupport.dbd will be made up from these files:
scalerSupport_DBD += base.dbd
scalerSupport_DBD += asyn.dbd
scalerSupport_DBD += stdSupport.dbd
scalerSupport_DBD += calcSupport.dbd
scalerSupport_DBD += busySupport.dbd 
scalerSupport_DBD += sscanSupport.dbd 
scalerSupport_DBD += vmeVXSupport.dbd
scalerSupport_DBD += scalerSNC.dbd

scalerSupport_SRCS += scaler_restart.st
scalerSupport_SRCS += scaler_warning.st

scalerSupport_LIBS += calc
scalerSupport_LIBS += busy
scalerSupport_LIBS += sscan
scalerSupport_LIBS += vme
scalerSupport_LIBS += std
scalerSupport_LIBS += asyn
scalerSupport_LIBS += seq pv

# Finally link to the EPICS Base libraries
scalerSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_vxWorks = scaler
# scaler.dbd will be created and installed
DBD += scaler.dbd

# scaler.dbd will be made up from these files:
scaler_DBD += scalerSupport.dbd

# Build the main IOC entry point on workstation OSs.
scaler_SRCS_DEFAULT += scalerMain.cpp
scaler_SRCS_vxWorks += scaler_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
scaler_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
scaler_LIBS += scalerSupport
scaler_LIBS += calc
scaler_LIBS += busy
scaler_LIBS += sscan
scaler_LIBS += vme
scaler_LIBS += std
scaler_LIBS += asyn
scaler_LIBS += seq pv 

# Finally link to the EPICS Base libraries
scaler_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

