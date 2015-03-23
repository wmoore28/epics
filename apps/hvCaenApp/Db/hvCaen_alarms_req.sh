#!/bin/sh
#
# Generate autosave req file for svt_voltages.db (sqlite) alarm fields.
#
# To test that names are generated correctly: 
#   ./hvCaen_alarms_req.sh | xargs caget

# All records are ai/ao.
ALARMS=("HIGH" "HSV" "HIHI" "HHSV" "LOW" "LSV" "LOLO" "LLSV")

# SVT:lv:fe:[0-9]:[digi|anan|anap]:[i_rd|v_sens|v_term|stat]
for CHAN in $(seq 0 9); do
  for SUB in "digi" "anan" "anap"; do
    for PV in "i_rd" "v_sens" "v_term" "stat"; do
      for ALARM in $ALARMS; do
        echo SVT:lv:fe:$CHAN:$SUB:$PV.$ALARM
      done
    done
  done
done

# SVT:lv:fl:[0-3]:[i_rd|v_sens|v_term|stat]
for CHAN in $(seq 0 3); do
  for PV in "i_rd" "v_sens" "v_term" "stat"; do
    for ALARM in $ALARMS; do
      echo SVT:lv:fl:$CHAN:$PV.$ALARM
    done
  done
done

# SVT:bias:top:[0-17]:[i_rd|v_term|stat]
for CHAN in $(seq 0 17); do
  for PV in "i_rd" "v_term" "stat"; do
    for ALARM in $ALARMS; do
      echo SVT:bias:top:$CHAN:$PV.$ALARM
    done
  done
done

# SVT:bias:bot:[20-37]:[i_rd|v_term|stat]
for CHAN in $(seq 20 37); do
  for PV in "i_rd" "v_term" "stat"; do
    for ALARM in $ALARMS; do
      echo SVT:bias:bot:$CHAN:$PV.$ALARM
    done
  done
done
