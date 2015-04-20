TOP=../..

include $(TOP)/configure/CONFIG

#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC application
STATIC_BUILD=YES

PROD_Linux += iocscalers

# <name>.dbd will be created from <name>Include.dbd
DBD += iocscalers.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
iocscalers_SRCS += iocscalers_registerRecordDeviceDriver.cpp
iocscalers_SRCS += devSCALERS.c
iocscalers_SRCS += jscalers_smi_c.c
iocscalers_SRCS += jscalers_ioc.cpp
iocscalers_SRCS += jscalers_smi.cpp

# Build the main IOC entry point on workstation OSs.
iocscalers_SRCS_DEFAULT += iocscalersMain.cpp
iocscalers_SRCS_vxWorks += -nil-

iocscalers_LIBS += jscalers
iocscalers_LIBS += rol
iocscalers_LIBS += devIocStats
iocscalers_LIBS += $(EPICS_BASE_IOC_LIBS)

rol_DIR += /usr/local/clas12/release/0.2/coda/src/rol/Linux_i686/lib
PROD_LIBS += mysql4.1.20
mysql4.1.20_DIR += /usr/local/clas12/release/0.2/coda/src/mysql4.1.20/Linux_i686/lib

USR_INCLUDES += -I /usr/local/clas12/release/0.2/coda/src/rol/code.s

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
