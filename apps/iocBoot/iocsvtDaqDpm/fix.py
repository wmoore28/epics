import sys, os, subprocess 

for fn in os.listdir("."):
    if os.path.isfile(fn):
        if fn.endswith(".cmd"):
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
                if "db/dbDataDpm.db\"," in l:
                    fnew.write("dbLoadRecords(\"db/dbDataDpmEventCount.db\",\"DPM="+str(dpm)+"\")\n")
                #\n\n## Load record instances\ndbLoadRecords(\"db/iocAdminSoft.db\", \"IOC=iocsvtDaqDpmXXXX\")\n\n")
                #    fnew.write("\n\n## Load record instances\ndbLoadRecords(\"db/iocAdminSoft.db\", \"IOC=iocsvtDaqDpmXXXX\")\n\n")
                #l = l.replace("svtDaqDpm0","svtDaqDpm")
                #l = l.replace("envPaths_x86","envPaths")
                #l = l.replace("traceIocInit","#traceIocInit")
                fnew.write(l)
            f.close()
            fnew.close()
            subprocess.call("mv " + fn_new + " " + fn, shell=True)
