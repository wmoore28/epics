import sys

class FEB:
    def __init__(self,febid, hybrids,dna, layer):
        self.id = febid
        self.hybrids = hybrids
        self.dna = dna
        self.layer = layer

            
febs= [
    FEB(2,[0,1],"0x14084072beb01c00","L1t"),
    FEB(0,[0,1,2,3],"0x42084072beb01400","L2-3t"),
    FEB(5,[0,1,2,3],"0x58d0472beb01400","L4t"),
    FEB(8,[0,1,2,3],"0x52814100a1b01c00","L5t"),
    FEB(7,[0,1,2,3],"0x50814100a1b01c00","L6t"),
    FEB(9,[0,1],"0x24d04072beb01c00","L1b"),
    FEB(6,[0,1,2,3],"0x02d04072beb01c00","L2-3b"),
    FEB(1,[0,1,2,3],"0x72814100a1b01c00","L4b"),
    FEB(4,[0,1,2,3],"0x1c084072beb01400","L5b"),
    FEB(3,[0,1,2,3],"0x70d04072beb01c00","L6b"),
    ]





def getLayer(febid):
    layer=""
    for feb in febs:
        if feb.id ==febid:
            if layer=="":
                layer = feb.layer
            else:
                print "ERROR: found two febs with ID ", id
                sys.exit(1)
    return layer

def getDna(febid):
    layer=""
    for feb in febs:
        if feb.id ==febid:
            if layer=="":
                layer = feb.dna
            else:
                print "ERROR: found two febs with ID ", id
                sys.exit(1)
    return layer






def buildHybLV():


    s = """


record(sub,SVT:lv:FEBID:HYBID:dvdd:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:avdd:i_rd")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:i_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:i_rd_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:avdd:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:v125:i_rd")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:i_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:i_rd_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:dvdd:vn")
}

record(ai, SVT:lv:FEBID:HYBID:v125:i_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:i_rd_sub PP")
  field(DTYP,"Soft Channel")
}






record(sub,SVT:lv:FEBID:HYBID:dvdd:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:avdd:vn")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:vn)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:vn_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:avdd:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:v125:vn")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:vn)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:vn_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:dvdd:vf")
}

record(ai, SVT:lv:FEBID:HYBID:v125:vn)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:vn_sub PP")
  field(DTYP,"Soft Channel")
}






record(sub,SVT:lv:FEBID:HYBID:dvdd:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:avdd:vf")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:vf)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:vf_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:avdd:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:v125:vf")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:vf)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:vf_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:dvdd:v_set_rd")
}

record(ai, SVT:lv:FEBID:HYBID:v125:vf) {
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:vf_sub PP")
  field(DTYP,"Soft Channel")
}






record(sub,SVT:lv:FEBID:HYBID:dvdd:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:avdd:v_set_rd")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:v_set_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:avdd:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"SVT:lv:FEBID:HYBID:v125:v_set_rd")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:v_set_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")    
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:v125:v_set_rd)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
}






record(sub,SVT:lv:FEBID:HYBID:dvdd:v_set_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ao, SVT:lv:FEBID:HYBID:dvdd:v_set) {
  field(OUT, "SVT:lv:FEBID:HYBID:dvdd:v_set_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:avdd:v_set_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ao, SVT:lv:FEBID:HYBID:avdd:v_set) {
  field(OUT, "SVT:lv:FEBID:HYBID:avdd:v_set_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:v_set_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ao, SVT:lv:FEBID:HYBID:v125:v_set) {
  field(OUT, "SVT:lv:FEBID:HYBID:v125:v_set_sub PP")
  field(DTYP,"Soft Channel")
}




"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dvdd:i_rd"
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s
            if hyb==3:
                if feb < 9:
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(0))
                    rec = rec.replace("NEXTFEBID",str(feb+1))					
                else:
                    rec = rec.replace("FLNKNEXTHYB","")                    
            else:
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTFEBID",str(feb))
                rec = rec.replace("NEXTHYBID",str(hyb+1))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records








def buildHybLVStat():


    s = """


