TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC_Linux = hvCaen
# hvCaen.dbd will be created and installed
DBD += hvCaen.dbd

# hvCaen.dbd will be made up from these files:
hvCaen_DBD += base.dbd
hvCaen_DBD += HVCAENx527.dbd
hvCaen_DBD += asyn.dbd
hvCaen_DBD += devSnmp.dbd
hvCaen_DBD += LVMPODSupport.dbd
hvCaen_DBD += devIocStats.dbd
hvCaen_DBD += asSupport.dbd

# hvCaen_registerRecordDeviceDriver.cpp derives from hvCaen.dbd
hvCaen_SRCS += hvCaen_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
hvCaen_SRCS_DEFAULT += hvCaenMain.cpp
hvCaen_SRCS_vxWorks += -nil-
hvCaen_SRCS += genericDB.cc
hvCaen_SRCS += detector.cc
hvCaen_SRCS += DetChannelsWaveform.cc

USR_INCLUDES += -I/apps/Trolltech/Qt/include

USR_INCLUDES += -I$(HVCAENx527)/HVCAENx527App/src
USR_INCLUDES += -I$(DEVSNMP)/snmpApp/src
USR_INCLUDES += -I$(LVMPOD)/LVMPODApp/src
USR_CFLAGS += -g
USR_CXXFLAGS += -g

# Add support from base/src/vxWorks if needed
#hvCaen_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

hvCaen_LIBS += hscaenet
hvCaen_LIBS += caenhvwrapper
hvCaen_LIBS += QtSql
#
hvCaen_LIBS += std
hvCaen_LIBS += busy
hvCaen_LIBS += calc autosave
hvCaen_LIBS += devIocStats
hvCaen_LIBS += sscan
hvCaen_LIBS += asyn
hvCaen_LIBS += seq pv
#
hvCaen_LIBS += HVCAENx527Lib
hvCaen_LIBS += devSnmp
hvCaen_LIBS += LVMPODSupport

hscaenet_DIR      += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
caenhvwrapper_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
QtSql_DIR += /apps/Trolltech/Qt/lib


# Finally link to the EPICS Base libraries
hvCaen_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

dump_db:
	@rm -f svt_voltages.txt
	@echo -e "#\n# Generated dump to text for easy compare in VCS (Makefile)" >> svt_voltages.txt
	@echo -e "# Cmd: sqlite3 svt_voltages.db .dump >> svt_voltages.txt\n#" >> svt_voltages.txt
	@sqlite3 svt_voltages.db .dump >> svt_voltages.txt

install: dump_db
