DIR=`dirname $0`
#cd /group/halld/Online/controls/epics/extensions/CSS/linux-x86/CSS_EPICS_3.0.0
cd /group/halld/Online/controls/css/linux-x86/CSS_EPICS_3.1.0
./css --launcher.openFile $DIR/HV_configurator.opi
#./css -Dosgi.locking=none --launcher.runOpi   $DIR/JLabDiscr_sub.opi
