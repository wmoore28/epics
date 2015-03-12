TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC_Linux += svtDaqDpmSupport

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
#svtDaqDpmSupport_SRCS += xxxRecord.c
#svtDaqDpmSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
svtDaqDpmSupport_SRCS += dbSubDpm.c

svtDaqDpmSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC_Linux = svtDaqDpm
# svtDaqDpm.dbd will be created and installed
DBD += svtDaqDpm.dbd

# svtDaqDpm.dbd will be made up from these files:
svtDaqDpm_DBD += base.dbd
svtDaqDpm_DBD += dbSubDpm.dbd
svtDaqDpm_DBD += devIocStats.dbd

# svtDaqDpm_registerRecordDeviceDriver.cpp derives from svtDaqDpm.dbd
svtDaqDpm_SRCS += svtDaqDpm_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
svtDaqDpm_SRCS_DEFAULT += svtDaqDpmMain.cpp
svtDaqDpm_SRCS_vxWorks += -nil-

# Link in the code from the support library
svtDaqDpm_LIBS += svtDaqDpmSupport
svtDaqDpm_LIBS += devIocStats

xml2_DIR += /usr/lib  
xml2_LIBS += xml2  
svtDaqDpm_LIBS += xml2

#SVT DAQ EXTERNAL LIB
svtDaqExt_DIR += $(SVTDAQLIB)  
svtDaqExt_LIBS += svtDaqExt  
svtDaqDpm_LIBS += svtDaqExt

# Finally link to the EPICS Base libraries
svtDaqDpm_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

