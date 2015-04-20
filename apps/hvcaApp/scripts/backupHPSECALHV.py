#!/usr/bin/env python
import pygtk,gtk
import sys,time,os,commands
import getpass,grp,pwd

DATADIR='/usr/clas12/hps/DATA/ECAL/'
BACKUPNAMEFORMAT='ECALHV-%Y_%m_%d-%H_%M_%S.txt'
PVFORMAT='B_hv_ECAL_%s_%.2d_property.G'
PVGROUPS=['TOP','BOT']
PVCHANNELS=range(1,26+1)

def exit(text):
    mess = gtk.MessageDialog(buttons=gtk.BUTTONS_OK)
    mess.set_markup(text)
    mess.run()
    mess.destroy()
    sys.exit(text)


class SaveRestore:

    def save(self,filename):
        lines=[]
        for gg in PVGROUPS:
            for cc in PVCHANNELS:
                ret = commands.getoutput('caget '+PVFORMAT%(gg,cc))
                val = ret.rstrip().split()
                if len(val)!=2: exit('CAGET ERROR.\n\nNOT SAVING.')
                lines.append(val[0]+' %.1f'%(float(val[1])))
        if len(lines) != len(PVGROUPS)*len(PVCHANNELS):
            exit('INCORRECT #PVs.\n\nNOT SAVING.')
        file = open(filename,'w')
        for xx in lines: print >> file, xx
        file.close()
        os.chmod(filename,0444) # set it unwriteable
        exit('BACKEDUP ECAL VOLTAGES TO:\n\n'+filename)

    def restore(self,filename):
        lines=[]
        for line in open(filename,'r'):
            cols = line.rstrip().split()
            if len(cols)!=2: exit('INCORRECT #COLUMNS IN FILE:\n\n'+filename+'\n\nNOT RESTORING.')
            pv = cols[0]
            try:
                val = float(cols[1])
            except ValueError:
                exit('INVALID FILE:\n\n'+filename+'\n\nNOT RESTORING.')
            lines.append('caput'+' %s %.1f'%(pv,val))
        if len(lines) != len(PVGROUPS)*len(PVCHANNELS):
            exit('INCORRECT #ROWS IN FILE:\n\n'+filename+'\n\nNOT RESTORING.')
        for cmd in lines:
            os.system(cmd)
        exit('RESTORED ECAL VOLTAGES FROM:\n\n'+filename)


class FileChooser:

    mess = gtk.MessageDialog(buttons=gtk.BUTTONS_OK)
    entry = gtk.Entry(max=0)
    filename = None

    def oldBackup(self):
        chooser = gtk.FileChooserDialog(
            title='HPS ECAL HV BACKUP - CHOOSE EXISTING SNAPSHOT',
            parent=None,
            action=gtk.FILE_CHOOSER_ACTION_OPEN,
            buttons=(gtk.STOCK_CANCEL,gtk.RESPONSE_CANCEL,
                     gtk.STOCK_OPEN,  gtk.RESPONSE_OK)
            )
        chooser.set_preview_widget_active(True)
        chooser.set_default_size(800,300)
        chooser.set_default_response(gtk.RESPONSE_CANCEL)
        chooser.set_current_folder(DATADIR)
        self.filename = None
        response = chooser.run()
        if response == gtk.RESPONSE_OK:
            self.filename = chooser.get_filename()
        chooser.destroy()
        if self.filename==None:
            exit('RESTORE CANCELLED.')
        if not os.path.exists(self.filename):
            exit('FILE D.N.E.\n\nRESTORE CANCELLED.')
        return self.filename

    def newBackup(self):
        win = gtk.Window(gtk.WINDOW_TOPLEVEL)
        win.set_default_size(400,100)
        win.set_title('HPS ECAL HV BACKUP - CREATE SNAPSHOT')
        box = gtk.VBox(False, 0)
        win.add(box)
        box.show()
        text = gtk.Label()
        text2 = gtk.Label()
        text.show()
        text2.show()
        text2.set_markup('\nENTER FILENAME:\n')
        box.pack_start(text2)
        text.set_markup(DATADIR+'\n')
        box.pack_start(text)
        basename = time.strftime(BACKUPNAMEFORMAT)
        self.entry.set_text(basename)
        box.pack_start(self.entry,True,True,0)
        self.entry.show()
        button = gtk.Button(stock=gtk.STOCK_OK)
        button.connect('clicked',self.readEntry,win)
        box.pack_start(button,True,True,0)
        button.show()
        text3 = gtk.Label()
        text3.set_markup('\n(May take a minute after clicking OK)')
        text3.show()
        box.pack_start(text3)
        self.filename = None
        win.show()
        gtk.main()
#        win.destroy()
        return DATADIR+self.filename

    def readEntry(self,widget,win):
        tmp = DATADIR+'/'+self.entry.get_text()
        if os.path.exists(tmp):
            mess = gtk.MessageDialog(buttons=gtk.BUTTONS_OK)
            mess.set_markup('FILE ALREADY EXISTS, TRY AGAIN.')
            mess.run()
            mess.destroy()
            return
        self.filename = self.entry.get_text()
        gtk.main_quit()


def main():

    if len(sys.argv) != 2 or (sys.argv[1]!='save' and sys.argv[1]!='restore'):
        sys.exit('Must use one of save/restore.')

    user = pwd.getpwuid(os.getuid())[0]
    if os.getgid() != grp.getgrnam('clas-4').gr_gid:
      exit('BACKUPS REQUIRE MEMBERSHIP IN GROUP clas-4.\n\n'+user+' IS NOT A MEMBER.\n\nEXITING.')


    chooser = FileChooser()
    backup = SaveRestore()

    if sys.argv[1]=='save':
        filename = chooser.newBackup()
        backup.save(filename)
    elif sys.argv[1]=='restore':
        filename = chooser.oldBackup()
        if filename != None:
            backup.restore(filename)


if __name__ == '__main__': main()
