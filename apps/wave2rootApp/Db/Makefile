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

DB += wave2root.substitutions
DB += wave2rootData.db
DB += wave2rootCtrl.db

#Install the IOC status reporting DB
DEVIOCSTAT_LOC=$(DEVIOCSTATS)/db
DB += $(DEVIOCSTAT_LOC)/iocAdminSoft.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE


