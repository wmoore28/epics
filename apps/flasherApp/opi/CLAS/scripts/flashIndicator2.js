importPackage(Packages.org.csstudio.opibuilder.scriptUtil);
var pv0 = PVUtil.getDouble(pvs[0]); //LED ID 1-6
var pv1 = PVUtil.getDouble(pvs[1]);
var pv2 = PVUtil.getDouble(pvs[2]);
var pv3 = PVUtil.getDouble(pvs[3]);
var pv4 = PVUtil.getDouble(pvs[4]);
var pv5 = PVUtil.getDouble(pvs[5]);
var pv6 = PVUtil.getDouble(pvs[6]); //Channel no of the current widget
var pv7 = PVUtil.getDouble(pvs[7]); //Scaler of Channel No.
var pv8 = PVUtil.getDouble(pvs[8]); //Maximum of range for colour levels
var pv9 = PVUtil.getDouble(pvs[9]); //Log/Lin for plotting

//If LED 1-6 matches current. Switch on by lighting the border.
if(pv0==pv6)
	widget.setPropertyValue("border_style",1);
else if(pv1==pv6)
	widget.setPropertyValue("border_style",1);
else if(pv2==pv6)
	widget.setPropertyValue("border_style",1);
else if(pv3==pv6)
	widget.setPropertyValue("border_style",1);
else if(pv4==pv6)
	widget.setPropertyValue("border_style",1);
else if(pv5==pv6)
	widget.setPropertyValue("border_style",1);
else
	widget.setPropertyValue("border_style",0);


if(pv7>0){
	S=pv7;
	if (pv9>0){
		pv7 = Math.log(pv7)/Math.log(10);
		pv8 = Math.log(pv8)/Math.log(10);
	}
	
	//rgb alrogithm.
//	R=(255*pv7)/pv8;
//	G=(255*(pv8-pv7))/pv8; 
//	B=0;
R=255;
//	R=(255*pv7)/pv8;
	G=(255*pv7)/pv8; 
	B=(255*pv7)/pv8;
	widget.setPropertyValue("background_color",ColorFontUtil.getColorFromRGB(R,G,B));
}
	
else
	widget.setPropertyValue("background_color",ColorFontUtil.getColorFromRGB(255,255,255));

