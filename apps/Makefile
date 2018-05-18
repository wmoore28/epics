#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), configure)
#DIRS := $(DIRS) $(filter-out $(DIRS), CAEN_HV)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *App))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocBoot))
# Build our medm links
DIRS := $(DIRS) $(filter-out $(DIRS), medm)

# List any drivers, they need to be built first.
#DRVS := CAEN_HV

#define DIR_template
# $(1)_DEPEND_DIRS = configure $(DRVS)
#endef
$(foreach dir, $(filter-out configure,$(DIRS)),$(eval $(call DIR_template,$(dir))))

iocBoot_DEPEND_DIRS += $(filter %App,$(DIRS))

# TODO (wmoore): see how we can handle the dependencies of vxWorks ioc Apps
classc1App_DEPEND_DIRS += bomApp harp_genericApp scaler_cApp scaler_dApp scaler_eApp XY240App
classc4App_DEPEND_DIRS += beam_stopperApp frwd_scalerApp harp_genericApp scalerApp sixty_hzApp  
classc6App_DEPEND_DIRS += btaApp
classc8App_DEPEND_DIRS += struckDaqApp

hvcaApp_DEPEND_DIRS    += adl_genApp
generalApp_DEPEND_DIRS += hvcaApp
svtDaqApp_DEPEND_DIRS    += svtDaqLibExtApp
svtDaqDpmApp_DEPEND_DIRS += svtDaqLibExtApp

include $(TOP)/configure/RULES_TOP

.PHONY: install clean
install:
	@$(ECHO) "Making symlinks for old adl files..."
	linkmaker.sh

clean:
	@$(ECHO) "Removing any symlinks created for old adl files..."
	@if [ -a linkmaker.txt ]; \
	then \
		$(RM) `cat linkmaker.txt`; \
		$(RM) linkmaker.txt; \
	fi
