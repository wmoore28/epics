TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library

# my: comment out +++++++++++ so far I do not undertand why it is needed for 
STATIC_BUILD=YES

LIB_SRCS += jscalers.cpp

PROD_SRC += scalers_test.cpp

#PROD_LIBS += scalers_epics
PROD_LIBS += jscalers

#LIBRARY += scalers_epics
LIBRARY += jscalers
PROD += scalers_test

INC += common.h
INC += jscalers.h

#===========================
PROD_LIBS += rol
rol_DIR += /usr/local/clas12/release/0.2/coda/Linux_i686/lib
rol_DIR += /usr/local/clas12/release/0.2/coda/src/rol/Linux_i686/lib
USR_INCLUDES += -I /usr/local/clas12/release/0.2/coda/src/rol/code.s
PROD_LIBS += mysql4.1.20
mysql4.1.20_DIR += /usr/local/clas12/coda/src/mysql4.1.20/Linux_i686/lib

#===========================
include $(TOP)/configure/RULES

