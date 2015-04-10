import sys

class Hybrid:
    def __init__(self,id,layer,side, type):
        self.id = id
        self.layer = layer
        self.side = side
        self.type = type
        self.templimit = None

class FEB:
    def __init__(self,febid, hybrids, dna, layer):
        self.id = febid
        self.hybrids = hybrids
        self.dna = dna
        self.layer = layer

class TempLimit:
    def __init__(self,LOLO,LO,HI,HIHI):
        self.LOLO = LOLO
        self.LO = LO
        self.HI = HI
        self.HIHI = HIHI

            
febs= [
    FEB(2,[Hybrid(0,"L1b","electron","stereo"),Hybrid(1,"L1b","electron","axial")],"0x14084072beb01c00","L1b"),
    FEB(0,[Hybrid(0,"L2b","electron","stereo"),Hybrid(1,"L2b","electron","axial"),Hybrid(2,"L3b","electron","stereo"),Hybrid(3,"L3b","electron","axial")],"0x42084072beb01400","L2-3b"),
    FEB(5,[Hybrid(0,"L4t","electron","axial"),Hybrid(1,"L4t","positron","axial"),Hybrid(2,"L4t","electron","stereo"),Hybrid(3,"L4t","positron","stereo")],"0x58d0472beb01400","L4t"),
    FEB(8,[Hybrid(0,"L5t","electron","axial"),Hybrid(1,"L5t","positron","axial"),Hybrid(2,"L5t","electron","stereo"),Hybrid(3,"L5t","positron","axial")],"0x52814100a1b01c00","L5t"),
    FEB(7,[Hybrid(0,"L6t","electron","axial"),Hybrid(1,"L6t","positron","axial"),Hybrid(2,"L6t","electron","stereo"),Hybrid(3,"L6t","positron","axial")],"0x50814100a1b01c00","L6t"),
    FEB(9,[Hybrid(0,"L1t","electron","axial"),Hybrid(1,"L1t","electron","stereo")],"0x24d04072beb01c00","L1t"),
    FEB(6,[Hybrid(0,"L2t","electron","axial"),Hybrid(1,"L2t","electron","stereo"),Hybrid(2,"L3t","electron","axial"),Hybrid(3,"L3t","electron","stereo")],"0x02d04072beb01c00","L2-3t"),
    FEB(1,[Hybrid(0,"L4b","electron","stereo"),Hybrid(1,"L4b","positron","stereo"),Hybrid(2,"L4b","electron","axial"),Hybrid(3,"L4b","positron","axial")],"0x72814100a1b01c00","L4b"),
    FEB(4,[Hybrid(0,"L5b","electron","stereo"),Hybrid(1,"L5b","positron","stereo"),Hybrid(2,"L5b","electron","axial"),Hybrid(3,"L5b","positron","axial")],"0x1c084072beb01400","L5b"),
    FEB(3,[Hybrid(0,"L6b","electron","stereo"),Hybrid(1,"L6b","positron","stereo"),Hybrid(2,"L6b","electron","axial"),Hybrid(3,"L6b","positron","axial")],"0x70d04072beb01c00","L6b"),
    ]


hybtemplimits = { 0:[-12.9,-13.4,-13.3,-13.1],1:[-14.5,-13.8,-11.8,-13.7],2:[-13.6,-12.7],3:[-13.6,-13.0,-11.1,-12.9],4:[-14.0,-13.5,-12.8,-13.9],5:[-12.3,-13.9,-13.5,-12.6],6:[-13.9,-13.0,-12.9,-12.8],7:[-13.2,-14.4,-13.6,-12.6],8:[-13.0,-13.9,-13.5,-12.5],9:[-12.8,-13.1] }
                                                                                    
def getHybridTempLimits(feb,hyb):
    if feb in hybtemplimits:
        hybrids = hybtemplimits[feb]
        if hyb < len(hybrids):
            t = hybrids[hyb]
            delta = [1.0,1.5]
            if(feb==2 and hyb==0):
                delta = [1.5,2.0]
            l = TempLimit(t-delta[1],t-delta[0],t+delta[0],t+delta[1])
        else:
            print "ERROR: hyb ", hyb, " too large for feb ", feb
            sys.exit(1)            
    else:
        print "ERROR: ", feb, " not found among febs"
        sys.exit(1)
    return l

        



