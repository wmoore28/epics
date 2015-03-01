// LVMPOD_InitCrate.cpp
// Author: Beni Zihlmann
// created: Fri Mar  1 11:51:06 EST 2013
//
//


#include "LVMPODCrate.h"

// class constructor MpodCrate
int DEBUG = 99;
vector <MpodCrate*> MpodCrate::CrateVector;

MpodCrate::MpodCrate(string ip, string name){

  // first check connection by trying to get MAC address from frontend board
  string cmd0("snmpget -Oqv -v 2c -m +WIENER-CRATE-MIB -c public ");
  string cmd1("snmpwalk -Oqv -v 2c -m +WIENER-CRATE-MIB -c public ");
  string cmd(cmd0+ip+" macAddress.0");
  FILE *io;
  char buff[512];
  int MakeConnection = 0;
  int Tries=0;
  while (!MakeConnection && Tries<10) {
    Tries++;
    if( (io = popen(cmd.c_str(),"r")) ) {
      MakeConnection = 1;
    }
  }

  if (MakeConnection){
    fgets(buff, sizeof(buff), io);
    string res(buff);
    res.erase(0,1);
    res.erase(res.size()-1,1);
    res.erase(res.size()-1,1);
    MacAddress = res.c_str();
    if (DEBUG) { 
      cout<<"MAC address is "<<res<<endl;
    }
    pclose(io);
  } else {
    cout<<"MpodCrate:: Error make connection to "<<ip<<endl;
  }

  Name = name;

  cmd = cmd0+ip+" ipDynamicAddress.0";
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  pclose(io);
  string res(buff); 
  res.erase(res.size()-1);
  IP = res;
  if (DEBUG) { 
    cout<<"Dynamic IP address is "<<IP<<endl;
  }

  cmd = cmd0+ip+" psSerialNumber.0";
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  pclose(io);
  res = buff;
  SerialNumber = atoi(res.c_str());
  if (DEBUG) { 
    cout<<"Crate Serial Number is "<<SerialNumber<<endl;
  }
  cmd = cmd0+ip+" outputNumber.0";
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  pclose(io);
  res = buff;
  Nchannels = atoi(res.c_str());
  if (DEBUG) { 
    cout<<"Number of channels found in crate: "<<Nchannels<<endl;
  }
  cmd = cmd1+ip+" outputName";
  io = popen(cmd.c_str(),"r");

  // initialize counters and channel name list

  for (int i=0;i<10;i++){
    NChanMod[i]=0;
  }
  if (!ChannelNames.empty()){ 
    ChannelNames.clear();
  }
  while(fgets(buff, sizeof(buff), io)){

    string res(buff);
    res.erase(res.size()-1);
    ChannelNames.push_back(res);

    if (DEBUG>2) {
      cout<<"Channel Name: "<<res<<endl;
    }

    res.erase(0,1);
    int ChanNum = atoi(res.c_str());
    if (ChanNum<100){
      NChanMod[0]++;
    } else if  (ChanNum<200){
      NChanMod[1]++;
    } else if  (ChanNum<300){
      NChanMod[2]++;
    } else if  (ChanNum<400){
      NChanMod[3]++;
    } else if  (ChanNum<500){
      NChanMod[4]++;
    } else if  (ChanNum<600){
      NChanMod[5]++;
    } else if  (ChanNum<700){
      NChanMod[6]++;
    } else if  (ChanNum<800){
      NChanMod[7]++;
    } else if  (ChanNum<900){
      NChanMod[8]++;
    } else if (ChanNum<1000) {
      NChanMod[9]++;
    }
    
  }
  
  Nmodules=0;
  for (int i=0;i<10;i++){
    if (NChanMod[i]>0){
      Nmodules++;
      ModuleNames[i] = GetModuleType(i);
    }
  }
  
  if (DEBUG==9){
    cout<<"Crate has Serial Number "<<SerialNumber<<endl;
    cout<<"Total Number of Channels "<<Nchannels<<endl;
    cout<<"Total Number of Modules "<<Nmodules<<endl;
      
  }


  CrateVector.push_back(this);
}


