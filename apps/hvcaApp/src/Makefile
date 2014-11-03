TOP=../..

include $(TOP)/configure/CONFIG

PROD_SRCS += hv.f 
PROD_SRCS += read_db.f 
PROD_SRCS += write_set_v.f 
PROD_SRCS += write_mvdz.f 
PROD_SRCS += write_mcdz.f 
PROD_SRCS += write_ramp_up.f 
PROD_SRCS += write_ramp_down.f 
PROD_SRCS += write_trip_current.f 
PROD_SRCS += read_set_v.f 
PROD_SRCS += read_mvdz.f 
PROD_SRCS += read_mcdz.f 
PROD_SRCS += read_ramp_up.f 
PROD_SRCS += read_ramp_down.f 
PROD_SRCS += read_trip_current.f 
PROD_SRCS += read_status.f 
PROD_SRCS += get_pvname.f 
PROD_SRCS += mf_on.f 
PROD_SRCS += mf_off.f 
PROD_SRCS += ramp_up_group.f 
PROD_SRCS += ramp_down_group.f 
PROD_SRCS += print_channels.f 
PROD_SRCS += write_enable.f 
PROD_SRCS += show_settings.f 
PROD_SRCS += read_enable.f 
PROD_SRCS += single_channel.f 
PROD_SRCS += single_info.f 
PROD_SRCS += change_alarms.f 
PROD_SRCS += write_alarms.f 
PROD_SRCS += parse.f 
PROD_SRCS += make_dat.f
PROD_SRCS += ezcaFort.c

# FIXME: this will try to instal into non-existing directory
# and because it will fail, the executable will stay in the right place
# which is ../bin/linux-x86/
# Correct will be to have 
PROD_HOST = hvca
#PROD_HOST = $(TOP)/hvcaApp/bin/$(T_A)/hvca

ifeq ($(shell uname -s), SunOS)
    OS=solaris
else

ifeq ($(shell uname -s), Linux)
    OS=Linux
else
    OS=UNDEFINED_OPERATING_SYSTEM_$(shell uname -s)
endif

endif
USR_INCLUDES += -I$(EPICS)/base/include 
USR_INCLUDES += -I$(EPICS)/extensions/include 
USR_INCLUDES += -I$(EPICS)/base/include/os/$(OS)

SHRLIB_SEARCH_DIRS += /usr/lib
SHRLIB_SEARCH_DIRS += $(EPICS)/base/lib/$(EPICS_HOST_ARCH) 
SHRLIB_SEARCH_DIRS += $(EPICS)/extensions/lib/$(EPICS_HOST_ARCH)

#LIBS = -lezca -lca -lCom -lsocket -lnsl
USR_LIBS += ezca
USR_LIBS += ca
USR_LIBS += Com
USR_LIBS += nsl

# LD will be f77
CCC=f77

include $(TOP)/configure/RULES

%.o : ../%.f
	f77 -fno-second-underscore -o $@ -c $<
