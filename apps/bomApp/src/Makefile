TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

##LIBRARY_IOC += bomSupport

LIBRARY_IOC_vxWorks += bomSupport

DBD += bomSupport.dbd

bomSupport_DBD += base.dbd
bomSupport_DBD += asyn.dbd
bomSupport_DBD += stdSupport.dbd
bomSupport_DBD += calcSupport.dbd
bomSupport_DBD += busySupport.dbd 
bomSupport_DBD += sscanSupport.dbd 
bomSupport_DBD += asSupport.dbd
bomSupport_DBD += mcaSupport.dbd
bomSupport_DBD += SIS38XXSupport.dbd
bomSupport_DBD += stdVXSupport.dbd
bomSupport_DBD += histogramRecord.dbd
bomSupport_DBD += sub_funcs.dbd

# Compile and add the code to the support library
bomSupport_SRCS += sub_funcs.c

bomSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_vxWorks = bom
# bom.dbd will be created and installed
DBD += bom.dbd

# bom.dbd will be made up from these files:
bom_DBD += bomSupport.dbd

# Build the main IOC entry point on workstation OSs.
bom_SRCS_DEFAULT += bomMain.cpp
bom_SRCS_vxWorks += -nil-
bom_SRCS_vxWorks += bom_registerRecordDeviceDriver.cpp

# Add support from base/src/vxWorks if needed
bom_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
bom_LIBS += bomSupport

bom_LIBS += asyn
bom_LIBS += SIS38XX mca
bom_LIBS += calc
bom_LIBS += busy
bom_LIBS += sscan
bom_LIBS += autosave
bom_LIBS += vme
bom_LIBS += std
bom_LIBS += asyn

# Finally link to the EPICS Base libraries
bom_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