def getLayer(febid):
    layer=""
    for feb in febs:
        if feb.id ==febid:
            if layer=="":
                layer = feb.layer
            else:
                print "ERROR: found two febs with ID ", febid
                sys.exit(1)
    return layer

def getHybrids(febid):
    n = None
    for feb in febs:
        if feb.id ==febid:
            if n==None:
                n = feb.hybrids
            else:
                print "ERROR: found two febs with ID ", febid
                sys.exit(1)
    return n


def getDna(febid):
    layer=""
    for feb in febs:
        if feb.id ==febid:
            if layer=="":
                layer = feb.dna
            else:
                print "ERROR: found two febs with ID ", febid
                sys.exit(1)
    return layer






def buildHybLVVSet():


    s = """



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
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
                rec = rec.replace("NEXTHYBID",str(0))
                rec = rec.replace("NEXTFEBID",str(feb+1))					
            else:
                rec = rec.replace("NEXTFEBID",str(feb))
                rec = rec.replace("NEXTHYBID",str(hyb+1))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)
    
    return records









def buildHybLVVSetRd_v125():


    s = """


record(sub,SVT:lv:FEBID:HYBID:v125:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")    
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:v125:v_set_rd)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"190") field(HHSV,"MAJOR")
  field(HIGH,"185") field(HSV,"MINOR")
  field(LOW,"175") field(LSV,"MINOR")
  field(LOLO,"170") field(LLSV,"MAJOR")
}






"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:v125:v_set_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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



def buildHybLVVSetRd_avdd():


    s = """



record(sub,SVT:lv:FEBID:HYBID:avdd:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:v_set_rd)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"180") field(HHSV,"MAJOR")
  field(HIGH,"175") field(HSV,"MINOR")
  field(LOW,"165") field(LSV,"MINOR")
  field(LOLO,"160") field(LLSV,"MAJOR")
}




"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:avdd:v_set_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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



def buildHybLVVSetRd_dvdd():


    s = """



record(sub,SVT:lv:FEBID:HYBID:dvdd:v_set_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:v_set_rd)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:v_set_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"160") field(HHSV,"MAJOR")
  field(HIGH,"155") field(HSV,"MINOR")
  field(LOW,"145") field(LSV,"MINOR")
  field(LOLO,"140") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dvdd:v_set_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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








def buildHybLVVf_v125():


    s = """



record(sub,SVT:lv:FEBID:HYBID:v125:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:v125:vf) {
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:vf_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"1.47") field(HHSV,"MAJOR")
  field(HIGH,"1.37") field(HSV,"MINOR")
  field(LOW,"1.17") field(LSV,"MINOR")
  field(LOLO,"1.07") field(LLSV,"MAJOR")
}





"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:v125:vf"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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






def buildHybLVVf_avdd():


    s = """


record(sub,SVT:lv:FEBID:HYBID:avdd:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:vf)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:vf_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"2.8") field(HHSV,"MAJOR")
  field(HIGH,"2.7") field(HSV,"MINOR")
  field(LOW,"2.5") field(LSV,"MINOR")
  field(LOLO,"2.4") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:avdd:vf"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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






def buildHybLVVf_dvdd():


    s = """





record(sub,SVT:lv:FEBID:HYBID:dvdd:vf_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:vf)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:vf_sub PP")
  field(DTYP,"Soft Channel")
}






"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dvdd:vf"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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







def buildHybLVVn_v125():


    s = """


record(sub,SVT:lv:FEBID:HYBID:v125:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:v125:vn)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:vn_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"1.55") field(HHSV,"MAJOR")
  field(HIGH,"1.45") field(HSV,"MINOR")
  field(LOW,"1.25") field(LSV,"MINOR")
  field(LOLO,"1.15") field(LLSV,"MAJOR")
}