string MpodCrate::GetModuleType(int slot){

  int Number = slot*100;
  char str[128];
  sprintf(str,"%d",Number);
  string Chan(str);
  string cmd = "snmpget -Oqv -v 2c -m +WIENER-CRATE-MIB -c public "+IP+" outputConfigMaxSenseVoltage.u"+Chan;
  FILE *io;
  char buff[512];
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  string res(buff);
  res.erase(res.size()-5,res.size()-1);
  float MaxVoltage = atof(res.c_str());
  pclose(io);

  cmd = "snmpget -Oqv -v 2c -m +WIENER-CRATE-MIB -c public "+IP+" outputConfigMaxCurrent.u"+Chan;
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  res = buff;
  res.erase(res.size()-5,res.size()-1);
  float MaxCurrent = atof(res.c_str());
  pclose(io);

  // this is usefull to determine if it is a HV or a LV board
  cmd = "snmpget -Oqv -v 2c -m +WIENER-CRATE-MIB -c public "+IP+" outputSupervisionMaxSenseVoltage.u"+Chan;
  io = popen(cmd.c_str(),"r");
  fgets(buff, sizeof(buff), io);
  res = buff;
  int loc1 = res.find("nan");
  int HV=0;
  if ( loc1 != string::npos ) {
    //  if (loc1>0){
    HV=1;
  }
  pclose(io);

  if (DEBUG) {     
    cout<<"Module slot "<<slot<<" ::    ";
    cout<<"Maximum current: "<<MaxCurrent<<"                  Maximum voltage: "<<MaxVoltage<<endl;
  }

  string Mnam;
  if (HV){
    Mnam += "EHS_";
  } else{
    Mnam += "MPV_";
  }
  if (HV){
    if (MaxVoltage == 100.0){
      Mnam += "201p-F-K";
    } else if (MaxVoltage == 500.0){
      Mnam += "205p-F";
    } else if (MaxVoltage == 1000.0){
      Mnam += "210p-F";
    }      
  } else {
    if ((MaxVoltage == 8.0) && (MaxCurrent == 5.0)){
      Mnam += "8008L";
    } else if ((MaxVoltage == 8.0) && (MaxCurrent == 10.0)){
      Mnam += "8008"; 
    } else if ((MaxVoltage == 15.0) && (MaxCurrent == 5.0)){
      Mnam += "8016"; 
    } else if ((MaxVoltage == 30.0) && (MaxCurrent == 2.5)){
      Mnam += "8030"; 
    } else if ((MaxVoltage == 60.0) && (MaxCurrent == 1.0)){
      Mnam += "8060"; 
    } else if ((MaxVoltage == 120.0) && (MaxCurrent == 0.1)){
      Mnam += "8120"; 
    }
  }
  if (DEBUG) { 
    cout<<"Slot "<<slot<<" module type: "<<Mnam<<endl;
  }
  return Mnam;
}

vector<int> MpodCrate::GetChannels(int slot){

  vector<int> ChannelNumbers;

  for (vector<string>::iterator i = ChannelNames.begin(); i != ChannelNames.end(); ++i){
    string str = *i;
    str.erase(0,1);
    int ChanVal = atoi(str.c_str());

    if (ChanVal<slot*100+100){
      ChannelNumbers.push_back(ChanVal);     
      if (DEBUG){
	cout<<"Slot "<<slot<<" Channel Values: "<<ChanVal<<endl;
      }
    }
  }

  return ChannelNumbers;

}

vector<string> MpodCrate::GetBoardTypes(){

  vector<string> Types;
  for (int i=0;i<10;i++){
    if (NChanMod[i]>0){
      Types.push_back(ModuleNames[i]);
    }
  }

  return Types;

}

// Return board name of the boards in every slot
// If there is no board, "N/A" is returned
vector<string> MpodCrate::GetBoardNames() {
	vector<string> boardNames;
	for (int i=0;i<10;i++){
		if (NChanMod[i]>0){
			boardNames.push_back(ModuleNames[i]);
		} else {
			boardNames.push_back("N/A");
		}
	}
	return boardNames;
}

vector<int> MpodCrate::GetModuleChannels(){
  vector<int> vec;
  for (int i=0;i<10;i++){
    vec.push_back(NChanMod[i]);
  }
  
  return vec;

}

