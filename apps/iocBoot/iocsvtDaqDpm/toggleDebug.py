import sys, os, subprocess 

if(len(sys.argv)<2):
    print "Usage: ", sys.argv[0], " debugLevel [write]"
    sys.exit(1)

write = False
if(len(sys.argv)>2):
    if sys.argv[2] == "write":
        write = True


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
                if "mySubDebug" in l:
                    fnew.write("var mySubDebug " + sys.argv[1] + "\n")
                else:
                    fnew.write(l)
            f.close()
            fnew.close()
            if write:
                subprocess.call("mv " + fn_new + " " + fn, shell=True)
