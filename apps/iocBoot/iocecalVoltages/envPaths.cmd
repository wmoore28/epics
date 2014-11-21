# envPaths.cmd
#  Prevents overwritting of paths from Makefile and avoids .gitignore for 
#  generated envPaths.

# TODO: correct paths as needed (nerses, wmoore)
epicsEnvSet("ARCH","linux-x86")
epicsEnvSet("IOC","iocecalVoltages")
epicsEnvSet("TOP","/usr/local/clas12/release/0.1/epics/drivers/CAEN_HV")
epicsEnvSet("EPICS_BASE","/usr/local/clas12/release/0.1/R3.14.12.3/base")
epicsEnvSet("DB","/home/nerses/github_test/epics/apps/hvcaApp/DB")
