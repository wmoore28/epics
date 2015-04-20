#
# NOTE:
#   In configure/CONFIG_SITE, CROSS_COMPILER_TARGET_ARCHS is empty.  So only 
#   linux target is built.
#

TOP=../..
include $(TOP)/configure/CONFIG

LIB_SRCS += sy1527.c 
LIB_SRCS += sy1527epics1.c
PROD_SRC += sy1527_test.c

PROD_LIBS += sy1527epics1

PROD_LIBS += caenhvwrapper 
PROD_LIBS += hscaenet 
PROD_LIBS += pthread
hscaenet_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
caenhvwrapper_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
pthread_DIR += /usr/lib

LIBRARY += sy1527epics1
PROD += sy1527_test

INC += sy1527.h
INC += sy1527epics1.h

#===========================

PROD_LIBS += smi
PROD_LIBS += smiui
PROD_LIBS += dim

smi_DIR += $(SMIDIR)/$(ODIR)
smiui_DIR += $(SMIDIR)/$(ODIR)
dim_DIR += $(DIMDIR)/$(ODIR)

USR_INCLUDES += -I $(SMIDIR)/smixx
USR_INCLUDES += -I $(DIMDIR)/dim

#===========================
include $(TOP)/configure/RULES

