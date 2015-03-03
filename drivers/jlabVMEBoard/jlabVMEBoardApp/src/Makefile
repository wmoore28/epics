TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

LIBRARY_IOC += jlabVMEBoardSupport

# Install devXxxSoft.dbd into <top>/dbd
DBD += jlabVMEBoardSupport.dbd

# Compile and add the code to the support library
jlabVMEBoardSupport_SRCS += jlabVMEBoardMain.cpp


jlabVMEBoardSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = jlabVMEBoard
# jlabVMEBoard.dbd will be created and installed
DBD += jlabVMEBoard.dbd

# jlabVMEBoard.dbd will be made up from these files:
jlabVMEBoard_DBD += base.dbd

# jlabVMEBoard_registerRecordDeviceDriver.cpp derives from jlabVMEBoard.dbd
jlabVMEBoard_SRCS += jlabVMEBoard_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
jlabVMEBoard_SRCS_DEFAULT += jlabVMEBoardMain.cpp
jlabVMEBoard_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#jlabVMEBoard_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
jlabVMEBoard_LIBS += jlabVMEBoardSupport

# NOTE: To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file


# Finally link to the EPICS Base libraries
jlabVMEBoard_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

