#ifndef _LVMPODCrate_
#define _LVMPODCrate_

#include <string>
#include <vector>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

class MpodCrate{

 public:
  static vector <MpodCrate*> CrateVector;
  MpodCrate(string ip, string name);
  ~MpodCrate(){ };

  vector<int> GetChannels(int slot);
  vector<string> GetBoardTypes();
  vector<string> GetBoardNames();
  int GetSerialNumber(){return SerialNumber;};
  string GetMacAddress(){return MacAddress;};
  string GetIPAddress(){return IP;}
  string GetCPUName(){return Name;};
  int GetNumberOfModules(){return Nmodules;};
  int GetNumberOfChannels(){return Nchannels;};
  vector<int> GetModuleChannels();
  int GetNumberOfChannels(int slot){return NChanMod[slot];};

 private:
  int SerialNumber;    // serial number of crate cpu
  string MacAddress;      // mac addres of crate cpu
  string IP;           // ip number of crate cpu
  string Name;         // cpu name
  int Nmodules;        // number of modules in crate (max=10)
  int Nchannels;       // number of channels in crate
  int NChanMod[10];    // number of channels per module
  vector <string> ChannelNames; // list of strings holding the channel names
  string ModuleNames[10];

  string GetModuleType(int slot);

};

#endif // _LVMPODCrate_
