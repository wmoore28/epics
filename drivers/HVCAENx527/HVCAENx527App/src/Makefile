TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

LIBRARY_IOC_Linux = HVCAENx527Lib

HVCAENx527Lib_SRCS_vxWorks += -nil-
HVCAENx527Lib_SRCS += HVCAENx527.c
HVCAENx527Lib_SRCS += HVCAENx527chAio.c HVCAENx527chBio.c HVCAENx527chLongio.c HVCAENx527chMBBio.c 
HVCAENx527Lib_SRCS += HVCAENx527chStringio.c HVCAENx527Stringio.c HVCAENx527MBBi.c

#The following adds support from base/src/vxWorks
HVCAENx527Lib_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

DBD += HVCAENx527.dbd


#=============================

# build an ioc application

PROD_IOC_Linux = HVCAENx527
# <name>.dbd will be created from <name>Include.dbd
#DBD += HVCAENx527.dbd

#EPICS_LOCAL = $(APP)

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
HVCAENx527_SRCS += HVCAENx527Main.cpp
HVCAENx527_SRCS += HVCAENx527_registerRecordDeviceDriver.cpp
#HVCAENx527_SRCS_vxWorks += -nil-

#The following adds support from base/src/vxWorks
#HVCAENx527_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

HVCAENx527_LIBS += HVCAENx527Lib 
HVCAENx527_LIBS += hscaenet
HVCAENx527_LIBS += caenhvwrapper

hscaenet_DIR      += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
caenhvwrapper_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib

# Finally link to the EPICS Base libraries
HVCAENx527_LIBS += $(EPICS_BASE_IOC_LIBS)


#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

