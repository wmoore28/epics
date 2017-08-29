import sys, os, subprocess 

for fn in os.listdir("."):
    if os.path.isfile(fn):
        if fn.endswith(".cmd"):
            if "DaqDpm" not in fn:
                continue
            print "processing ", fn
            fn_new = "tmp-"+fn
            fnew = open(fn_new,"w")
            f = open(fn,"r")
            if "Dpm" in fn:
                dpm = fn.split("Dpm")[1].split(".")[0]
            else:
                dpm = fn.split("Dtm")[1].split(".")[0] 
            for l in f.readlines():
                #l = l.replace("XXXX",dpm)                
                #if "db/dbDataDpmEventCount.db\"," in l:
                if "db/dbHybSyncDataDpm.db\"," in l:
                    #l = "dbLoadRecords(\"db/dbHybSyncDataDpm.db\",\"DPM="+str(dpm)+"\")\n"
                    #l = fnew.write("dbLoadRecords(\"db/dbHybSyncDataDpm.db\",\"DPM="+str(dpm)+"\")\n")
                    for hyb in range(4):
                        fnew.write("dbLoadRecords(\"db/dbHybSyncDataDpmAll.db\",\"DPM="+str(dpm)+",HYB=" + str(hyb) +"\")\n")
                        fnew.write("dbLoadRecords(\"db/dbHybSyncDataDpm.db\",\"DPM="+str(dpm)+",HYB=" + str(hyb) +"\")\n")
                else:
                    fnew.write(l)
            f.close()
            fnew.close()
            subprocess.call("mv " + fn_new + " " + fn, shell=True)
