TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC_Linux = ioccaen
# ecalHV.dbd will be created and installed
DBD += ioccaen.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
ioccaen_SRCS += ioccaen_registerRecordDeviceDriver.cpp
ioccaen_SRCS += bigsub.c
ioccaen_SRCS += sub.c
ioccaen_SRCS += devCAEN.c
ioccaen_SRCS_DEFAULT += ioccaenMain.cpp
ioccaen_SRCS_vxWorks += -nil-

USR_INCLUDES += -I$(CAEN_HV)/include

ioccaen_LIBS += $(EPICS_BASE_IOC_LIBS)
ioccaen_LIBS += sy1527epics1
ioccaen_LIBS += caenhvwrapper 
ioccaen_LIBS += hscaenet 
ioccaen_LIBS += devIocStats
sy1527epics1_DIR += $(TOP)/lib/$(T_A)

caenhvwrapper_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
hscaenet_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib

#===========================

ioccaen_LIBS += smi
ioccaen_LIBS += smiui
ioccaen_LIBS += dim

smi_DIR += $(SMIDIR)/$(ODIR)
smiui_DIR += $(SMIDIR)/$(ODIR)
dim_DIR += $(DIMDIR)/$(ODIR)

USR_INCLUDES += -I $(SMIDIR)/smixx
USR_INCLUDES += -I $(DIMDIR)/dim

#===========================
include $(TOP)/configure/RULES

#----------------------------------------
#  ADD RULES AFTER THIS LINE