record(sub,SVT:lv:FEBID:HYBID:dvdd:stat_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:stat)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:stat_sub PP")
  field(DTYP,"Soft Channel")
}


record(sub,SVT:lv:FEBID:HYBID:avdd:stat_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:stat)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:stat_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:v125:stat_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
}

record(ai, SVT:lv:FEBID:HYBID:v125:stat)
{
  field(SCAN, "Passive") field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:stat_sub PP")
  field(DTYP,"Soft Channel")
}

record(calc, SVT:lv:FEBID:HYBID:stat)
{
  field(SCAN, "Passive")
  field(CALC, "A&&B&&C")
  field(INPA, "SVT:lv:FEBID:HYBID:dvdd:stat.VAL PP")
  field(INPB, "SVT:lv:FEBID:HYBID:avdd:stat.VAL PP")
  field(INPC, "SVT:lv:FEBID:HYBID:v125:stat.VAL PP")
  field(FLNK,"FLNKNEXTHYB")
  
}



"""


    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:stat"
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s
            if hyb==3:
                if feb < 9:
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(0))
                    rec = rec.replace("NEXTFEBID",str(feb+1))					
                else:
                    rec = rec.replace("FLNKNEXTHYB","")                    
            else:
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTFEBID",str(feb))
                rec = rec.replace("NEXTHYBID",str(hyb+1))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records


  







def buildHybLVSwitch():


    s = """



record(sub,SVT:lv:FEBID:HYBID:all:switch_sub)
{
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(SCAN,"Passive")
    field(FLNK,"SVT:lv:FEBID:HYBID:all:switch_fanout")
}

