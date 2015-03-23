import sys
import getopt
import epicsRecUtils as utils

class Usage(Exception):
    def __init__(self,msg):
        self.msg = msg

def buildEpics():
    records = []
    recs = utils.buildFebTemp()
    printRecords(recs,"dbFebTemp")
    recs = utils.buildHybTemp()
    printRecords(recs,"dbHybT")
    recs = utils.buildHybLVVSet()
    printRecords(recs,"dbHybLVVSet")
    
    recs = utils.buildHybLVVSetRd_dvdd()
    printRecords(recs,"dbHybLVVSetRd_dvdd")
    recs = utils.buildHybLVVSetRd_avdd()
    printRecords(recs,"dbHybLVVSetRd_avdd")
    recs = utils.buildHybLVVSetRd_v125()
    printRecords(recs,"dbHybLVVSetRd_v125")
    
    recs = utils.buildHybLVVf_dvdd()
    printRecords(recs,"dbHybLVVf_dvdd")
    recs = utils.buildHybLVVf_avdd()
    printRecords(recs,"dbHybLVVf_avdd")
    recs = utils.buildHybLVVf_v125()
    printRecords(recs,"dbHybLVVf_v125")
    
    recs = utils.buildHybLVVn_dvdd()
    printRecords(recs,"dbHybLVVn_dvdd")
    recs = utils.buildHybLVVn_avdd()
    printRecords(recs,"dbHybLVVn_avdd")
    recs = utils.buildHybLVVn_v125()
    printRecords(recs,"dbHybLVVn_v125")
    
    recs = utils.buildHybLVIrd_dvdd()
    printRecords(recs,"dbHybLVIrd_dvdd")
    recs = utils.buildHybLVIrd_avdd()
    printRecords(recs,"dbHybLVIrd_avdd")
    recs = utils.buildHybLVIrd_v125()
    printRecords(recs,"dbHybLVIrd_v125")
    print "1"
    recs = utils.buildHybLVStat()
    printRecords(recs,"dbHybLVStat")
    recs = utils.buildHybridLVSwitch()
    printRecords(recs,"dbHybridSwitch")
    recs = utils.buildDpmMap()
    printRecords(recs,"dbDpmMap")
    recs = utils.buildHybSync()
    printRecords(recs,"dbHybSync")
    recs = utils.buildHybSyncPeak()
    printRecords(recs,"dbHybSyncPeak")
    recs = utils.buildHybSyncBase()
    printRecords(recs,"dbHybSyncBase")
    recs = utils.buildLayer()
    printRecords(recs,"dbFebLayer")
    recs = utils.buildDpm()
    printRecords(recs,"dbDataDpm")
    recs = utils.buildDtm()
    printRecords(recs,"dbDataDtm")
    recs = utils.buildDpmFebNum()
    printRecords(recs,"dbDataDpmFebNum")
    recs = utils.buildDpmHybNum()
    printRecords(recs,"dbDataDpmHybNum")
    recs = utils.buildDpmLink()
    printRecords(recs,"dbDataDpmLink")
    recs = utils.buildDpmEventCount()
    printRecords(recs,"dbDataDpmEventCount")
    recs = utils.buildDpmTrigCount()
    printRecords(recs,"dbDataDpmTrigCount")
    recs = utils.buildDtmTrigCount()
    printRecords(recs,"dbDataDtmTrigCount")
    recs = utils.buildDtmAckCount()
    printRecords(recs,"dbDataDtmAckCount")
    recs = utils.buildDpmStatus()
    printRecords(recs,"dbDataDpmStatus")
    recs = utils.buildDtmStatus()
    printRecords(recs,"dbDataDtmStatus")
    recs = utils.buildDpmEventState()
    printRecords(recs,"dbDataDpmEventState")
    recs = utils.buildDpmBlockCount()
    printRecords(recs,"dbDataDpmBlockCount")
    recs = utils.buildDpmSystemState()
    printRecords(recs,"dbDataDpmSystemState")

    


#def buildDataDpmEpics():
#    for dpm in range(1):
#        recs = utils.buildDpm(dpm)
#        path = "svtDaqDpm"+str(dpm)+"App/Db/dbDpm"+str(dpm)
#        printRecords(recs,path)

        


def printRecords(recs,name):
    f = open(name+".db","w")
    for rec in recs:
        f.write(rec)
    f.close()


def main(argv=None):
    if argv is None:
        argv = sys.argv
    try:
        try:
            opts, args  = getopt.getopt(argv[1:],"h",["help"])
        except getopt.error, msg:
            raise Usage(msg)
        buildEpics()
    except Usage, err:
        print >>sys.stderr, err.msg
        print >>sys.stderr, "for help use --help"
        return 2

    

if __name__ == "__main__":
    sys.exit(main());
