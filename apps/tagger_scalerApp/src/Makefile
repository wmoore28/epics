TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC_vxWorks += tagger_scalerSupport

DBD += tagger_scalerSupport.dbd

tagger_scalerSupport_DBD += base.dbd
tagger_scalerSupport_DBD += asyn.dbd
tagger_scalerSupport_DBD += stdSupport.dbd
tagger_scalerSupport_DBD += mcaSupport.dbd
tagger_scalerSupport_DBD += SIS38XXSupport.dbd
tagger_scalerSupport_DBD += tagger_scalerSNC.dbd

tagger_scalerSupport_SRCS += t_scalers.st

tagger_scalerSupport_LIBS += mca SIS38XX
tagger_scalerSupport_LIBS += std
tagger_scalerSupport_LIBS += asyn
tagger_scalerSupport_LIBS += seq pv
tagger_scalerSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_vxWorks = tagger_scaler
# tagger_scaler.dbd will be created and installed
DBD += tagger_scaler.dbd

# tagger_scaler.dbd will be made up from these files:
tagger_scaler_DBD += tagger_scalerSupport.dbd
#tagger_scaler_DBD += asSupport.dbd

# tagger_scaler_registerRecordDeviceDriver.cpp derives from tagger_scaler.dbd
#tagger_scaler_SRCS += tagger_scaler_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
tagger_scaler_SRCS_DEFAULT += tagger_scalerMain.cpp
tagger_scaler_SRCS_vxWorks += tagger_scaler_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
tagger_scaler_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
tagger_scaler_LIBS += tagger_scalerSupport 
tagger_scaler_LIBS += SIS38XX mca
#tagger_scaler_LIBS += autosave
tagger_scaler_LIBS += std
tagger_scaler_LIBS += asyn
tagger_scaler_LIBS += seq pv
tagger_scaler_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