record(bo, SVT:lv:FEBID:HYBID:all:switch)
{
    field(OUT, "SVT:lv:FEBID:HYBID:all:switch_sub PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "supervisory")
}

record(fanout,SVT:lv:FEBID:HYBID:all:switch_fanout)
{
    field(LNK1,"SVT:lv:FEBID:HYBID:dvdd:switch")
    field(LNK2,"SVT:lv:FEBID:HYBID:avdd:switch")
    field(LNK3,"SVT:lv:FEBID:HYBID:v125:switch")
}


record(bo, SVT:lv:FEBID:HYBID:dvdd:switch)
{
    field(DOL, "SVT:lv:FEBID:HYBID:all:switch PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "closed_loop")
}

record(bo, SVT:lv:FEBID:HYBID:avdd:switch)
{
    field(DOL, "SVT:lv:FEBID:HYBID:all:switch PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "closed_loop")
}

record(bo, SVT:lv:FEBID:HYBID:v125:switch)
{
    field(DOL, "SVT:lv:FEBID:HYBID:all:switch PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "closed_loop")
}



"""
    
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    

    for feb in range(0,10):
        s = """
record(dfanout,SVT:lv:"""+str(feb)+""":all:switch_fanout)
{
"""
        if feb == 2 or feb ==9:
            r = range(0,2)
        else:
            r = range(0,4)
        link = ["OUTA","OUTB","OUTC","OUTD"]
        for hyb in r:
            s += "    field(" + link[hyb]+",\"SVT:lv:"+str(feb)+":"+str(hyb)+":all:switch.VAL PP\") " + "\n"
        s += "}\n\n"
        s += " record(bo, SVT:lv:"+str(feb)+":all:switch)" + "\n" + "{\n"
        s += "\n\tfield(OUT, \"SVT:lv:"+str(feb)+":all:switch_fanout PP\")\n\tfield(ZNAM, \"Off\")\n\tfield(ONAM, \"On\")\n}\n"
        records.append(s)
    

    

    s = """
record(dfanout,SVT:lv:hyb:all:switch_fanout)
{
    field(OUTA,"SVT:lv:hyb:all:switch_fanout1.VAL PP")
    field(OUTB,"SVT:lv:hyb:all:switch_fanout2.VAL PP")
}

record(dfanout,SVT:lv:hyb:all:switch_fanout1)
{
    field(OUTA,"SVT:lv:0:all:switch.VAL PP")
    field(OUTB,"SVT:lv:1:all:switch.VAL PP")
    field(OUTC,"SVT:lv:2:all:switch.VAL PP")
    field(OUTD,"SVT:lv:3:all:switch.VAL PP")
    field(OUTE,"SVT:lv:4:all:switch.VAL PP")
}

record(dfanout,SVT:lv:hyb:all:switch_fanout2)
{
    field(OUTA,"SVT:lv:5:all:switch.VAL PP")
    field(OUTB,"SVT:lv:6:all:switch.VAL PP")
    field(OUTC,"SVT:lv:7:all:switch.VAL PP")
    field(OUTD,"SVT:lv:8:all:switch.VAL PP")
    field(OUTE,"SVT:lv:9:all:switch.VAL PP")
}

record(bo, SVT:lv:hyb:all:switch) 
{
field(OUT, "SVT:lv:hyb:all:switch_fanout PP")
  field(ZNAM, "Off")
  field(ONAM, "On")
}

"""

    records.append(s)
  
    
    return records







def buildHybTemp():

    

    s = """
record(sub,SVT:temp:hyb:FEBID:HYBID:temp0:t_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subTempInit")
    field(SNAM,"subTempProcess")
    field(FLNK,"SVT:temp:hyb:FEBID:HYBID:temp1:t_rd")
}

record(ai, SVT:temp:hyb:FEBID:HYBID:temp0:t_rd) {
  field(SCAN, "Passive") field(PREC, "1")
  field(INP, "SVT:temp:hyb:FEBID:HYBID:temp0:t_rd_sub PP")
  field(DTYP,"Soft Channel")
}


record(sub,SVT:temp:hyb:FEBID:HYBID:temp1:t_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subTempInit")
    field(SNAM,"subTempProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:temp:hyb:FEBID:HYBID:temp1:t_rd) {
  field(SCAN, "Passive") field(PREC, "1")
  field(INP, "SVT:temp:hyb:FEBID:HYBID:temp1:t_rd_sub PP")
  field(DTYP,"Soft Channel")
}
"""

    s_flnk = "SVT:temp:hyb:NEXTFEBID:NEXTHYBID:temp0:t_rd"
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s
            if hyb==3:
                if feb < 9:
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(0))
                    rec = rec.replace("NEXTFEBID",str(feb+1))
                else:
                    rec = rec.replace("FLNKNEXTHYB","")                    
            else:
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTHYBID",str(hyb+1))
                rec = rec.replace("NEXTFEBID",str(feb))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records


def buildFebTemp():

    s = """
record(sub,SVT:temp:fe:FEBID:axixadc:t_rd_sub)
{
    field(SCAN, "Passive")
    field(INAM,"subTempInit")
    field(SNAM,"subTempProcess")
    field(FLNK,"SVT:temp:fe:FEBID:FebTemp0:t_rd")
}

record(ai, SVT:temp:fe:FEBID:axixadc:t_rd) {
    field(SCAN, "Passive") field(PREC, "1")
    field(INP, "SVT:temp:fe:FEBID:axixadc:t_rd_sub PP")
    field(DTYP,"Soft Channel")
}

record(sub,SVT:temp:fe:FEBID:FebTemp0:t_rd_sub)
{
    field(SCAN, "Passive")
    field(INAM,"subTempInit")
    field(SNAM,"subTempProcess")
    field(FLNK,"SVT:temp:fe:FEBID:FebTemp1:t_rd")
}

record(ai, SVT:temp:fe:FEBID:FebTemp0:t_rd) {
    field(SCAN, "Passive") field(PREC, "1")
    field(INP, "SVT:temp:fe:FEBID:FebTemp0:t_rd_sub PP")
    field(DTYP,"Soft Channel")
}

record(sub,SVT:temp:fe:FEBID:FebTemp1:t_rd_sub)
{
    field(SCAN, "Passive")
    field(INAM,"subTempInit")
    field(SNAM,"subTempProcess")
    field(FLNK,"FLNKNEXTFEB")
}

record(ai, SVT:temp:fe:FEBID:FebTemp1:t_rd) {
    field(SCAN, "Passive") field(PREC, "1")
    field(INP, "SVT:temp:fe:FEBID:FebTemp1:t_rd_sub PP")
    field(DTYP,"Soft Channel")
}

"""

    s_flnk = "SVT:temp:fe:NEXTFEBID:axixadc:t_rd"

    records = []
    for feb in range(0,10):
        rec = s
        # take care of the flnk to the next feb
        if feb==9:
            rec = rec.replace("FLNKNEXTFEB","")
        else:
            rec = rec.replace("FLNKNEXTFEB",s_flnk)            
        rec = rec.replace("NEXTFEBID",str(feb+1))
        rec = rec.replace("FEBID",str(feb))
        records.append(rec)
    
    return records


def buildHybSync():

    

    s = """
record(aSub,SVT:lv:FEBID:HYBID:sync:sync_rd_asub)
{
    field(SCAN,"Passive")
    field(INAM,"subSyncInit")
    field(SNAM,"subSyncProcess")
    field(OUTA,"SVT:lv:FEBID:HYBID:sync:sync_rd PP")
    field(FTVA,"STRING")
    field(FLNK,"FLNKNEXTHYB")
}

record(stringin, SVT:lv:FEBID:HYBID:sync:sync_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}
"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:sync:sync_rd_asub"
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s
            if hyb==3:
                if feb < 9:
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(0))
                    rec = rec.replace("NEXTFEBID",str(feb+1))
                else:
                    rec = rec.replace("FLNKNEXTHYB","")                    
            else:
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTHYBID",str(hyb+1))
                rec = rec.replace("NEXTFEBID",str(feb))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records


def buildHybSyncBase():