"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:v125:vn"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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






def buildHybLVVn_avdd():


    s = """




record(sub,SVT:lv:FEBID:HYBID:avdd:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:vn)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:vn_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"2.9") field(HHSV,"MAJOR")
  field(HIGH,"2.8") field(HSV,"MINOR")
  field(LOW,"2.6") field(LSV,"MINOR")
  field(LOLO,"2.5") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:avdd:vn"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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








def buildHybLVVn_dvdd():


    s = """


record(sub,SVT:lv:FEBID:HYBID:dvdd:vn_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subLVInit")
    field(SNAM,"subLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:vn)
{
  field(SCAN, "Passive")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:vn_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"2.8") field(HHSV,"MAJOR")
  field(HIGH,"2.7") field(HSV,"MINOR")
  field(LOW,"2.5") field(LSV,"MINOR")
  field(LOLO,"2.4") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dvdd:vn"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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











def buildHybLVIrd_v125():


    s = """

record(sub,SVT:lv:FEBID:HYBID:v125:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subHybridLVInit")
    field(SNAM,"subHybridLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:v125:i_rd)
{
  field(SCAN, "SCANFREQ")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:v125:i_rd_sub PP")
  field(DTYP,"Soft Channel")
   field(HIHI,"HHLIM") field(HHSV,"MAJOR")
  field(HIGH,"HILIM") field(HSV,"MINOR")
  field(LOW,"LOLIM") field(LSV,"MINOR")
  field(LOLO,"LLLIM") field(LLSV,"MAJOR")

}




"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:v125:i_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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
            if (feb==0 and hyb==1) or (feb==4 and hyb==1):
                rec = rec.replace("HHLIM",str(0.34))
                rec = rec.replace("HILIM",str(0.32))
                rec = rec.replace("LOLIM",str(0.285))
                rec = rec.replace("LLLIM",str(0.275))
            else:
                rec = rec.replace("HHLIM",str(0.36))
                rec = rec.replace("HILIM",str(0.34))
                rec = rec.replace("LOLIM",str(0.305))
                rec = rec.replace("LLLIM",str(0.295))

            if feb==0 and hyb==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")                
            records.append(rec)
    
    return records







def buildHybLVIrd_avdd():


    s = """


record(sub,SVT:lv:FEBID:HYBID:avdd:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subHybridLVInit")
    field(SNAM,"subHybridLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:avdd:i_rd)
{
  field(SCAN, "SCANFREQ")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:avdd:i_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"HHLIM") field(HHSV,"MAJOR")
  field(HIGH,"HILIM") field(HSV,"MINOR")
  field(LOW,"LOLIM") field(LSV,"MINOR")
  field(LOLO,"LLLIM") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:avdd:i_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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
            if (feb==6 and hyb==2):
                rec = rec.replace("HHLIM",str(0.61))
                rec = rec.replace("HILIM",str(0.59))
                rec = rec.replace("LOLIM",str(0.50))
                rec = rec.replace("LLLIM",str(0.45))
            elif (feb==5 and hyb==2) or (feb==1 and hyb==3):
                rec = rec.replace("HHLIM",str(0.47))
                rec = rec.replace("HILIM",str(0.45))
                rec = rec.replace("LOLIM",str(0.375))
                rec = rec.replace("LLLIM",str(0.365))
            else:
                rec = rec.replace("HHLIM",str(0.45))
                rec = rec.replace("HILIM",str(0.43))
                rec = rec.replace("LOLIM",str(0.355))
                rec = rec.replace("LLLIM",str(0.345))
            rec = rec.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            if feb==0 and hyb==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")                
            records.append(rec)
            
            records.append(rec)
    
    return records







def buildHybLVIrd_dvdd():


    s = """


record(sub,SVT:lv:FEBID:HYBID:dvdd:i_rd_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subHybridLVInit")
    field(SNAM,"subHybridLVProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:lv:FEBID:HYBID:dvdd:i_rd)
{
  field(SCAN, "SCANFREQ")
  field(PREC, "3")
  field(INP, "SVT:lv:FEBID:HYBID:dvdd:i_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"0.31") field(HHSV,"MAJOR")
  field(HIGH,"0.295") field(HSV,"MINOR")
  field(LOW,"0.26") field(LSV,"MINOR")
  field(LOLO,"0.24") field(LLSV,"MAJOR")
}



"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:dvdd:i_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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
            if feb==0 and hyb==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")  
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


  













def buildHybridLVSwitch():


    s = """



record(sub,SVT:lv:FEBID:HYBID:all:switch_sub)
{
    field(INAM,"subHybridSwitchInit")
    field(SNAM,"subHybridSwitchProcess")
    field(SCAN,"Passive")
}

record(bo, SVT:lv:FEBID:HYBID:all:switch)
{
    field(OUT, "SVT:lv:FEBID:HYBID:all:switch_sub PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "supervisory")
}




"""
    
    records = []
    for feb in range(0,10):
        for hyb in range(0,4):
            rec = s.replace("HYBID",str(hyb))
            rec = rec.replace("FEBID",str(feb))
            records.append(rec)



    s = """


record(bo, SVT:lv:FEBID:all:switch)
{
    field(OUT, "SVT:lv:FEBID:all:switch_sub PP")
    field(DTYP,"Soft Channel")
    field(ZNAM, "Off")
    field(ONAM, "On")
    field(OMSL, "supervisory")
}


record(aSub,SVT:lv:FEBID:all:switch_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subHybridSwitchInit")
    field(SNAM,"subHybridSwitchProcess")
	field(INPA,"SVT:daq:map:FEBID:layer")
    field(FTA,"STRING")
	field(FLNK,"SVT:lv:FEBID:all:switch_fanout")
}
"""
    for feb in range(0,10):
        rec = s.replace("FEBID",str(feb))
        records.append(rec)



    for feb in range(0,10):
        s = """
record(dfanout,SVT:lv:"""+str(feb)+""":all:switch_fanout)
{
    field(DOL,"SVT:lv:"""+str(feb)+""":all:switch")
    field(OMSL,"closed_loop")
"""
        r = range(0,len(getHybrids(feb)))
        link = ["OUTA","OUTB","OUTC","OUTD"]
        for hyb in r:
            s += "    field(" + link[hyb]+",\"SVT:lv:"+str(feb)+":"+str(hyb)+":all:switch\") " + "\n"
        s += "}\n\n"
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
    field(INAM,"subHybridTempInit")
    field(SNAM,"subHybridTempProcess")
    field(FLNK,"FLNKNEXTHYB")
}

record(ai, SVT:temp:hyb:FEBID:HYBID:temp0:t_rd) {
  field(SCAN, "SCANFREQ")
  field(PREC, "1")
  field(INP, "SVT:temp:hyb:FEBID:HYBID:temp0:t_rd_sub PP")
  field(DTYP,"Soft Channel")
  field(HIHI,"HIHIVAL") field(HHSV,"MAJOR")
  field(HIGH,"HIVAL") field(HSV,"MINOR")
  field(LOW,"LOWVAL") field(LSV,"MINOR")
  field(LOLO,"LOLOVAL") field(LLSV,"MAJOR")
}
"""

    s_flnk = "SVT:temp:hyb:NEXTFEBID:NEXTHYBID:temp0:t_rd"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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
            rec = rec.replace("HIHIVAL",str(getHybridTempLimits(feb,hyb).HIHI))
            rec = rec.replace("HIVAL",str(getHybridTempLimits(feb,hyb).HI))
            rec = rec.replace("LOWVAL",str(getHybridTempLimits(feb,hyb).LO))
            rec = rec.replace("LOLOVAL",str(getHybridTempLimits(feb,hyb).LOLO))
            if feb==0 and hyb==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")    
            
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
    field(HIHI,"47") field(HHSV,"MAJOR")
    field(HIGH,"45") field(HSV,"MINOR")
    field(LOW,"37") field(LSV,"MINOR")
    field(LOLO,"35") field(LLSV,"MAJOR")
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
    field(HIHI,"30") field(HHSV,"MAJOR")
    field(HIGH,"28") field(HSV,"MINOR")
    field(LOW,"22") field(LSV,"MINOR")
    field(LOLO,"20") field(LLSV,"MAJOR")
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
    field(HIHI,"30") field(HHSV,"MAJOR")
    field(HIGH,"28") field(HSV,"MINOR")
    field(LOW,"22") field(LSV,"MINOR")
    field(LOLO,"20") field(LLSV,"MAJOR")
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
    field(SCAN,"SCANFREQ")
    field(INAM,"subSyncInit")
    field(SNAM,"subSyncProcess")
    field(OUTA,"SVT:lv:FEBID:HYBID:sync:sync_rd PP")
    field(FTVA,"LONG")
    field(FLNK,"FLNKNEXTHYB")
}

record(longin, SVT:lv:FEBID:HYBID:sync:sync_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
  field(HIGH,"32") field(HSV,"MAJOR")
  field(LOW,"30") field(LSV,"MAJOR")
}
"""
    s_flnk = "SVT:lv:NEXTFEBID:NEXTHYBID:sync:sync_rd_asub"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            rec = s
            if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
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
            if feb==0 and hyb==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")                
            records.append(rec)
    
    return records


def buildHybSyncPeak():
    s = """

record(aSub,SVT:daq:FEBID:HYBID:APVID:syncpeak_rd_asub)
{
    field(SCAN,"SCANFREQ")
    field(INAM,"subSyncBaseInit")
    field(SNAM,"subSyncBaseProcess")
    field(OUTA,"SVT:daq:FEBID:HYBID:APVID:syncpeak_rd PP")
    field(FTVA,"LONG")
    field(FLNK,"FLNKNEXTHYB")
}

record(longin, SVT:daq:FEBID:HYBID:APVID:syncpeak_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}


"""
    s_flnk = "SVT:daq:NEXTFEBID:NEXTHYBID:NEXTAPV:syncpeak_rd_asub"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            for apv in range(0,5):
                rec = s
                if apv==4:
                    if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
                        if feb == 9:
                            # done
                            rec = rec.replace("FLNKNEXTHYB","")                    
                        else:
                            # go to next feb
                            rec = rec.replace("FLNKNEXTHYB",s_flnk)
                            rec = rec.replace("NEXTHYBID",str(0))
                            rec = rec.replace("NEXTAPV",str(0))
                            rec = rec.replace("NEXTFEBID",str(feb+1))
                    else:
                        # go to next hybrid
                        rec = rec.replace("FLNKNEXTHYB",s_flnk)
                        rec = rec.replace("NEXTHYBID",str(hyb+1))
                        rec = rec.replace("NEXTAPV",str(0))
                        rec = rec.replace("NEXTFEBID",str(feb))
                else:
                    # go to next apv
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(hyb))
                    rec = rec.replace("NEXTAPV",str(apv+1))
                    rec = rec.replace("NEXTFEBID",str(feb))				
                # replace the current record
                rec = rec.replace("APVID",str(apv))
                rec = rec.replace("HYBID",str(hyb))
                rec = rec.replace("FEBID",str(feb))
                if feb==0 and hyb==0 and apv==0:
                    rec = rec.replace("SCANFREQ","1 second")
                else:
                    rec = rec.replace("SCANFREQ","Passive")    
                #print 'add rec ', rec
                records.append(rec)
    return records




def buildHybSyncBase():
    s = """
record(aSub,SVT:daq:FEBID:HYBID:APVID:syncbase_rd_asub)
{
    field(SCAN,"SCANFREQ")
    field(INAM,"subSyncBaseInit")
    field(SNAM,"subSyncBaseProcess")
    field(OUTA,"SVT:daq:FEBID:HYBID:APVID:syncbase_rd PP")
    field(FTVA,"LONG")
    field(FLNK,"FLNKNEXTHYB")
}

record(longin, SVT:daq:FEBID:HYBID:APVID:syncbase_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}




"""
    s_flnk = "SVT:daq:NEXTFEBID:NEXTHYBID:NEXTAPV:syncbase_rd_asub"
    records = []
    for feb in range(0,10):
        r = range(0,len(getHybrids(feb)))
        for hyb in r:
            for apv in range(0,5):
                rec = s
                if apv==4:
                    if (hyb==3 and len(r)==4) or (hyb==1 and len(r)==2):
                        if feb == 9:
                            # done
                            rec = rec.replace("FLNKNEXTHYB","")                    
                        else:
                            # go to next feb
                            rec = rec.replace("FLNKNEXTHYB",s_flnk)
                            rec = rec.replace("NEXTHYBID",str(0))
                            rec = rec.replace("NEXTAPV",str(0))
                            rec = rec.replace("NEXTFEBID",str(feb+1))
                    else:
                        # go to next hybrid
                        rec = rec.replace("FLNKNEXTHYB",s_flnk)
                        rec = rec.replace("NEXTHYBID",str(hyb+1))
                        rec = rec.replace("NEXTAPV",str(0))
                        rec = rec.replace("NEXTFEBID",str(feb))
                else:
                    # go to next apv
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(hyb))
                    rec = rec.replace("NEXTAPV",str(apv+1))
                    rec = rec.replace("NEXTFEBID",str(feb))				
                # replace the current record
                rec = rec.replace("APVID",str(apv))
                rec = rec.replace("HYBID",str(hyb))
                rec = rec.replace("FEBID",str(feb))
                if feb==0 and hyb==0 and apv==0:
                    rec = rec.replace("SCANFREQ","1 second")
                else:
                    rec = rec.replace("SCANFREQ","Passive")
                #print 'add rec ', rec
                records.append(rec)
    return records



def buildInsertedFrames():
    s = """

record(aSub,SVT:daq:$(DPM):HYBID:APVID:insertedframes_rd_asub)
{
    field(SCAN,"SCANFREQ")
    field(INAM,"subInsertedFramesInit")
    field(SNAM,"subInsertedFramesProcess")
    field(OUTA,"SVT:daq:$(DPM):HYBID:APVID:insertedframes_rd PP")
    field(FTVA,"LONG")
    field(FLNK,"FLNKNEXTHYB")
}

record(longin, SVT:daq:$(DPM):HYBID:APVID:insertedframes_rd) {
  field(SCAN, "Passive")
  field(DTYP,"Soft Channel")
}


"""
    s_flnk = "SVT:daq:$(DPM):NEXTHYBID:NEXTAPV:insertedframes_rd_asub"
    records = []
    for hyb in range(0,4):
        for apv in range(0,5):
            rec = s
            if apv==4:
                if hyb==3:
                    # done
                    rec = rec.replace("FLNKNEXTHYB","")                    
                else:
                    # go to next hybrid
                    rec = rec.replace("FLNKNEXTHYB",s_flnk)
                    rec = rec.replace("NEXTHYBID",str(hyb+1))
                    rec = rec.replace("NEXTAPV",str(0))
            else:
                # go to next apv
                rec = rec.replace("FLNKNEXTHYB",s_flnk)
                rec = rec.replace("NEXTHYBID",str(hyb))
                rec = rec.replace("NEXTAPV",str(apv+1))
            # replace the current record
            rec = rec.replace("APVID",str(apv))
            rec = rec.replace("HYBID",str(hyb))
            if hyb==0 and apv==0:
                rec = rec.replace("SCANFREQ","1 second")
            else:
                rec = rec.replace("SCANFREQ","Passive")    
            #print 'add rec ', rec
            records.append(rec)
    return records


def buildEBEventErrorCount():
    s = """

record(aSub,SVT:daq:$(DPM):ebeventerrorcount_rd_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subEBEventErrorCountInit")
    field(SNAM,"subEBEventErrorCountProcess")
    field(OUTA,"SVT:daq:$(DPM):ebeventerrorcount_rd PP")
    field(FTVA,"LONG")
    field(FLNK,"")
}

record(longin, SVT:daq:$(DPM):ebeventerrorcount_rd) {
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
        
	

    s = """
record(stringin, SVT:daq:map:FEBID:HYBID:side) {
  field(SCAN, "Passive") 
  field(VAL,"SIDE")
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:map:FEBID:HYBID:layer) {
  field(SCAN, "Passive") 
  field(VAL,"LAYER")
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:map:FEBID:HYBID:type) {
  field(SCAN, "Passive") 
  field(VAL,"TYPE")
  field(DTYP,"Soft Channel")
}


"""	

    for feb in range(0,10):
        hybrids = getHybrids(feb)
        for hybrid in hybrids:
            rec = s
            rec = rec.replace("FEBID",str(feb))
            rec = rec.replace("HYBID",str(hybrid.id))
            rec = rec.replace("SIDE",str(hybrid.side))
            rec = rec.replace("LAYER",str(hybrid.layer))
            rec = rec.replace("TYPE",str(hybrid.type))
            records.append(rec)
    
    return records





def buildDpmStatus():
	
    s = """
record(aSub,SVT:daq:dpm:$(DPM):status_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subDpmStatusInit")
    field(SNAM,"subDpmStatusProcess")
    field(OUTA,"SVT:daq:dpm:$(DPM):status PP")
    field(FTVA,"STRING")
    field(OUTB,"SVT:daq:dpm:$(DPM):hb_check PP")
    field(FTVB,"LONG")
    field(OUTC,"SVT:daq:dpm:$(DPM):socketstatus PP")
    field(FTVC,"STRING")
    #field(FLNK,"FLNKNEXTLAYER")
}

record(stringin, SVT:daq:dpm:$(DPM):status) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:dpm:$(DPM):socketstatus) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(longin, SVT:daq:dpm:$(DPM):hb_check) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    return s

def buildControlDpmStatus():
	
    s = """
record(aSub,SVT:daq:controldpm:$(DPM):$(NR):status_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subDpmStatusInit")
    field(SNAM,"subDpmStatusProcess")
    field(OUTA,"SVT:daq:controldpm:$(DPM):$(NR):status PP")
    field(FTVA,"STRING")
    field(OUTB,"SVT:daq:controldpm:$(DPM):$(NR):hb_check PP")
    field(FTVB,"LONG")
    field(OUTC,"SVT:daq:controldpm:$(DPM):$(NR):socketstatus PP")
    field(FTVC,"STRING")
    #field(FLNK,"FLNKNEXTLAYER")
}

record(stringin, SVT:daq:controldpm:$(DPM):$(NR):status) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:controldpm:$(DPM):$(NR):socketstatus) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(longin, SVT:daq:controldpm:$(DPM):$(NR):hb_check) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    return s


def buildDtmStatus():
	
    s = """
record(aSub,SVT:daq:dtm:$(DTM):status_asub)
{
    field(SCAN,"1 second")
    field(INAM,"subDpmStatusInit")
    field(SNAM,"subDpmStatusProcess")
    field(OUTA,"SVT:daq:dtm:$(DTM):status PP")
    field(FTVA,"STRING")
    field(OUTB,"SVT:daq:dtm:$(DTM):hb_check PP")
    field(FTVB,"LONG")
    field(OUTC,"SVT:daq:dtm:$(DTM):socketstatus PP")
    field(FTVC,"STRING")
    #field(FLNK,"FLNKNEXTLAYER")
}

record(stringin, SVT:daq:dtm:$(DTM):status) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(stringin, SVT:daq:dtm:$(DTM):socketstatus) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}

record(longin, SVT:daq:dtm:$(DTM):hb_check) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}


"""	
    return s







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


def buildControlDpm():

    records = []
    s = """
record(sub,SVT:controldpm:$(DPM):$(NR):poll_xml)
{
    field(SCAN,"1 second")
    field(INAM,"subPollInit")
    field(SNAM,"subPollProcess")
    field(FLNK,"SVT:daq:controldpm:$(DPM):$(NR):state_asub")

}

record(aSub,SVT:daq:controldpm:$(DPM):$(NR):state_asub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmStateInit")
    field(SNAM,"subDpmStateProcess")
    field(OUTA,"SVT:daq:controldpm:$(DPM):$(NR):state PP")
    field(FTVA,"STRING")
}

record(stringin, SVT:daq:controldpm:$(DPM):$(NR):state) {
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
    field(INAM,"subDpmEventCountInit")
    field(SNAM,"subDpmEventCountProcess")
}

record(longin, SVT:daq:dpm:$(DPM):eventcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):eventcount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records


def buildDpmBlockCount():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):blockcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmBlockCountInit")
    field(SNAM,"subDpmBlockCountProcess")
}

record(longin, SVT:daq:dpm:$(DPM):blockcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):blockcount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records


def buildDpmEventState():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):eventstate_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmEventStateInit")
    field(SNAM,"subDpmEventStateProcess")
}

record(longin, SVT:daq:dpm:$(DPM):eventstate) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):eventstate_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records


def buildDpmSystemState():

    records = []
    s = """

record(aSub,SVT:daq:dpm:$(DPM):systemstate_sub)
{
    field(SCAN,"1 second")
    field(INAM,"subDpmSystemStateInit")
    field(SNAM,"subDpmSystemStateProcess")
    field(OUTA,"SVT:daq:dpm:$(DPM):systemstate PP")
    field(FTVA,"STRING")

}

record(stringin, SVT:daq:dpm:$(DPM):systemstate) {
  field(SCAN, "Passive") 
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records




def buildDpmTrigCount():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):trigcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmTrigCountInit")
    field(SNAM,"subDpmTrigCountProcess")
}

record(longin, SVT:daq:dpm:$(DPM):trigcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):trigcount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records

def buildDtmTrigCount():

    records = []
    s = """

record(sub,SVT:daq:dtm:$(DTM):trigcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDtmTrigCountInit")
    field(SNAM,"subDtmTrigCountProcess")
}

record(longin, SVT:daq:dtm:$(DTM):trigcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dtm:$(DTM):trigcount_sub PP")
  field(DTYP,"Soft Channel")
}

