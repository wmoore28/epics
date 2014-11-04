TOP = ..
include $(TOP)/configure/CONFIG
DIRS += $(wildcard *ioc*)
DIRS += $(wildcard as*)
include $(CONFIG)/RULES_DIRS

# Fix for cdCommands:
#	When compiling on clonioc* machines, the paths in cdCommands don't match the
#	filesystem on clon10 (the vxWorks boot host).  So we remove /misc if it 
#	exists in the paths.
install:
	$(ECHO) "Fix cdCommands to match vxWorks boot host (clon10)"
	$(foreach file, $(shell find ./*ioc*/ -name "cdCommands" -type f), sed -i "s/\/misc//" $(file); )
