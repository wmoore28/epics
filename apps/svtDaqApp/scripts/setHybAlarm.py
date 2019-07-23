#!/usr/bin/python
import subprocess, sys

def main():
    cmd_sup_lolo = "caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.LOLO 12.0"
    cmd_sup_low = "caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.LOW 13.0"
    cmd_sup_high = "caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.HIGH 17.0"
    cmd_sup_hihi = "caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.HIHI 18.0"

    cmd_ret_lolo = "caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.LOLO 12.0"
    cmd_ret_low = "caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.LOW 13.0"
    cmd_ret_high = "caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.HIGH 17.0"
    cmd_ret_hihi = "caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.HIHI 18.0"

    subprocess.call(cmd_sup_lolo, shell=True)
    subprocess.call(cmd_sup_low, shell=True)
    subprocess.call(cmd_sup_high, shell=True)
    subprocess.call(cmd_sup_hihi, shell=True)

    subprocess.call(cmd_ret_lolo, shell=True)
    subprocess.call(cmd_ret_low, shell=True)
    subprocess.call(cmd_ret_high, shell=True)
    subprocess.call(cmd_ret_hihi, shell=True)

    for feb in range(0,9):
        for ch in range(0,3):
            if (feb == 2 or feb == 9) and (ch == 2 or ch ==3): continue
            cmd_lolo = "caput SVT:temp:hyb:" + str(feb) + ":" + str(ch) + ":temp0:t_rd.LOLO 10.0"
	    cmd_low = "caput SVT:temp:hyb:" + str(feb) + ":" + str(ch) + ":temp0:t_rd.LOW 11.0"
	    cmd_high = "caput SVT:temp:hyb:" + str(feb) + ":" + str(ch) + ":temp0:t_rd.HIGH 20.0"
	    cmd_hihi = "caput SVT:temp:hyb:" + str(feb) + ":" + str(ch) + ":temp0:t_rd.HIHI 22.0"
            subprocess.call(cmd_lolo, shell=True)
	    subprocess.call(cmd_low, shell=True)
	    subprocess.call(cmd_high, shell=True)
	    subprocess.call(cmd_hihi, shell=True)

if __name__=="__main__":
    main()