    s = """
record(aSub,SVT:daq:$(FEB):$(HYB):$(APV):syncbase_rd_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subSyncBaseInit")
    field(SNAM,"subSyncBaseProcess")
    field(OUTA,"SVT:daq:$(FEB):$(HYB):$(APV):syncbase_rd PP")
    field(FTVA,"STRING")
}

record(stringin, SVT:daq:$(FEB):$(HYB):$(APV):syncbase_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}


record(aSub,SVT:daq:$(FEB):$(HYB):$(APV):syncpeak_rd_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subSyncBaseInit")
    field(SNAM,"subSyncBaseProcess")
    field(OUTA,"SVT:daq:$(FEB):$(HYB):$(APV):syncpeak_rd PP")
    field(FTVA,"STRING")
}

record(stringin, SVT:daq:$(FEB):$(HYB):$(APV):syncpeak_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}


"""
    return s




def buildDpmMap():

    

    s = """
record(sub,SVT:lv:FEBID:HYBID:dpm:dpm_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
	field(FLNK,"SVT:lv:FEBID:HYBID:datapath:datapath_rd")
}

record(ai, SVT:lv:FEBID:HYBID:dpm:dpm_rd) {
  field(SCAN, "Passive") field(PREC, "1")
  field(INP, "SVT:lv:FEBID:HYBID:dpm:dpm_rd_sub PP")
  field(DTYP,"Soft Channel")
}

record(sub,SVT:lv:FEBID:HYBID:datapath:datapath_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:datapath:datapath_rd) {
  field(SCAN, "Passive") field(PREC, "1")
  field(INP, "SVT:lv:FEBID:HYBID:datapath:datapath_rd_sub PP")
  field(DTYP,"Soft Channel")
}

"""

    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dpm:dpm_rd"
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s
            if hyb==3:
                if feb < 9:
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(0))
                    rec = rec.replace("NEXTFEBID",str(feb+1))
                else:
                    rec = rec.replace("FLNKNEXTHYB","")                    
            else:
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTHYBID",str(hyb+1))
                rec = rec.replace("NEXTFEBID",str(feb))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records





def buildLayer():
	

    s = """
record(stringin, SVT:daq:map:FEBID:dna) {
  field(SCAN, "Passive") 
  field(VAL,"DNA")
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:map:FEBID:layer) {
  field(SCAN, "Passive") 
  field(VAL,"LAYER")
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daqmap:PHYSLAYER:febid) {
  field(SCAN, "Passive") 
  field(VAL,"FEBID")
  field(DTYP,"Soft Channel")
}


"""	
    records = []
    for feb in range(0,10):
        rec = s
        rec = rec.replace("PHYSLAYER",str(getLayer(feb)))
        rec = rec.replace("FEBID",str(feb))
        rec = rec.replace("LAYER",str(getLayer(feb)))
        rec = rec.replace("DNA",str(getDna(feb)))
        records.append(rec)
        
