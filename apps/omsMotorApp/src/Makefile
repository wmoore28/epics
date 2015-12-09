#FILENAME...     Makefile
#USAGE...        Makefile for motor application example with Asyn

#Version:        $Revision: 9857 $
#Modified By:    $Author: sluiter $
#Last Modified:  $Date: 2009-12-09 10:21:24 -0600 (Wed, 09 Dec 2009) $
#HeadURL:        $URL: https://subversion.xor.aps.anl.gov/synApps/motor/tags/R6-5/motorExApp/WithAsyn/Makefile $

# "#!" marks lines that can be uncommented.

TOP = ../..
include $(TOP)/configure/CONFIG

CROSS_COMPILER_TARGET_ARCHS=vxWorks-ppc604_long

PROD_IOC_DEFAULT = omsMotor
PROD_IOC_vxWorks = omsMotorVx

COMMONDBDS  = base.dbd
COMMONDBDS += motorSupport.dbd
COMMONDBDS += devAcsMotor.dbd
COMMONDBDS += devImsMotor.dbd
COMMONDBDS += devMclennanMotor.dbd
COMMONDBDS += devMicos.dbd
COMMONDBDS += devMicroMo.dbd
COMMONDBDS += devNewport.dbd
ifdef SNCSEQ
COMMONDBDS += LdevNewportTS.dbd
endif
COMMONDBDS += devPIMotor.dbd
COMMONDBDS += devOms.dbd
COMMONDBDS += devSoftMotor.dbd
COMMONDBDS += motorSimSupport.dbd
COMMONDBDS += devSmartMotorMotor.dbd
COMMONDBDS += devKohzuMotor.dbd
COMMONDBDS += devAttocube.dbd
COMMONDBDS += devAerotech.dbd
COMMONDBDS += drvAsynSerialPort.dbd

DBD += omsMotor.dbd
omsMotor_DBD += $(COMMONDBDS)
#ifdef SNCSEQ
#omsMotor_DBD += devSequencer.dbd
#endif

ifeq ($(OS_CLASS), vxWorks)
DBD += omsMotorVx.dbd
omsMotorVx_DBD += $(COMMONDBDS)
#!omsMotorVx_DBD += drvGsIP488.dbd
ifdef IPAC
omsMotorVx_DBD += MiscVx.dbd
endif
endif

omsMotor_SRCS   += omsMotor_registerRecordDeviceDriver.cpp
omsMotor_SRCS_DEFAULT += omsMotorMain.cpp
omsMotorVx_SRCS += omsMotorVx_registerRecordDeviceDriver.cpp

omsMotor_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

COMMONLIBS += Aerotech
COMMONLIBS += Attocube
COMMONLIBS += oms
COMMONLIBS += Mclennan
COMMONLIBS += Micos
COMMONLIBS += MicroMo
COMMONLIBS += PI
COMMONLIBS += Acs
COMMONLIBS += Ims
COMMONLIBS += Newport
COMMONLIBS += softMotor
COMMONLIBS += motorSimSupport
COMMONLIBS += SmartMotor
COMMONLIBS += KohzuMotor
COMMONLIBS += motor

# Needed for Newport SNL programs
omsMotor_LIBS += $(COMMONLIBS)
omsMotor_LIBS += asyn
ifdef SNCSEQ
omsMotor_LIBS += seq pv
endif
omsMotor_LIBS += $(EPICS_BASE_IOC_LIBS)

omsMotorVx_LIBS += $(COMMONLIBS)
ifdef IPAC
omsMotorVx_LIBS += Ipac TyGSOctal
endif
omsMotorVx_LIBS += asyn
# Needed for Newport SNL programs
ifdef SNCSEQ
omsMotorVx_LIBS   += seq pv
endif
omsMotorVx_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES

