//
Int_t    nElem=0;
Double_t xpos[500];
Double_t ypos[500];
Int_t    xid[500];
Int_t    yid[500];
Int_t    flashid[500];
Int_t    scalerid[500];

void makeGUI(Char_t *filename){
  Char_t adlFile[100];
  Char_t opiFile[100];
  FILE *fpadl,*fpopi;
  
  sprintf(adlFile,"%s.adl",filename);
  sprintf(opiFile,"%s.opi",filename);
  
  // fpadl=fopen(adlfile,"w");

  // writeAdlInit();
  
}
void generateFTLayout(){   //from Rafaella's spreadsheet;
  Double_t x,y,D,R;
  Int_t n=0;
  Int_t f=0;
  
  D=15.3;
  
  for(int idx=-11;idx<=11;idx++){
    for(int idy=-11;idy<=11;idy++){
      if((idx==0)||(idy==0)) continue;

      if(idx>0)x=(idx-0.5);else x=(idx+0.5);
      if(idy>0)y=(idy-0.5);else y=(idy+0.5);
      
      //cout << "idx "<< idx << " idy "<< idy <<" x "<<  x <<" y "<<  y << endl;
      R=TMath::Sqrt(x*x + y*y)*D;
      x*=D;y*=D;

      if((60.0<R)&&(R<168.3)){
	cout << "idx "<< idx << " idy "<< idy <<" x "<<  x <<" y "<<  y <<" R "<<  R << "*** " << n << endl;
	xpos[n]=x/D; ypos[n]=y/D; xid[n]=idx; yid[n]=idy; flashid[n]=n; scalerid[n]=n;
	n++;
      }      
      else{
	//	cout << "idx "<< idx << " idy "<< idy <<" x "<<  x <<" y "<<  y <<" R "<<  R << endl;
      }	
    }
  }
  nElem=n;
}


void makeAdlGUI(Double_t spacing=33.0){
  for(int n=0;n<nElem;n++){
    fprintf(stdout,"rectangle {\n");
    fprintf(stdout,"	object {\n");
    fprintf(stdout,"		x=%d\n",600+(int)(spacing*xpos[n]));
    fprintf(stdout,"		y=%d\n",600-(int)(spacing*ypos[n]));
    fprintf(stdout,"		width=%d\n",(int)(spacing-2.0));
    fprintf(stdout,"		height=%d\n",(int)(spacing-2.0));
    fprintf(stdout,"	}\n");
    fprintf(stdout,"	\"basic attribute\" {\n");
    fprintf(stdout,"		clr=30\n");
    fprintf(stdout,"	}\n");
    fprintf(stdout,"}\n");
  }
}
