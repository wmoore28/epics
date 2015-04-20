#!/usr/bin/env python
import sys

class Usage(Exception):
    def __init__(self,msg):
        self.msg = msg

def main(argv=None):
    buildBiasConfig()
    buildLVConfig()
    buildHybLVConfig()
    buildFlangeLVConfig()
    buildHybTempConfig()
    buildFebTempConfig()
    buildDaqConfig()

def isValidHyb(feb, hyb):
    if (feb==2 or feb==9) and hyb > 1:
        return False
    else:
        return True

    



def buildBiasConfig():
	
    f = open("svtBias.alhConfig","w")
    head = """#===============================================================================
# SVT Bias Voltage Alarm Config
#===============================================================================

GROUP NULL BIAS
$GUIDANCE
See SVT Ops manual sections relating to voltages.
PVs monitored by these alarms are supplied by the MPOD IOC (hvCaen).
$END
"""

    s = """
CHANNEL BIAS SVT:bias:CHANNELTEMPLATE:i_rd
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:bias:CHANNELTEMPLATE:i_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The current readback from this bias channel is abnormally high.
Contact the SVT expert if the cause of this alarm is not understood.
$END

CHANNEL BIAS SVT:bias:CHANNELTEMPLATE:v_term
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:bias:CHANNELTEMPLATE:v_term" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The voltage readback from this bias channel is out of spec.
Possible causes:
    The bias channel is turned off.
    The sensor is behaving abnormally and the HV supply is current-limited (check the status and current readback for this channel).
    The bias voltage was set incorrectly.
The bias voltage specified by SVT procedures is 180 V, unless the SVT expert has decided otherwise.
Contact the SVT expert if the cause of this alarm is not understood.
$END

CHANNEL BIAS SVT:bias:CHANNELTEMPLATE:stat
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:bias:CHANNELTEMPLATE:stat" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
This bias channel is off, or in an abnormal state.
A value of 0 means this bias channel is off.
    If the beam-bias interlock is enabled, all bias channels will be turned off when the beam is lost.
    If the beam was just lost, follow the procedure for responding to a beam trip.
A value of 40 means this bias channel is in "Interlock" state, and must be reset.
    Follow the procedure for responding to an MPOD trip.
    When the trip has cleared, press the "RESET INTERLOCKS" button on the SVT Bias GUI.
Contact the SVT expert if the cause of this alarm is not understood.
$END
"""	
    f.write(head)
    for hyb in range(0,18):
        f.write(s.replace("CHANNELTEMPLATE","top:"+str(hyb)))
    for hyb in range(20,38):
        f.write(s.replace("CHANNELTEMPLATE","bot:"+str(hyb)))

def buildHybLVConfig():
	
    f = open("svtHybLV.alhConfig","w")
    head = """#===============================================================================
# SVT Hybrid Low Voltage Alarm Config
#===============================================================================

GROUP NULL HYBRID_LV
$GUIDANCE
See SVT Ops manual sections relating to voltages.
PVs monitored by these alarms are supplied by the SVT DAQ IOCs.
$END
"""

    s = """
CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:avdd:i_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:avdd:i_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids is drawing an abnormal amount of current on its AVDD low voltage supply.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:dvdd:i_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:dvdd:i_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids is drawing an abnormal amount of current on its DVDD low voltage supply.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:v125:i_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:v125:i_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids is drawing an abnormal amount of current on its V125 low voltage supply.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:avdd:v_set_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:avdd:v_set_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids has an abnormal setting for its AVDD low voltage trim.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:dvdd:v_set_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:dvdd:v_set_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids has an abnormal setting for its DVDD low voltage trim.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:v125:v_set_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:v125:v_set_rd" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
One of the SVT hybrids has an abnormal setting for its V125 low voltage trim.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:avdd:vn A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:avdd:vn" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
The AVDD supply terminal voltage for one of the SVT hybrids is out of its normal range.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:dvdd:vn A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:dvdd:vn" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
The DVDD supply terminal voltage for one of the SVT hybrids is out of its normal range.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:v125:vn A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:v125:vn" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
The V125 supply terminal voltage for one of the SVT hybrids is out of its normal range.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:avdd:vf A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:avdd:vf" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
The AVDD sense terminal voltage for one of the SVT hybrids is out of its normal range.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:v125:vf A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:v125:vf" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
The V125 sense terminal voltage for one of the SVT hybrids is out of its normal range.
Contact the SVT expert for further guidance.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:avdd:stat A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:avdd:stat" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
This SVT hybrid low voltage channel is off, or in an abnormal state.
Contact the SVT expert if the cause of this alarm is not understood.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:dvdd:stat A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:dvdd:stat" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
This SVT hybrid low voltage channel is off, or in an abnormal state.
Contact the SVT expert if the cause of this alarm is not understood.
$END

CHANNEL HYBRID_LV SVT:lv:CHANNELTEMPLATE:v125:stat A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:v125:stat" aiaocalc_alarm.adl >> /dev/null 
$ALARMCOUNTFILTER 0 10
$GUIDANCE
This SVT hybrid low voltage channel is off, or in an abnormal state.
Contact the SVT expert if the cause of this alarm is not understood.
$END

"""
    f.write(head)
    for feb in range(0,10):
        for hyb in range(0,4):
            if isValidHyb(feb,hyb):
                f.write(s.replace("CHANNELTEMPLATE",str(feb)+":"+str(hyb)))


