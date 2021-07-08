importPackage(Packages.org.csstudio.opibuilder.scriptUtil);

// Fill arrays with the geometry
var n=0;
var f=0;
var xpos = [];
var ypos = [];
var xid = []; 
var yid = []; 
var flashid = []; 
var scalerid = [];
	


//This describes the layout of the caloromiter elements.

var D=15.3;
var scale=widget.getMacroValue("ElementScale");
  
for(var idx=-11;idx<=11;idx++){
	for(var idy=-11;idy<=11;idy++){
      	if((idx==0)||(idy==0)) continue;

      	if(idx>0)x=(idx-0.5);else x=(idx+0.5);
      	if(idy>0)y=(idy-0.5);else y=(idy+0.5);
      
      	R=Math.sqrt(x*x + y*y)*D;
      	x*=D;y*=D;

      	if((60.0<R)&&(R<168.3)){
			xpos[n]=x/D; ypos[n]=y/D; xid[n]=idx; yid[n]=idy; flashid[n]=n; scalerid[n]=n;
		n++;
   		}      
    }
}
nElem=n;

// loop over and make the widgets
// for ( var n = 0; n < nElem; n++ ){
for ( var n = 0; n < 1; n++ ){
	scale=scale*10;
	var element = WidgetUtil.createWidgetModel("org.csstudio.opibuilder.widgets.TextUpdate");
	element.setPropertyValue("x", scale*xpos[n]);
	element.setPropertyValue("y", scale*ypos[n]);
	element.setPropertyValue("name", "element0");
	element.setPropertyValue("pv_name", "B_FT_FLASHER:SCALER_1");
	element.setPropertyValue("scripts", "testVar.js");
	
	widget.addChild(element);
	widget.getWidget("element0");
}	widget.setVar("kenneth",42);
