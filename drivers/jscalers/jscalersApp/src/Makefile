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

PROD_LIBS += jscalers

LIBRARY_Linux += jscalers
PROD_Linux += scalers_test

INC += common.h
INC += jscalers.h

#===========================
PROD_LIBS    += rol
rol_DIR      += $(CODA_LIB)
rol_DIR      += $(ROL_LIB)
USR_INCLUDES += $(ROL_INCLUDE)

PROD_LIBS += mysql4.1.20
mysql4.1.20_DIR += $(MYSQL_LIB)

#===========================
include $(TOP)/configure/RULES

