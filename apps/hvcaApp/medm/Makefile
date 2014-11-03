TOP=../..

include $(TOP)/configure/CONFIG

PROD_SRCS += hv_adl.c 
PROD_SRCS += display.c  
PROD_SRCS += get_crate_nos.c 
PROD_SRCS += get_groupname.c 
PROD_SRCS += make_gui.c 
PROD_SRCS += make_pvname.c 
PROD_SRCS += make_snap.c 
PROD_SRCS += menu_gui.c

USR_INCLUDES += -I$(TOP)/adl_genApp
PROD_OBJS += $(TOP)/adl_genApp/O.$(T_A)/adl_gen

# FIXME: this will try to instal into non-existing directory 
# and because it will fail, the executable will stay in the right place 
# which is ../bin/linux-x86/ 
# Correct will be to have 
PROD_HOST = hv_adl
#PROD_HOST = $(TOP)/hvca/bin/$(T_A)/hv_adl

include $(TOP)/configure/RULES

