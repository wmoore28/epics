#!/usr/bin/env python
import epics,time,smtplib,datetime,sys
from email.mime.text import MIMEText

minTimeDelta=60*30#seconds
notifiers={}

svt={}
svt['name']='HPS SVT'
svt['emails']=['cbravo135@gmail.com','tknelson@slac.stanford.edu','email@omarmoreno.net','stepanya@jlab.org','baltzell@jlab.org','rafopar@jlab.org']
svt['pvnames']=[
'HPS_SVT:PLC:i:RTD_SVT_Supply-Value',
'HPS_SVT:PLC:i:RTD_SVT_Return-Value',
'HPS_SVT:PLC:i:Flow_SVT-Value',
'HPS_SVT:PLC:i:Valve_SVT-Shutdown'
]
notifiers['svt']=svt

#ecal={}
#ecal['name']='HPS ECAL'
#ecal['emails']=['baltzell@jlab.org']
#ecal['pvnames']=['tempSensorA','tempSensorB']
#notifiers['ecal']=ecal

print notifiers

def getURL():
  url = 'https://epicsweb.jlab.org/wave/?start=START&end=END&myaDeployment=ops&myaLimit=100000&windowMinutes=30&title=&fullscreen=false&layoutMode=1&viewerMode=1&pv=HPS_SVT%3APLC%3Ai%3ARTD_SVT_Supply-Value&pv=HPS_SVT%3APLC%3Ai%3ARTD_SVT_Return-Value&pv=HPS_SVT%3ACHILLER%3ATEMP'
  date_time_format = '%Y-%m-%d+%H%%3A%M%%3A%S'
  end = datetime.datetime.now()
  start = end + datetime.timedelta(days=-1)
  end = end.strftime(date_time_format)
  start = start.strftime(date_time_format)
  url = url.replace('START',start).replace('END',end)
  return url

def sendEmail(pvname,group):
  print 'Sending email ...',pvname,group['emails']
  msg=MIMEText(pvname+' entered MAJOR alarm state\n\nEmails disabled for this PV for the next '+str(minTimeDelta)+' seconds\n\n'+getURL())
  msg['Subject']=group['name']+' Alarm: '+pvname
  msg['From']='hps-alarm-notifier@jlab.org'
  msg['To']=', '.join(group['emails'])
  s=smtplib.SMTP('localhost')
  s.sendmail('hps-alarm-notifier@jlab.org',group['emails'],msg.as_string())
  s.quit()

def onAlarm(pvname=None,severity=None,timestamp=None,group=None,**kws):
  if severity<2:
    return
  if 'tprev' not in group:
    group['tprev']={}
  if not pvname in group['tprev']:
    sendEmail(pvname,group)
  elif timestamp-group['tprev'][pvname]>minTimeDelta:
    sendEmail(pvname,group)
  else:
    print 'Not sending email on '+pvname+', since last one was less than '+str(minTimeDelta)+'s ago.'
  group['tprev'][pvname]=timestamp

for group in notifiers.keys():
  for pvname in notifiers[group]['pvnames']:
    if not pvname in notifiers[group]:
      notifiers[group][pvname]=epics.pv.PV(pvname,auto_monitor=epics.dbr.DBE_ALARM)
      notifiers[group][pvname].add_callback(callback=onAlarm,index=0,group=notifiers[group])

while True:
  time.sleep(100)

