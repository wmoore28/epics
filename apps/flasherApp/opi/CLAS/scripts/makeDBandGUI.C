//Variables to hole the data from the template files
TString **AllLinesDB;       //hold the lines in the file
Int_t NlinesDB=1;            //no of lines in the file - editors start numbering at L1
TString **AllLinesGUI;      //hold the lines in the file
Int_t NlinesGUI=1;           //no of lines in the file - editors start numbering at L1

//Variables to hold the data for the detector elements.
Int_t    nElem=0;
Double_t xpos[500];
Double_t ypos[500];
Int_t    xid[500];
Int_t    yid[500];
Int_t    flashid[500];
Int_t    scalerid[500];

Char_t GUICloneID[]="<wuid>-1a830ef0:145fa320156:7329</wuid>";
Int_t GUICloneStart=-1;
Int_t GUICloneEnd=-1;

void makeDBandGUI(Char_t *TemplateFileNameDB,Char_t *TemplateFileNameGUI, Int_t dumpLinesOnly=0){
  FILE *fpDB;
  FILE *fpGUI;
  Char_t line[420];
  Char_t filenameDB[200];
  Char_t filenameGUI[200];
  Char_t sVar[200];
  Int_t iVar1;
  Int_t iVar2;
  Float_t fVar1;
  Float_t fVar2;
  TString outString;
  Int_t lastWidgetLine=-1;
  Int_t nWidgetOpen=-1;
  Int_t nWidgetClose=-1;
  
  //Start by storing the template files ***********************************************************
  fpDB=fopen(TemplateFileNameDB,"r");              //open once to count lines
  while(fgets(line,400,fpDB) != NULL){  	   // check got a line from file
    NlinesDB++;
  }
  fclose(fpDB);
  AllLinesDB = new TString*[NlinesDB];
  
  NlinesDB=1;                                      //Since editors start numbering at line 1
  fpDB=fopen(TemplateFileNameDB,"r");              //open once to read lines
  //cout << "Listing for TemplateFileNameDB" << endl;
  while(fgets(line,400,fpDB) != NULL){  	   // check got a line from file
    AllLinesDB[NlinesDB]= new TString(line);
    //cout << "L" << NlinesDB<< ":   " <<AllLinesDB[NlinesDB]->Data();
    NlinesDB++;
  }
  fclose(fpDB);

  cout << endl << endl;

  fpGUI=fopen(TemplateFileNameGUI,"r");            //open once to count lines
  while(fgets(line,400,fpGUI) != NULL){  	   // check got a line from file
    NlinesGUI++;
  }
  fclose(fpGUI);
  AllLinesGUI = new TString*[NlinesGUI];
  
  NlinesGUI=1;                                            //Since editors start numbering at line 1
  fpGUI=fopen(TemplateFileNameGUI,"r");                   //open once to read lines
  //cout << "Listing for TemplateFileNameGUI" << endl;
  while(fgets(line,400,fpGUI) != NULL){  		  // check got a line from file
    AllLinesGUI[NlinesGUI]= new TString(line);
    //    cout << "L" << NlinesGUI<< ":   " <<AllLinesGUI[NlinesGUI]->Data();
    NlinesGUI++;
  }
  fclose(fpGUI);


  //Now hunt for the wuid to indicate the widget to be cloned
  for(Int_t n=1;n<NlinesGUI;n++){ 
    //   cout << "n: " << n << " " << AllLinesGUI[n]->Data();
    if(strstr(AllLinesGUI[n]->Data(),"<widget")) lastWidgetLine=n;
    if(strstr(AllLinesGUI[n]->Data(),GUICloneID)){
      GUICloneStart=lastWidgetLine;
      nWidgetOpen=1;
      nWidgetClose=0;
      break;
    }
  }
  for(Int_t n=GUICloneStart;n<NlinesGUI;n++){ 
    if(strstr(AllLinesGUI[n]->Data(),"<widget")){ 
      nWidgetOpen++;
    }
    if(strstr(AllLinesGUI[n]->Data(),"</widget")){
      nWidgetClose++;
    }
    if( nWidgetOpen==nWidgetClose){
      GUICloneEnd=n;
      break;
    }
  }
  
  //dump the file with numbering relative to start of widget.
  for(Int_t n=1;n<NlinesGUI;n++){ 
    if (dumpLinesOnly==2){    
      if((n>=GUICloneStart)&&(n<=GUICloneEnd)){
	cout << n << ", " << (n-GUICloneStart)+1  << ":\t" << AllLinesGUI[n]->Data();
      }
      else{
	cout << n << ":\t" << AllLinesGUI[n]->Data();
      }
    }
    else{
      if((n>=GUICloneStart)&&(n<=GUICloneEnd)){
 	cout << (n-GUICloneStart)+1  << ":\t" << AllLinesGUI[n]->Data();
      }
    }
  }    
   

  if(dumpLinesOnly) return;
  // end of section storing the template files ************************************************************


  //Run the detector algorithm to fill these variables - declared as global at the top. *******************
  //Int_t    nElem=0;
  //Double_t xpos[500];
  //Double_t ypos[500];
  //Int_t    xid[500];
  //Int_t    yid[500];
  //Int_t    flashid[500];
  //Int_t    scalerid[500];
  //..... etc

  generateFTLayout();  //Run the detector algorithm function at the bottom here
  // ******************************************************************************************************

  //Open the corresponding output files fill them based on the detector specific algorithm ****************
  //
  //This requires looking at the template files and figuring out which lines need to be cloned, 
  //and what needs tobe replaced etc.
  //Either open the templates in emacs, or run this function with dumpLinesOnly=1 to see the line numbers

  //DB file
  //make new names for the output file, open in write mode

  sprintf(filenameDB,"%s.cloned",TemplateFileNameDB);
  fpDB=fopen(filenameDB,"w"); 

  //Copy the 1st part from the template.
  for(Int_t n=1;n<=8;n++){                //1st part of db file
    fprintf(fpDB,"%s",AllLinesDB[n]->Data());
  }

  //Create a lot of lines according to some algorithm
  fprintf(fpDB,"#The following lines (until ### end of autogen ###) were autogenerated from a script\n#\n");
  //do the lines for all the elements
  for(int n=0;n<nElem;n++){
    fprintf(fpDB,"   {\"B_FT_FLASHER\",\"L0\",\"%d\",\"%d\",\"%d\"}\n",scalerid[n],xid[n],yid[n]);
  }
  fprintf(fpDB," ### end of autogen ###\n#\n");

  //copy the remaining lines from the template.
  for(Int_t n=10;n<=10;n++){                //1st part of db file
    fprintf(fpDB,"%s",AllLinesDB[n]->Data());  
  }
  
  //GUI file
  sprintf(filenameGUI,"%s.cloned",TemplateFileNameGUI);
  fpGUI=fopen(filenameGUI,"w");
  for(Int_t n=1;n<=74;n++){                //1st part of opi file
    fprintf(fpGUI,"%s",AllLinesGUI[n]->Data());
  }
  
  
  //Now do some cloning
  for(int n=0;n<nElem;n++){
    for(int l=75;l<=250;l++){
      outString=AllLinesGUI[l]->Copy();
      switch (l){
      case 82:
	sprintf(sVar,"%04d:%04d",n,l);
	outString->ReplaceAll("0156:7329",sVar);
	break;
      case 89:
	sprintf(sVar,"angle %d",n);
	outString->ReplaceAll("angle",sVar);
	break;
      case 126:
	sprintf(sVar,"<y>%d</y>",(int)ypos[n]);
	outString->ReplaceAll("<y>24</y>",sVar);
	break;	
      case 129:
	sprintf(sVar,"<x>%d</x>",(int)ypos[n]);
	outString->ReplaceAll("<x>24</x>",sVar);
	break;	
      case 151:
	sprintf(sVar,"CHAN_ID%d",flashid[n]);
	outString->ReplaceAll("CHAN_ID1",sVar);
	break;	
      case 193:
	sprintf(sVar,"<y>%d</y>",((int)ypos[n])+6);
	outString->ReplaceAll("<y>30</y>",sVar);
	break;	
      case 193:
	sprintf(sVar,"<x>%d</x>",((int)xpos[n])+14);
	outString->ReplaceAll("<y>38</y>",sVar);
	break;	

      default:
	break;
      }
      fprintf(fpGUI,"%s",outString);
    }
  }
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
