TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += chillerSupport

chillerSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = chiller
# chiller.dbd will be created and installed
DBD += chiller.dbd

# chiller.dbd will be made up from these files:
chiller_DBD += base.dbd
chiller_DBD += drvAsynSerialPort.dbd
chiller_DBD += drvAsynIPPort.dbd
chiller_DBD += sCalcoutRecord.dbd
chiller_DBD += stream.dbd
chiller_DBD += asSupport.dbd
chiller_DBD += devIocStats.dbd

# chiller_registerRecordDeviceDriver.cpp derives from chiller.dbd
chiller_SRCS += chiller_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
chiller_SRCS_DEFAULT += chillerMain.cpp
chiller_SRCS_vxWorks += -nil-

chiller_LIBS += autosave
chiller_LIBS += calc
chiller_LIBS += stream
chiller_LIBS += devIocStats
chiller_LIBS += asyn

# Finally link to the EPICS Base libraries
chiller_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
