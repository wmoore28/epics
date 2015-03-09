TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC application

PROD_IOC_Linux = svtIntlk
# svtIntlk.dbd will be created and installed
DBD += svtIntlk.dbd

# svtIntlk.dbd will be made up from these files:
svtIntlk_DBD += base.dbd
svtIntlk_DBD += devIocStats.dbd
svtIntlk_DBD += asSupport.dbd


# svtIntlk_registerRecordDeviceDriver.cpp derives from svtIntlk.dbd
svtIntlk_SRCS += svtIntlk_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
svtIntlk_SRCS_DEFAULT += svtIntlkMain.cpp

# Link in the code from the support library
svtIntlk_LIBS += devIocStats
svtIntlk_LIBS += autosave

# Finally link to the EPICS Base libraries
svtIntlk_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