    return records



def buildDpmState():
	
    s = """
record(aSub,SVT:daq:dpm:LAYER:state_asub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmStateInit")
    field(SNAM,"subDpmStateProcess")
    field(OUTA,"SVT:daq:dpm:LAYER:state PP")
    field(FTVA,"STRING")
    field(FLNK,"FLNKNEXTLAYER")
}

record(stringin, SVT:daq:dpm:LAYER:state) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    s_flnk = "SVT:daq:dpm:NEXTLAYER:state_asub"
    records = []
    for dpm in range(0,14):
        rec = s
        if dpm <13:
			rec = rec.replace("FLNKNEXTLAYER",s_flnk)
			rec = rec.replace("NEXTLAYER",str(dpm+1))
        else:
			rec = rec.replace("FLNKNEXTLAYER","")			
        rec = rec.replace("LAYER",str(dpm))
        records.append(rec)
    return records




def buildDpm():

    records = []
    s = """
record(sub,SVT:dpm:$(DPM):poll_xml)
{
    field(SCAN,"1 second")
    field(INAM,"subPollInit")
    field(SNAM,"subPollProcess")
    field(FLNK,"SVT:daq:dpm:$(DPM):state_asub")

}

record(aSub,SVT:daq:dpm:$(DPM):state_asub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmStateInit")
    field(SNAM,"subDpmStateProcess")
    field(OUTA,"SVT:daq:dpm:$(DPM):state PP")
    field(FTVA,"STRING")
}

record(stringin, SVT:daq:dpm:$(DPM):state) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    records.append(s)
    return records


def buildDtm():

    records = []
    s = """
record(sub,SVT:dtm:$(DTM):poll_xml)
{
    field(SCAN,"1 second")
    field(INAM,"subPollInit")
    field(SNAM,"subPollProcess")
    field(FLNK,"SVT:daq:dtm:$(DTM):state_asub")

}

record(aSub,SVT:daq:dtm:$(DTM):state_asub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmStateInit")
    field(SNAM,"subDpmStateProcess")
    field(OUTA,"SVT:daq:dtm:$(DTM):state PP")
    field(FTVA,"STRING")
}

record(stringin, SVT:daq:dtm:$(DTM):state) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    records.append(s)
    return records




def buildDpmFebNum():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):$(DP):febnum_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmFebNumInit")
    field(SNAM,"subDpmFebNumProcess")
}

record(longin, SVT:daq:dpm:$(DPM):$(DP):febnum) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):$(DP):febnum_sub PP")
  field(DTYP,"Soft Channel")
}


"""	
    records.append(s)
    return records


def buildDpmHybNum():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):$(DP):hybnum_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmFebNumInit")
    field(SNAM,"subDpmFebNumProcess")
}

record(longin, SVT:daq:dpm:$(DPM):$(DP):hybnum) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):$(DP):hybnum_sub PP")
  field(DTYP,"Soft Channel")
}


"""	
    records.append(s)
    return records


def buildDpmLink():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):$(DP):TYPE_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmLinkInit")
    field(SNAM,"subDpmLinkProcess")
}

record(longin, SVT:daq:dpm:$(DPM):$(DP):TYPE) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):$(DP):TYPE_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    types = ["rxphyready", "rxframecount", "rxframeerrorcount", "rxcellerrorcount", "rxlinkerrorcount", "rxlinkdowncount"]
    for type in types:
        rec = s
        rec = rec.replace("TYPE",type)
        records.append(rec)
    return records


def buildDpmEventCount():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):eventcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmEventCountLinkInit")
    field(SNAM,"subDpmEventCountLinkProcess")
}

record(longin, SVT:daq:dpm:$(DPM):eventcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):eventcount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records



