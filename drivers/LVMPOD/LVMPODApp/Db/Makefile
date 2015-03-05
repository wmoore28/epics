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
DB += readConfigGlobalMPOD.db
DB += readConfigChassisMPOD.db
DB += readConfigBoardsMPOD.db

DB += mpod_chassis.db
DB += ehs_f_201pf.db
DB += ehs_f_205pf.db
DB += ehs_f_210pf.db
DB += mpv_8008.db
DB += mpv_8008l.db
DB += mpv_8030.db
DB += mpv_8030l.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

