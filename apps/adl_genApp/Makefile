TOP=..

include $(TOP)/configure/CONFIG

OBJS_vxWorks = -nil-
OBJS_DEFAULT = adl_gen
SRCS += adl_gen.c

include $(TOP)/configure/RULES

#TODO: these files should likely be in repo, not copied from ~epics.
#adl_gen.c: $(EPICS_DIST)/adl_generate.tar.gz
adl_gen.c: ~epics/dist/adl_generate.tar.gz
	gzip -cd $< | tar xvf - ; \
	touch adl_gen.c

clean::
	$(RM) adl_def.h
	$(RM) adl_gen.c
	$(RM) adl_gen.d
	$(RM) adl_gen.h
	$(RM) adl_gen.o
	$(RM) adl-help.ps
	$(RM) adl-tech.ps

realclean:: clean
