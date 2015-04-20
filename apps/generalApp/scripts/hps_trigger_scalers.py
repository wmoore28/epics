#!/usr/bin/env python

import pygtk,gtk,gobject,commands,time
#import numpy,matplotlib
#from matplotlib import pyplot
#from matplotlib.backends.backend_gtk import FigureCanvasGTK as FigureCanvas

PVFORMAT='B_SCALERSHPS2_Sl10_Ch%d'
NCAGETCOLUMNMS=6
TRIGGERNAMES=('Single0','Single1','Pair0','Pair1','Calib','Pulser')

TIMEFORMAT='%Y/%m/%d %H:%M:%S'
UPDATEFREQ=2 # units = seconds

def putHSeparator(box):
  sep = gtk.HSeparator()
  box.pack_start(sep,expand=False)
  sep.show()
  return sep

def putHBox(box,strings):
  hbox = gtk.HBox(False, 0)
  hbox.set_homogeneous(True)
  box.pack_start(hbox,expand=False)
  hbox.show()
  if strings!=None:
    for xx in strings:
      hbox.pack_start(gtk.Label(xx))
  return hbox

def putVBox(win):
  vbox = gtk.VBox(False, 0)
  win.add(vbox)
  vbox.set_homogeneous(False)
  vbox.set_spacing(10)
  vbox.show()
  return vbox

def putText(box,label):
  txt = gtk.Label(label)
  box.pack_start(txt)
  return txt

class Scalers:
  def __init__(self,vbox):
    self.iColumn=4
    self.txtRate=[]
    self.txtFrac=[]
    self.txtDate = putText(vbox,time.strftime(TIMEFORMAT))
    seperator    = putHSeparator(vbox)
    boxHeader    = putHBox(vbox,TRIGGERNAMES)
    seperator    = putHSeparator(vbox)
    boxRate      = putHBox(vbox,None)
    boxFrac      = putHBox(vbox,None)
    for ii in range(len(TRIGGERNAMES)):
      self.txtRate.append(gtk.Label('0'))
      self.txtFrac.append(gtk.Label('0'))
      self.txtRate[len(self.txtRate)-1].show()
      self.txtFrac[len(self.txtFrac)-1].show()
      boxRate.pack_start(self.txtRate[len(self.txtRate)-1])
      boxFrac.pack_start(self.txtFrac[len(self.txtFrac)-1])
    gobject.timeout_add(UPDATEFREQ*1000,self.update)
  def update(self):
    total=0
    counts=[]
    self.txtDate.set_text(time.strftime(TIMEFORMAT))
    for chan in range(len(TRIGGERNAMES)):
      pv = PVFORMAT%(chan)
      vals = commands.getoutput('caget '+pv).rstrip().split()
      if len(vals) != NCAGETCOLUMNMS:
        print 'CAGET ERROR:  '+str(vals)
        self.error()
        return True
      try:
        rate = float(vals[self.iColumn])
      except ValueError:
        print 'CAGET ERROR:  '+str(vals)
        self.error()
        return True
      counts.append(float(vals[self.iColumn]))
      total += float(vals[self.iColumn])
    for ii in range(len(TRIGGERNAMES)):
      if counts[ii] < 1:
        self.txtRate[ii].set_text('0')
      elif counts[ii] > 1e3:
        self.txtRate[ii].set_text('%.1f KHz'%(counts[ii]/1e3))
      else:
        self.txtRate[ii].set_text('%.0f Hz'%(counts[ii]))
      if total>0:
        self.txtFrac[ii].set_text('%.1f%%'%(100*float(counts[ii])/total))
      else:
        self.txtFrac[ii].set_text('0')
    return True
  def error(self):
    for ii in range(len(TRIGGERNAMES)):
      self.txtRate[ii].set_text('ERR')
      self.txtFrac[ii].set_text('ERR')


class StripChart:
  def __init__(self,box,maxt=2,dt=0.02):
    self.fig, self.ax = pyplot.subplots()
    self.dt = dt
    self.maxt = maxt
    self.tdata=[0]
    self.ydata=[0]
    self.line = matplotlib.lines.Line2D(self.tdata, self.ydata)
    self.ax.add_line(self.line)
    self.ax.set_ylim(-.1, 1.1)
    self.ax.set_xlim(0, self.maxt)
    canvas = FigureCanvas(self.fig)
    box.pack_start(canvas,expand=True)
    gobject.timeout_add(100,self.update)
  def update(self):
    if self.tdata[-1] > self.tdata[0] + self.maxt:
      self.tdata.pop(0)
      self.ydata.pop(0)
      self.ax.set_xlim(self.tdata[0], self.tdata[0] + self.maxt)
    self.tdata.append(self.tdata[-1] + self.dt)
    self.ydata.append(numpy.random.rand(1))
    self.line.set_data(self.tdata, self.ydata)
    self.ax.figure.canvas.draw()
    return True

def main():

  win = gtk.Window(gtk.WINDOW_TOPLEVEL)
  win.set_default_size(600,140)
  win.set_title('HPS TRIGGER RATES')

  vbox=putVBox(win)
  putHSeparator(vbox)
  putHBox(vbox,None)
  scalers = Scalers(vbox)
  putHSeparator(vbox)

# requires matplotlib>1.0:
#  stripChart = StripChart(vbox)

  win.show_all()
  gtk.main()

if __name__ == '__main__': main()

