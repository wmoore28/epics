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
    recs = utils.buildHybLV()
    printRecords(recs,"dbHybLV")
    recs = utils.buildHybLVStat()
    printRecords(recs,"dbHybLVStat")
    recs = utils.buildHybLVSwitch()
    printRecords(recs,"dbHybSwitch")
    recs = utils.buildDpmMap()
    printRecords(recs,"dbDpmMap")
    recs = utils.buildHybSync()
    printRecords(recs,"dbHybSync")
    recs = utils.buildHybSyncBase()
    printRecords(recs,"dbHybSyncBase")
    recs = utils.buildLayer()
    printRecords(recs,"dbFebLayer")
    #recs = utils.buildDpmState()
    #printRecords(recs,"dbDpmState")
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
