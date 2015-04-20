#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG

## Define modules to build
MODULES += CAEN_HV
MODULES += HVCAENx527
MODULES += jlabVMEBoard
MODULES += jscalers
MODULES += LVMPOD
MODULES += snmp-nscl-1-0-RC9
MODULES += svtDaqLib
MODULES += v450
MODULES += v450_PRB

## Define dependencies
LVMPOD_DEPEND_DIRS += snmp-nscl-1-0-RC9


DIRS := $(DIRS) $(filter-out $(DIRS), configure)
DIRS := $(DIRS) $(filter-out $(DIRS), $(MODULES))

define DIR_template
 $(1)_DEPEND_DIRS += configure
endef
$(foreach dir, $(filter-out configure,$(DIRS)),$(eval $(call DIR_template,$(dir))))

include $(TOP)/configure/RULES_TOP


