class blockCloner : public TObject {
public:

  TString **fAllLines;           //hold the lines in the file
  TString *fCloneLine;           //hold the lines in the file
  Int_t fNlines;                 //no of lines in the file - editors start numbering at 1
  Int_t fCloneStart;
  Int_t fCloneEnd;
  Int_t fHaveCloneZone;
};
  
void blockCloner::blockCloner(Char_t *TemplateFileName,Char_t *identifier=NULL,Char_t *start="<widget",Char_t *stop="</widget"){
  FILE *fp;
  Char_t line[420];
  Int_t lastBlockLine=-1;
  Int_t nBlockOpen=-1;
  Int_t nBlockClose=-1;
  

  //init some things;
  fNlines=1;
  fCloneStart=-1; 
  fCloneEnd=-1;
  fHaveCloneZone=0;
  
  //Start by storing the template file ***********************************************************
  fp=fopen(TemplateFileName,"r");                //open once to count lines
  while(fgets(line,400,fp) != NULL){  	   // check got a line from file
    fNlines++;
  }
  fclose(fp);
  fAllLines = new TString*[fNlines];
  fCloneLine = new TString("");

  fNlines=1;                                      //Since editors start numbering at line 1
  fp=fopen(TemplateFileName,"r");                 //open once to read lines
  while(fgets(line,400,fp) != NULL){  	          // check got a line from file
    fAllLines[fNlines]= new TString(line);
    fNlines++;    
  }
  fclose(fp);

  if(identifier==NULL) return;                     //No clone zone defined, return

  fHaveCloneZone=kTRUE;
    
  //Now hunt for the identifier to indicate the block to be cloned
  for(Int_t n=1;n<fNlines;n++){ 
    if(strstr(fAllLines[n]->Data(),start)) lastBlockLine=n;  //keep the line of the lat block starter
    if(strstr(fAllLines[n]->Data(),identifier)){              //check for block we want
      fCloneStart=lastBlockLine;
      nBlockOpen=1;
      nBlockClose=0;
      break;
    }
  }  
  //now count block starts and stops until both are equal, then we go to the end 
  for(Int_t n=fCloneStart;n<fNlines;n++){ 
    if(strstr(fAllLines[n]->Data(),start)){ 
      nBlockOpen++;
    }
    if(strstr(fAllLines[n]->Data(),stop)){
      nBlockClose++;
    }
    if( nBlockOpen==nBlockClose){
      fCloneEnd=n;
      break;
    }
  }
}

  
void blockCloner::~blockCloner();

void blockCloner::Print(Int_t verbose=0){
  //dump the file with numbering relative to start of block.
  for(Int_t n=1;n<fNlines;n++){ 
    if (verbose){    
      if((n>=fCloneStart)&&(n<=fCloneEnd)){
	cout << n << ", " << (n-fCloneStart)+1  << ":\t" << fAllLines[n]->Data();
      }
      else{
	cout << n << ":\t" << fAllLines[n]->Data();
      }
    }
    else{
      if((n>=fCloneStart)&&(n<=fCloneEnd)){
 	cout << (n-fCloneStart)+1  << ":\t" << fAllLines[n]->Data();
      }
    }
  }    
} 


Char_t *blockCloner::GetFileLine(int line){

  if((line<1)||(line>=fNlines)){
    cout << "Error: There is no line " << line << ", line must be in range 1-" << fNlines-1 << endl;
    return NULL;
  }
  return fAllLines[line]->Data();
}


Char_t *blockCloner::GetBlockLine(int line,Char_t *find=NULL,Char_t *replace=""){
  
  Int_t wline=line+fCloneStart-1;
  
  if((wline<fCloneStart)||(wline>fCloneEnd)){
    cout << "Error: There is no line " << line << ", line must be in range 1-" << (fCloneStart-fCloneEnd)+1 << endl;
    return NULL;
  }
  
  if(!find){                                             //if there's nothing to find
    return fAllLines[wline]->Data();                     //return the line
  }
  delete fCloneLine;                                     //delete the old one
  fCloneLine=new TString(fAllLines[wline]->Data());      //copy the line for attention
  fCloneLine->ReplaceAll(find,replace);                  //replace the string

  return fCloneLine->Data();                             //return the modified string
}


Int_t blockCloner::GetCloneStart(){return fCloneStart;}
Int_t blockCloner::GetCloneEnd(){return fCloneEnd;}
