import sys, os, subprocess 

for fn in os.listdir("."):
    if os.path.isfile(fn):
        if ".cmd" in fn:
            fn_new = "tmp-"+fn
            fnew = open(fn_new,"w")
            f = open(fn,"r")            
            for l in f.readlines():
                l = l.replace("svtDaqDpm0","svtDaqDpm")
                l = l.replace("envPaths_x86","envPaths")
                l = l.replace("traceIocInit","#traceIocInit")
                fnew.write(l)
            f.close()
            fnew.close()
            subprocess.call("mv " + fn_new + " " + fn, shell=True)