def buildHybTempConfig():
	
    f = open("svtHybTemp.alhConfig","w")
    head = """#===============================================================================
# SVT Hybrid Temperature Alarm Config
#===============================================================================

GROUP NULL HYBRID_TEMP
$GUIDANCE
See SVT Ops manual sections relating to cooling.
PVs monitored by these alarms are supplied by the SVT DAQ IOCs.
$END
"""

    s = """
CHANNEL HYBRID_TEMP SVT:temp:hyb:CHANNELTEMPLATE:temp0:t_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:temp:hyb:CHANNELTEMPLATE:temp0:t_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The temperature sensor on one of the SVT hybrids is reporting an abnormal temperature.
Contact the SVT expert for further guidance.
$END
"""

    f.write(head)
    for feb in range(0,10):
        for hyb in range(0,4):
            if isValidHyb(feb,hyb):
                f.write(s.replace("CHANNELTEMPLATE",str(feb)+":"+str(hyb)))

def buildFebTempConfig():
	
    f = open("svtFebTemp.alhConfig","w")
    head = """#===============================================================================
# SVT FEB Temperature Alarm Config
#===============================================================================

GROUP NULL FEB_TEMP
$GUIDANCE
See SVT Ops manual sections relating to cooling.
PVs monitored by these alarms are supplied by the SVT DAQ IOCs.
$END
"""

    s = """
CHANNEL FEB_TEMP SVT:temp:fe:CHANNELTEMPLATE:axixadc:t_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:temp:fe:CHANNELTEMPLATE:axixadc:t_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The FPGA on one of the SVT frontend boards is reporting an abnormal temperature.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_TEMP SVT:temp:fe:CHANNELTEMPLATE:FebTemp0:t_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:temp:fe:CHANNELTEMPLATE:FebTemp0:t_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
A temperature sensor on one of the SVT frontend boards is reporting an abnormal temperature.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_TEMP SVT:temp:fe:CHANNELTEMPLATE:FebTemp1:t_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:temp:fe:CHANNELTEMPLATE:FebTemp1:t_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
A temperature sensor on one of the SVT frontend boards is reporting an abnormal temperature.
Contact the SVT expert for further guidance.
$END
"""

    f.write(head)
    for feb in range(0,10):
        f.write(s.replace("CHANNELTEMPLATE",str(feb)))

def buildDaqConfig():
	
    f = open("svtDaq.alhConfig","w")
    head = """#===============================================================================
# SVT DAQ Alarm Config
#===============================================================================

GROUP NULL DAQ
$GUIDANCE
See SVT Ops manual sections relating to DAQ.
PVs monitored by these alarms are supplied by the SVT DAQ IOCs.
$END
"""

    s = """
CHANNEL DAQ SVT:lv:CHANNELTEMPLATE:sync:sync_rd A
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:CHANNELTEMPLATE:sync:sync_rd" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
One or more readout chips on this SVT hybrid have gone out of sync.
Contact the SVT expert for further guidance.
$END
"""

    f.write(head)
    for feb in range(0,10):
        for hyb in range(0,4):
            if isValidHyb(feb,hyb):
                f.write(s.replace("CHANNELTEMPLATE",str(feb)+":"+str(hyb)))

