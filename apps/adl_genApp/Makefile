TOP=..

include $(TOP)/configure/CONFIG

OBJS_vxWorks = -nil-
OBJS_DEFAULT = adl_gen
SRCS += adl_gen.c

include $(TOP)/configure/RULES

#adl_gen.c: $(EPICS_DIST)/adl_generate.tar.gz
adl_gen.c: ~epics/dist/adl_generate.tar.gz
	gzip -cd $< | tar xvf - ; \
	touch adl_gen.c
