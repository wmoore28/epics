importPackage(Packages.org.csstudio.opibuilder.scriptUtil);
var pv0 = PVUtil.getDouble(pvs[0]);
var pv1 = PVUtil.getDouble(pvs[1]);
var pv2 = PVUtil.getDouble(pvs[2]);
var pv3 = PVUtil.getDouble(pvs[3]);
var pv4 = PVUtil.getDouble(pvs[4]);
var pv5 = PVUtil.getDouble(pvs[5]);
var pv6 = PVUtil.getDouble(pvs[6]);
if(pv0==pv6)
	widget.setPropertyValue("visible",true);
else if(pv1==pv6)
	widget.setPropertyValue("visible",true);
else if(pv2==pv6)
	widget.setPropertyValue("visible",true);
else if(pv3==pv6)
	widget.setPropertyValue("visible",true);
else if(pv4==pv6)
	widget.setPropertyValue("visible",true);
else if(pv5==pv6)
	widget.setPropertyValue("visible",true);
else
	widget.setPropertyValue("visible",false);
