#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), configure)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *App))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocBoot))
# Build our medm links
DIRS := $(DIRS) $(filter-out $(DIRS), medm)


define DIR_template
 $(1)_DEPEND_DIRS = configure
endef
$(foreach dir, $(filter-out configure,$(DIRS)),$(eval $(call DIR_template,$(dir))))

iocBoot_DEPEND_DIRS += $(filter %App,$(DIRS))

# TODO (wmoore): see how we can handle the dependencies of vxWorks ioc Apps
classc1App_DEPEND_DIRS += $(filter %App,$(DIRS))
classc4App_DEPEND_DIRS += $(filter %App,$(DIRS))
classc6App_DEPEND_DIRS += $(filter %App,$(DIRS))
classc8App_DEPEND_DIRS += $(filter %App,$(DIRS))

include $(TOP)/configure/RULES_TOP


