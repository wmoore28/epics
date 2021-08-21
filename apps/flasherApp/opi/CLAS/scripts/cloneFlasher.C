//Specific Variables to hold the data for the detector elements. called 
// filled from  generateFTLayout(){
Int_t    nElem=0;
Double_t xpos[500];
Double_t ypos[500];
Int_t    xid[500];
Int_t    yid[500];
Int_t    flashid[500];
Int_t    scalerid[500];


Char_t widgetIdentifier[]="Clone";



void cloneFlasher(Char_t *TemplateFileName,Int_t dumpLinesOnly=0){
  
  FILE *fp;
  Char_t filename[200];
  Char_t sVar[200];
  Char_t *outLine;

  //  if(!IsInit){
     gROOT->LoadMacro("blockCloner.C");
     //     IsInit=kTRUE; 
     //  }
  

  blockCloner *b=new blockCloner(TemplateFileName,widgetIdentifier);
  
  if(dumpLinesOnly){            //just print the lines and return, to allow selecting lines to be repalced
    b->Print(dumpLinesOnly-1);  //0 for cloned block only, >0 for verbose
    return;
  }
  
  generateFTLayout();  //Run the detector algorithm function (at the bottom here)
  
  sprintf(filename,"%s.cloned.opi",TemplateFileName);
  fp=fopen(filename,"w"); 
  
  
  //copy all the lines up to the region for cloning.
  for(int n=1;n<b->GetCloneStart();n++){
    outLine=b->GetFileLine(n);
    fprintf(fp,"%s",outLine);
  }

  //loop over all the detector elements and copy the clone block for each one, changing lines as required.
  for(int d=0;d<nElem;d++){
    //for(int d=0;d<3;d++){
    //    for(int n=b->GetCloneStart();n<=b->GetCloneEnd();n++){
    for(int n=1;n<=b->GetCloneSize();n++){
      switch(n){
      case 6:
	sprintf(sVar,"%04d:%04d",d,d);
	outLine=b->GetBlockLine(n,"e9fd3:-7f13",sVar);
	break;
      case 17:
      	sprintf(sVar,"CHAN_ID%d",flashid[d]);
      	outLine=b->GetBlockLine(n,"CHAN_ID1",sVar);
      	break;	
      case 18:
      	sprintf(sVar,"SCALER_%d",flashid[d]);
      	outLine=b->GetBlockLine(n,"SCALER_1",sVar);
      	break;	
      case 34:
      	sprintf(sVar,"SCALER_%d",flashid[d]);
      	outLine=b->GetBlockLine(n,"SCALER_1",sVar);
      	break;	
      case 59:
      	sprintf(sVar,"<y>%d</y>",(int)(28.0*ypos[d]));
      	outLine=b->GetBlockLine(n,"<y>216</y>",sVar);
      	break;	
      case 63:
      	sprintf(sVar,"<x>%d</x>",(int)(28.0*xpos[d]));
      	outLine=b->GetBlockLine(n,"<x>102</x>",sVar);
      	break;		
      default:
	outLine=b->GetBlockLine(n);
	break;
      }
      fprintf(fp,outLine);
    }
  }

  //copy all the lines after the region for cloning.
  for(int n=b->GetCloneEnd()+1;n<b->GetFileEnd();n++){
    outLine=b->GetFileLine(n);
    fprintf(fp,"%s",outLine);
  }
  fclose(fp);
}


  
void generateFTLayout(){   //using information from Rafaella's spreadsheet;
  Double_t x,y,D,R;
  Int_t n=0;
  Int_t f=0;

  //This describes the layout of the caloromiter elements.

  D=15.3;
  
  for(int idx=-11;idx<=11;idx++){
    for(int idy=-11;idy<=11;idy++){
      if((idx==0)||(idy==0)) continue;

      if(idx>0)x=(idx-0.5);else x=(idx+0.5);
      if(idy>0)y=(idy-0.5);else y=(idy+0.5);
      
      R=TMath::Sqrt(x*x + y*y)*D;
      x*=D;y*=D;

      if((60.0<R)&&(R<168.3)){
	xpos[n]=x/D; ypos[n]=y/D; xid[n]=idx; yid[n]=idy; flashid[n]=n; scalerid[n]=n;
	n++;
      }      
    }
  }
  nElem=n;
}
