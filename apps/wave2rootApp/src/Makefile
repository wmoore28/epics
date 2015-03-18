TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE


USR_INCLUDES += -I$(shell root-config --incdir)
#USR_INCLUDES += -I$(ROOTSPY)/include/libRootSpy
#USR_INCLUDES += -I$(CMSGROOT)/include
#wave2root_INCLUDES += -I$(shell root-config --incdir)

#=============================
# Build the IOC application

PROD_IOC_Linux = wave2root
# wave2root.dbd will be created and installed
DBD += wave2root.dbd

# pxi.dbd will be made up from these files:
wave2root_DBD += base.dbd
wave2root_DBD += asSupport.dbd
wave2root_DBD += devIocStats.dbd
wave2root_DBD += wave2rootSub.dbd

# wave2root_registerRecordDeviceDriver.cpp derives from wave2root.dbd
wave2root_SRCS += wave2root_registerRecordDeviceDriver.cpp

wave2root_SRCS += wave2rootSub.c
wave2root_SRCS += wave2rootManager.cpp

# Build the main IOC entry point on workstation OSs.
wave2root_SRCS_DEFAULT += wave2rootMain.cpp
wave2root_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#wave2root_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the code from the support library
wave2root_LIBS += devIocStats
wave2root_LIBS += autosave
##wave2root_LDFLAGS += -L$(shell root-config --libdir)
wave2root_LDFLAGS += $(shell root-config --libs)
##wave2root_SYS_LIBS += Core Cint RIO Net Hist Graf Graf3d Gpad Tree Rint Postscript Matrix Physics MathCore Thread
##wave2root_SYS_LIBS += m dl 
##wave2root_LDFLAGS += -pthread -rdynamic
#wave2root_LDFLAGS += -L$(ROOTSPY)/lib
#wave2root_LDFLAGS += -L$(CMSGROOT)/lib
#wave2root_SYS_LIBS += RootSpy
#wave2root_SYS_LIBS += cmsg cmsgxx cmsgRegex


# Finally link to the EPICS Base libraries
wave2root_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
PROD_Linux = Read_60Hz

Read_60Hz_LDFLAGS += $(shell root-config --cflags)
Read_60Hz_LDFLAGS += $(shell root-config --libs)

Read_60Hz_SRCS    += Read_60Hz.cc

#=============================
PROD_Linux = Analyze_Beam_trip

Analyze_Beam_trip_LDFLAGS += $(shell root-config --cflags)
Analyze_Beam_trip_LDFLAGS += $(shell root-config --libs)

Analyze_Beam_trip_SRCS    += Analyze_Beam_trip.cc

#=============================


include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
