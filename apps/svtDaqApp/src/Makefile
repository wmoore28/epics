TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC_Linux += svtDaqSupport

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
#DBD += xxxSupport.dbd

#USR_INCLUDES += -I/root/daq/include
USR_INCLUDES += -I/usr/include/libxml2

#SVT DAQ STUFF
#SVTDAQLIB = $(TOP)/../svtDaqLib
USR_INCLUDES += -I$(SVTDAQLIB)

# Compile and add the code to the support library
#svtDaqSupport_SRCS += xxxRecord.c
#svtDaqSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
svtDaqSupport_SRCS += dbSubSvtDaq.c
svtDaqSupport_SRCS += tcpip.c
svtDaqSupport_SRCS += constants.c
svtDaqSupport_SRCS += status.c
svtDaqSupport_SRCS += daqmap.c
svtDaqSupport_SRCS += client_util.c
svtDaqSupport_SRCS += febxml.c
svtDaqSupport_SRCS += hybxml.c
svtDaqSupport_SRCS += common.c
svtDaqSupport_SRCS += socket.c

svtDaqSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_Linux = svtDaq
# svtDaq.dbd will be created and installed
DBD += svtDaq.dbd

# svtDaq.dbd will be made up from these files:
svtDaq_DBD += base.dbd
svtDaq_DBD += dbSubSvtDaq.dbd
svtDaq_DBD += devIocStats.dbd

# svtDaq_registerRecordDeviceDriver.cpp derives from svtDaq.dbd
svtDaq_SRCS += svtDaq_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
svtDaq_SRCS_DEFAULT += svtDaqMain.cpp
svtDaq_SRCS_vxWorks += -nil-

# Link in the code from the support library
svtDaq_LIBS += svtDaqSupport
svtDaq_LIBS += devIocStats

xml2_DIR += /usr/lib  
xml2_LIBS += xml2  
svtDaq_LIBS += xml2

#SVT DAQ EXTERNAL LIB
svtDaqExt_DIR += $(SVTDAQLIB)  
svtDaqExt_LIBS += svtDaqExt  
svtDaq_LIBS += svtDaqExt

# Finally link to the EPICS Base libraries
svtDaq_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

