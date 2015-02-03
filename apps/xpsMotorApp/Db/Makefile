TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this
#DB += xxx.db
DB += xpsMotor.substitutions
DB += XPSAux.substitutions
DB += XPSAux_1.substitutions
DB += xpsMotor_1.substitutions
DB += xpsHallD.substitutions
DB += xpsTaggerHall.substitutions
DB += xpsPCO.substitutions
DB += xpsPVT.substitutions
DB += collimators.db
DB += radiators.db
DB += converters.db
DB += harp.db
DB += xpsPCO.substitutions
DB += XPS_PCO.template
DB += xpsGoniometer.substitutions
DB += xpsHarp.substitutions
DB += XPS2_Aux_ai.substitutions
DB += XPS3_Aux_ai.substitutions
DB += XPSAuxAi.db
DB += XPSAuxAiTrig.db
DB += XPS_GroupIKED.template
DB += collimatorScan.substitutions
DB += beamCheck4scan.db 

#DB += saveData.req

MOTOR_DB_LOC=$(MOTOR)/db

DB += $(MOTOR_DB_LOC)/motor.db
DB += $(MOTOR_DB_LOC)/basic_motor.db
DB += $(MOTOR_DB_LOC)/basic_asyn_motor.db
#DB += $(MOTOR_DB_LOC)/XPSAuxAi.db
DB += $(MOTOR_DB_LOC)/XPSAuxAo.db
DB += $(MOTOR_DB_LOC)/XPSAuxBi.db
DB += $(MOTOR_DB_LOC)/XPSAuxBo.db
DB += $(MOTOR_DB_LOC)/XPSAuxLi.db
DB += $(MOTOR_DB_LOC)/XPSAuxLo.db
DB += $(MOTOR_DB_LOC)/XPS_extra.db
#DB += $(MOTOR_DB_LOC)/ACRAux.template
#DB += $(MOTOR_DB_LOC)/ACRAuxRead.template
#DB += $(MOTOR_DB_LOC)/ACRAuxLi.template
#DB += $(MOTOR_DB_LOC)/ACRAuxBi.template
#DB += $(MOTOR_DB_LOC)/ACRAuxBo.template
#DB += $(MOTOR_DB_LOC)/ACRAuxBoRBV.template
DB += $(MOTOR_DB_LOC)/TransPos.db
DB += $(MOTOR_DB_LOC)/motorUtil.db
DB += $(MOTOR_DB_LOC)/asyn_motor.db
#DB += $(MOTOR_DB_LOC)/profileMoveController.template
#DB += $(MOTOR_DB_LOC)/profileMoveAxis.template
#DB += $(MOTOR_DB_LOC)/profileMoveControllerXPS.template
#DB += $(MOTOR_DB_LOC)/profileMoveAxisXPS.template

SSCAN_DB_LOC=$(SSCAN)/sscanApp/Db
DB += $(SSCAN_DB_LOC)/saveData.db
DB += $(SSCAN_DB_LOC)/scanProgress.db
DB += $(SSCAN_DB_LOC)/standardScans.db


REQ += collimatorScan.req
REQ += motorsHallD.req
REQ += motorsTaggerHall.req

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

