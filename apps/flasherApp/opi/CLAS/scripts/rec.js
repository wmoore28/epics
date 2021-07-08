importPackage(Packages.java.lang);
importPackage(Packages.org.csstudio.opibuilder.scriptUtil);
importPackage(Packages.org.csstudio.opibuilder.widgetUtil);
importPackage(Packages.org.csstudio.opibuilder.consoleUtil);
importPackage(Packages.org.csstudio.opibuilder.PVUtil);

//This will be called with widget pv set to B_XX......:End
//We will make all other PV names from this.

//Get the End value; (0 or 1)
var end = PVUtil.getLong(widget.getPV());

//Now get the pv_name and chop off the :YYY part
var pv_name = widget.getPropertyValue("pv_name");
var res =  pv_name.split(":");

//The basic element name to construct the other pv names from
var element = res[0]; 

var pv_name = element+":Depth";
ConsoleUtil.writeInfo(pv_name);

widget.setPropertyValue("pv_name",pv_name);
var depth = PVUtil.getLong(widget.getPV());

ConsoleUtil.writeInfo(end);
ConsoleUtil.writeInfo(depth);




//get the name, which is 
//var depth = widget.getPropertyValue("pv_name");

//var childlist = PVUtil.getLong(widget.getPV());
//ConsoleUtil.writeInfo(childlist);
