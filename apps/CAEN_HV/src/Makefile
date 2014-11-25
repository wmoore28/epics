TOP = ../..
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), Driver)
DIRS := $(DIRS) $(filter-out $(DIRS), IocShell)

IocShell_DEPEND_DIRS += Driver 

include $(TOP)/configure/RULES_TOP
