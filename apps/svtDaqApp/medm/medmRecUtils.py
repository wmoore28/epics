

def buildHybLV(templatefilename):


    records = []
    for half in ["bot","top"]:
        for hyb in range(0,18):
            f_template = open(templatefilename,"r")
            name = half + "_" + str(hyb) 
            fname = templatefilename.replace("template",name)
            f = open(fname,"w")
            for line in f_template:
                line = line.replace("HYBID",str(hyb))
                line = line.replace("HALF",str(half))
                f.write(line)
            f.close()
            f_template.close()
    return




