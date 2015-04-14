///==============================================================================
#ifdef SIMULATION
class CrateMsgClient	///: public TNamed
{
public:
///	TString hostname;
	int hostport;
bool ReadScalers(int slot, unsigned long **val, int *len){

      *val=(unsigned long *)malloc(sizeof(long)*70);
      *len=70; 
      (*val)[4]=1;(*val)[5]=2;(*val)[6]=3;(*val)[7]=4;
return true;
}


bool ReadThresholds(int slot, unsigned long **val, int *len){

      *val=(unsigned long *)malloc(sizeof(long)*70);
      *len=70; 
      (*val)[4]=5;(*val)[5]=6;(*val)[6]=7;(*val)[7]=8;
return true;
}

bool ReadModes(int slot, unsigned long **val, int *len){

      *val=(unsigned long *)malloc(sizeof(long)*70);
      *len=70; 
      (*val)[4]=1;(*val)[5]=2;(*val)[6]=3;(*val)[7]=4;
return true;
}


bool SetThresholds(int slot, int chan, double value, int type ){

return true;
}

bool SetModes(int slot, int chan, double value[] ){

return true;
}


	CrateMsgClient(const char *pHost, int port)
	{
		///hostname = Form("%s",pHost);
		hostport = port;

///#if DEBUG_NOCONNECTION
		///pSocket = NULL;
		///return;
///#endif
		///pSocket = new TSocket(pHost,port,32768);
		///pSocket->SetOption(kNoDelay, 1);
      
		///if(!pSocket->IsValid())
		///{
		///	printf("Failed to connected to host: %s\n", pHost);
		///	Close();
		///	delete pSocket;
		///	pSocket = NULL;
		///}
		///else
		///	printf("Successfully connected to host: %s\n" , pHost);

		///InitConnection();
	}

};
#endif

///=========================================================================================================

uint32_t JlabFadc250Board::GetNumberOfChannels(int flag){

 return NUMBEROFSCALERS_DISC2;

}
///=========================================================================================================


uint32_t JlabDisc2Board::GetNumberOfChannels(int flag){


 return NUMBEROFSCALERS_FADC250;

}

///=========================================================================================================

///==================================================================================================================
// type range: ScalerThreshTrig_Gr1, ScalerThreshTDC_Gr1, ScalerThreshTrig_Gr2, ScalerThreshTDC_Gr2
double JlabBoard::GetScalerCounts
( int chanNumber, int type, bool inHz ){ 

 double ret;
 if(inHz){
  if(type==ScalerThreshTrig_Gr1){
   ret=scalerCountsHz[chanNumber][0];
  }
  else if(type==ScalerThreshTrig_Gr1){
   ret=scalerCountsHz[chanNumber][1];  
  }
  if(type==ScalerThreshTrig_Gr2){
   ret=scalerCountsHz[chanNumber][2];
  }
  else if(type==ScalerThreshTrig_Gr2){
   ret=scalerCountsHz[chanNumber][3]; 
  }
  else ret=-1;
 }
 else{
  int ret_int;
  if(type==ScalerThreshTrig_Gr1){
   ret_int=scalerCounts[chanNumber][0];
   if(ret_int!=-1)ret=scalerCounts[chanNumber][0];
   else ret=ret_int;
  }
  else if(type==ScalerThreshTrig_Gr1){
   ret_int=scalerCounts[chanNumber][1];
   if(ret_int!=-1)ret=scalerCounts[chanNumber][1];
   else ret=ret_int;
  }
  if(type==ScalerThreshTrig_Gr2){
   ret_int=scalerCounts[chanNumber][2];
   if(ret_int!=-1)ret=scalerCounts[chanNumber][2];
   else ret=ret_int;
  }
  else if(type==ScalerThreshTrig_Gr2){
   ret_int=scalerCounts[chanNumber][3];
   if(ret_int!=-1)ret=scalerCounts[chanNumber][3];
   else ret=ret_int;
  }
  else ret=-1;
 }

return ret;

}

///==================================================================================================================
// type range: SCALER_PARTYPE_THRESHOLD (Scaler Gr1), SCALER_PARTYPE_THRESHOLD2(Scaler Gr2)
uint JlabBoard::GetClockCounts( int type ){  

 if(type==SCALER_PARTYPE_THRESHOLD){
   return  scalerClocks[0];
 }
 else  if(type==SCALER_PARTYPE_THRESHOLD2){
   return  scalerClocks[1];
 }

 return -1;

}

///==================================================================================================================