def buildLVConfig():
	
    f = open("svtLV.alhConfig","w")
    head = """#===============================================================================
# SVT FEB Low Voltage Config
#===============================================================================

GROUP NULL FEB_LV
$GUIDANCE
See SVT Ops manual sections relating to voltages.
PVs monitored by these alarms are supplied by the MPOD IOC (hvCaen).
$END
"""

    s = """
CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anan:i_rd
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anan:i_rd" aiaocalc_alarm.adl >> /dev/null
$GUIDANCE
The current supplied by this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected, or that the hybrids have not yet been turned on.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anap:i_rd
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anap:i_rd" aiaocalc_alarm.adl >> /dev/null
$GUIDANCE
The current supplied by this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected, or that the hybrids have not yet been turned on.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:digi:i_rd
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:digi:i_rd" aiaocalc_alarm.adl >> /dev/null
$GUIDANCE
The current supplied by this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected, or that the hybrids have not yet been turned on.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anan:v_term
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anan:v_term" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The terminal voltage for this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anap:v_term
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anap:v_term" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The terminal voltage for this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:digi:v_term
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:digi:v_term" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The terminal voltage for this FEB low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anan:v_sens
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anan:v_sens" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The sense terminal voltage for this FEB low voltage channel has deviated from its nominal value of 5.5 V.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anap:v_sens
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anap:v_sens" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The sense terminal voltage for this FEB low voltage channel has deviated from its nominal value of 5.5 V.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:digi:v_sens
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:digi:v_sens" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The sense terminal voltage for this FEB low voltage channel has deviated from its nominal value of 5.5 V.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anan:stat
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anan:stat" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
This FEB low voltage channel is off, or in an abnormal state.
A value of 0 means this channel is off.
A value of 40 means the PLC interlock has tripped the MPOD off.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:anap:stat
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:anap:stat" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
This FEB low voltage channel is off, or in an abnormal state.
A value of 0 means this channel is off.
A value of 40 means the PLC interlock has tripped the MPOD off.
Contact the SVT expert for further guidance.
$END

CHANNEL FEB_LV SVT:lv:fe:CHANNELTEMPLATE:digi:stat
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fe:CHANNELTEMPLATE:digi:stat" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
This FEB low voltage channel is off, or in an abnormal state.
A value of 0 means this channel is off.
A value of 40 means the PLC interlock has tripped the MPOD off.
Contact the SVT expert for further guidance.
$END

"""

    f.write(head)
    for feb in range(0,10):
        f.write(s.replace("CHANNELTEMPLATE",str(feb)))

def buildFlangeLVConfig():
	
    f = open("svtFlangeLV.alhConfig","w")
    head = """#===============================================================================
# SVT Flange Board Low Voltage Config
#===============================================================================

GROUP NULL FLANGE_LV
$GUIDANCE
See SVT Ops manual sections relating to voltages.
PVs monitored by these alarms are supplied by the MPOD IOC (hvCaen).
$END
"""

    s = """
CHANNEL FLANGE_LV SVT:lv:fl:CHANNELTEMPLATE:i_rd
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fl:CHANNELTEMPLATE:i_rd" aiaocalc_alarm.adl >> /dev/null
$GUIDANCE
The current supplied by this flange board low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected, or that the hybrids have not yet been turned on.
Contact the SVT expert for further guidance.
$END

CHANNEL FLANGE_LV SVT:lv:fl:CHANNELTEMPLATE:v_term
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fl:CHANNELTEMPLATE:v_term" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The terminal voltage for this flange board low voltage channel has deviated from its normal value.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FLANGE_LV SVT:lv:fl:CHANNELTEMPLATE:v_sens
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fl:CHANNELTEMPLATE:v_sens" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
The sense terminal voltage for this flange board low voltage channel has deviated from its nominal value of 5.5 V.
This usually indicates the channel is overloaded or disconnected.
Contact the SVT expert for further guidance.
$END

CHANNEL FLANGE_LV SVT:lv:fl:CHANNELTEMPLATE:stat
$COMMAND  medm -x -attach -cmap -macro "sig=SVT:lv:fl:CHANNELTEMPLATE:stat" aiaocalc_alarm.adl >> /dev/null 
$GUIDANCE
This flange board low voltage channel is off, or in an abnormal state.
A value of 0 means this channel is off.
A value of 40 means the PLC interlock has tripped the MPOD off.
Contact the SVT expert for further guidance.
$END

"""

    f.write(head)
    for fl in range(0,4):
        f.write(s.replace("CHANNELTEMPLATE",str(fl)))

if __name__ == "__main__":
    sys.exit(main());