"""	
    records.append(s)
    return records

def buildDtmReadCount():

    records = []
    s = """

record(sub,SVT:daq:dtm:$(DTM):readcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDtmReadCountInit")
    field(SNAM,"subDtmReadCountProcess")
}

record(longin, SVT:daq:dtm:$(DTM):readcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dtm:$(DTM):readcount_sub PP")
  field(DTYP,"Soft Channel")
}

"""	
    records.append(s)
    return records


def buildDtmAckCount():

    records = []
    s = """

record(sub,SVT:daq:dtm:$(DTM):$(DPM):ackcount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDtmAckCountInit")
    field(SNAM,"subDtmAckCountProcess")
}

record(longin, SVT:daq:dtm:$(DTM):$(DPM):ackcount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dtm:$(DTM):$(DPM):ackcount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records

def buildDtmMinTrigPeriod():

    records = []
    s = """

record(sub,SVT:daq:dtm:$(DTM):mintrigperiod_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDtmMinTrigPeriodInit")
    field(SNAM,"subDtmMinTrigPeriodProcess")
}

record(longin, SVT:daq:dtm:$(DTM):mintrigperiod) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dtm:$(DTM):mintrigperiod_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records


def buildDpmBurnCount():

    records = []
    s = """

record(sub,SVT:daq:dpm:$(DPM):burncount_sub)
{
    field(SCAN,"Passive")
    field(INAM,"subDpmBurnCountInit")
    field(SNAM,"subDpmBurnCountProcess")
}

record(longin, SVT:daq:dpm:$(DPM):burncount) {
  field(SCAN, "1 second") 
  field(INP, "SVT:daq:dpm:$(DPM):burncount_sub PP")
  field(DTYP,"Soft Channel")
}



"""	
    records.append(s)
    return records


