TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
DB_INSTALLS += $(AUTOSAVE)/asApp/Db/save_restoreStatus.db
DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminSoft.db

DB    += anova.db
PROTO += anova.proto
REQ   += anova_settings.req

DB    += thermoSci.db
PROTO += thermoSci.proto

DB    += presto.db
PROTO += presto.proto
REQ   += presto_settings.req

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

