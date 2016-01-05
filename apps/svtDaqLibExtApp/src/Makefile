TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#==================================================
# build a support library

LIBRARY_IOC_Linux += svtDaqLibExt

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord
# install svtDaqLib.dbd into <top>/dbd
DBD += svtDaqLibExt.dbd

# specify all source files to be compiled and added to the library
svtDaqLibExt_SRCS += commonXml.c
svtDaqLibExt_SRCS += commonConstants.c
svtDaqLibExt_SRCS += commonDoc.c
svtDaqLibExt_SRCS += commonSocket.c

INC += commonXml.h commonConstants.h commonDoc.h commonSocket.h

svtDaqLibExt_LIBS += xml2
svtDaqLibExt_LIBS += $(EPICS_BASE_IOC_LIBS)

xml2_DIR += $(LIBS)
USR_INCLUDES += -I/usr/include/libxml2

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

