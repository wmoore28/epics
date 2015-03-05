TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC_Linux = xpsMotor
# xpsMotor.dbd will be created and installed
DBD += xpsMotor.dbd

# xpsMotor.dbd will be made up from these files:
xpsMotor_DBD += base.dbd
xpsMotor_DBD += asyn.dbd
xpsMotor_DBD += motorRecord.dbd 
xpsMotor_DBD += motorSupport.dbd 
xpsMotor_DBD += drvAsynIPPort.dbd
xpsMotor_DBD += busySupport.dbd
xpsMotor_DBD += sscan.dbd
xpsMotor_DBD += sscanSupport.dbd
xpsMotor_DBD += sscanProgressSupport.dbd
xpsMotor_DBD += calcSupport.dbd
xpsMotor_DBD += devNewport.dbd
xpsMotor_DBD += sscan.dbd
xpsMotor_DBD += sscanSupport.dbd
xpsMotot_DBD += calcSupport.dbd
xpsMotor_DBD += devIocStats.dbd
#xpsMotor_DBD += harpSupport.dbd
xpsMotor_DBD += asSupport.dbd

# Build the IOC support library

#LIBRARY_IOC += xpsMotorSupport

# Include dbd files from all support applications:
#xpsMotor_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#xpsMotor_LIBS += xxx

# xpsMotor_registerRecordDeviceDriver.cpp derives from xpsMotor.dbd
xpsMotor_SRCS += xpsMotor_registerRecordDeviceDriver.cpp

#xpsMotor_SRCS += harp_sub.c

# Build the main IOC entry point on workstation OSs.
xpsMotor_SRCS_DEFAULT += xpsMotorMain.cpp
xpsMotor_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#xpsMotor_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
xpsMotor_LIBS += $(EPICS_BASE_IOC_LIBS)
xpsMotor_LIBS +=  Newport motor busy asyn sscan autosave scanProgress calc devIocStats 


#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

