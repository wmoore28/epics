import sys, subprocess

for feb in range(0,10):
    for hyb in range(0,5):
        for apv in range(0,6):
            print "dbLoadRecords(\"db/dbHybSyncBase.db\",\"FEB=%d,HYB=%d,APV=%d\")" % (feb, hyb, apv)

