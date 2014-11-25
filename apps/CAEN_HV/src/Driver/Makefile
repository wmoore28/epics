TOP=../../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC support library
LIBRARY_Linux += sy1527epics1

LIB_SRCS += sy1527.c 
LIB_SRCS += sy1527epics1.c

#=============================
# Build product executables

PROD_Linux += sy1527_test

PROD_SRC += sy1527_test.c

PROD_LIBS += sy1527epics1
PROD_LIBS += caenhvwrapper 
PROD_LIBS += hscaenet 
PROD_LIBS += pthread
PROD_LIBS += smi
PROD_LIBS += smiui
PROD_LIBS += dim

hscaenet_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
caenhvwrapper_DIR += $(CLAS)/clon/src/caen/CAENHVControlSoftware-1.1.2/lib
pthread_DIR  += /usr/lib
smi_DIR      += $(SMIDIR)/$(ODIR)
smiui_DIR    += $(SMIDIR)/$(ODIR)
dim_DIR      += $(DIMDIR)/$(ODIR)

USR_INCLUDES += -I $(SMIDIR)/smixx
USR_INCLUDES += -I $(DIMDIR)/dim

#===========================
include $(TOP)/configure/RULES

