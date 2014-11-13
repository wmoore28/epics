TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install)
# databases, templates, substitutions like this

DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminVxWorks.db #(VxWorks IOCs)
#DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminRTEMS.db   (RTEMS   IOCs)
#DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminSoft.db    (soft    IOCs)
#DB_INSTALLS += $(DEVIOCSTATS)/db/access.db          (if required by next step)
#DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminScanMon.db (optional - ONLY if SCAN
#                                                     monitoring is required)

IOCRELEASE_DB += iocRelease.db


#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

