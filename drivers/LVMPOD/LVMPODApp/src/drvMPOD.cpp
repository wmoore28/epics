
/* File:    drvMPOD.h
 * Author:  Hovanes Egiyan, Jefferson Lab
 * Date:    05-Mar-2013
 *
 * Purpose: 
 * This module provides the driver support for the asyn device support layer
 * for the MPOD crates.
 *
 */


#include "drvMPOD.hh"
#include "drvGlobalMPOD.hh"

//! Declare global mutex and its attributes
pthread_mutex_t     drvMPOD::dmClassMutex;
pthread_mutexattr_t drvMPOD::dmClassMtxAttr;

//! Initialize global mutex and its attributes
static int dummyInt = drvMPOD::initGlobalMutex();

static const char *driverName="asynMPOD";

map<string,drvMPOD*> drvMPOD::dmPortMap;
string drvMPOD::dmChassisFileNameDB				= "readConfigChassisMPOD.db" ;
string drvMPOD::dmBoardFileNameDB  				= "readConfigBoardsMPOD.db"  ;
string drvMPOD::dmChassisSnmpFileNameDB 		= "mpod_chassis.db";

vector<string>  drvMPOD::dmMbbPrefixVec  		= drvMPOD::initPrefixVector();
map<string, drvMPOD*>  drvMPOD::dmMbbPrefixMap  = drvMPOD::initMbbMap( drvMPOD::dmMbbPrefixVec );
map<string,string> drvMPOD::dmBoardFileNameMap  = drvMPOD::initBoardFileNameMap();



/*Constructor */
drvMPOD::drvMPOD( const char* ipAddress, const char* asynPortName, int maxNumberOfSlots ) :
  asynPortDriver( asynPortName, maxNumberOfSlots, NUM_MPOD_PARAMS,
		  asynInt32Mask | asynOctetMask | asynDrvUserMask | asynCommonMask | asynOptionMask,
		  asynInt32Mask | asynOctetMask | asynDrvUserMask | asynCommonMask | asynOptionMask,
		  ASYN_CANBLOCK | ASYN_MULTIDEVICE, 1, 0, 0 ),
//		  0, 1, 0, 0 ),
		  dmIP(ipAddress), dmExists(false), dmCrate(0), dmMbbPrefix("")
{
	cout << "In function " << " drvMPOD::drvMPOD " << endl;
	initMutex();

	{
		MtxLock classLock( dmClassMutex );
		// Check if a port under this name already exists
		if( dmPortMap.count(portName) > 0  ) throw ( string("Port named ") + string(portName) + string( "already exists" ) );
		dmPortMap[portName] = this;

	}
	static const char* functionName="drvMPOD::drvMPOD";
  
	cout << "Maximum number of boards is " << maxNumberOfSlots << endl;

	{
		MtxLock scopeLock( dmMutex );
		this->dmEventID = epicsEventCreate( epicsEventEmpty );
		createParam( MPODBoardNumberString	,    asynParamInt32				, &MPODBoardNumber_		);  /*  int32,  RO  */
		createParam( MPODChannelNumberString,    asynParamInt32				, &MPODChannelNumber_	);  /*  int32,  RO  */
		createParam( MPODBoardTypeString	,    asynParamOctet				, &MPODBoardType_ 		);  /*  string, RO  */
		createParam( MPODChassisPortString	,    asynParamOctet				, &MPODChassisPort_		);  /*  string, RO  */
		createParam( MPODChassisAddrString	,    asynParamOctet				, &MPODChassisAddr_		);  /*  string, RO  */
	}
	// Uncomment this line to enable asynTraceFlow during the constructor
//	pasynTrace->setTraceMask( pasynUserSelf, 0x11 );
	pasynTrace->setTraceMask( pasynUserSelf, 0x255 );

	// Try to create an MPOD object with the ip address and port name
	try {
		MtxLock classLock( dmClassMutex );
		dmCrate = new MpodCrate( dmIP, portName );
	}

	catch ( string& errString ) {
		cout << errString << endl ;
		exit(0);
	}

	int status = 0;
	/* Create the thread that reads the values from the registers in the background */
	status = (asynStatus)(
	        epicsThreadCreate(portName, epicsThreadPriorityMedium,
	                epicsThreadGetStackSize(epicsThreadStackMedium),
	                (EPICSTHREADFUNC) ::readCrateParameters, this) == NULL);
	if ( status ) {
		printf( "%s:%s: epicsThreadCreate failure\n", driverName, functionName );
		return;
	}

	MtxLock classLock( dmClassMutex );
	// Assign the string for the string of mbbi/mbbo record by looking
	// at the map of the 16 string to see which one is available
	for( unsigned iPref = 0; iPref < dmMbbPrefixVec.size(); iPref++ ) {
		string   mbbString = dmMbbPrefixVec[iPref];
		drvMPOD* portPtr   = dmMbbPrefixMap[mbbString];
		if( portPtr == 0 ) {
			dmMbbPrefix = mbbString;
			dmMbbPrefixMap[mbbString] = this;
			cout << "Found prefix " <<  mbbString << endl;
			break;
		}
	}
	// If no mbbi/mbbo string could be found throw an exception
	if( dmMbbPrefix == "") {
		cout << "Problem in " << functionName << " all 16 MPOD chassis ports are used. No more MPOD chassis "  << endl;
		throw "No More Chassis";
	}
	// Assign the address to the portmap
	dmPortMap[portName] = this;

	dmExists = true;
	return;
}


// Destructor
drvMPOD::~drvMPOD() {
	MtxLock classLock( dmClassMutex );
	// If the portname existed in the static map or portnames, remove it from the map
	if( dmPortMap.count( string(portName) ) > 0  ) {
		dmPortMap.erase( string( portName ) ); 	// Remove this address from the map of the ports
		dmMbbPrefixMap[dmMbbPrefix] = 0;			// Free the mbbi/mbbo string for use
	}
	closeMutex();
	return;
}

// Assign the first two letter for the mbbi/mbbo string field for
// each of the sixteen chassis. This will limit the number of chassis to 16.
vector<string> drvMPOD::initPrefixVector() {
	MtxLock classLock( dmClassMutex );
	vector<string> prefVec(16);
	prefVec[0]  = "ZR";
	prefVec[1]  = "ON";
	prefVec[2]  = "TW";
	prefVec[3]  = "TH";
	prefVec[4]  = "FR";
	prefVec[5]  = "FV";
	prefVec[6]  = "SX";
	prefVec[7]  = "SV";
	prefVec[8]  = "EI";
	prefVec[9]  = "NI";
	prefVec[10] = "TE";
	prefVec[11] = "EL";
	prefVec[12] = "TV";
	prefVec[13] = "TT";
	prefVec[14] = "FT";
	prefVec[15] = "FF";
	return prefVec;
}

// Assign null pointers to the map of the mbbi/mbbo mapping.
// Null pointer will be interpreted as this mbbi item is vacant
map<string,drvMPOD*> drvMPOD::initMbbMap( vector<string>& prefVec ) {
	MtxLock classLock( dmClassMutex );
	map<string,drvMPOD*> prefMap;
	cout << "Initializing MBBI string map" << endl;
	// Assign zero to all map entries by actually creating those entries
	for( unsigned iPref = 0; iPref < prefVec.size(); iPref++ ) {
		prefMap[prefVec[iPref]] = 0;
	}
	cout << "Done initializing mbbo map" <<  endl;
	return prefMap;
}

// Initialize the mapping between the board types and the template file
// names to be used for loading the EPICS DB for particluar board.
map<string,string> drvMPOD::initBoardFileNameMap() {
	MtxLock classLock( dmClassMutex );
	map<string,string> boardNames;
	boardNames["EHS_201p-F-K"] = "ehs_f_201pf.db";
	boardNames["EHS_205p-F"]   = "ehs_f_205pf.db";
        boardNames["EHS_210p-F"]   = "ehs_f_210pf.db";
        boardNames["MPV_8008"]     = "mpv_8008.db";
	boardNames["MPV_8008L"]    = "mpv_8008l.db";
	boardNames["MPV_8030"]     = "mpv_8030.db";
	boardNames["MPV_8030L"]    = "mpv_8030l.db";
	return boardNames;
}

/*
asynStatus drvMPOD::readInt32( asynUser* pasynUser, epicsInt32* value ) {
	static const char *functionName = "drvV1495CR::readInt32";
	cout << "Entered function " << functionName << endl;
	int function = pasynUser->reason;
	int address;
	getAddress( pasynUser, &address );
	cout << "Reading for parameter " << function << " for address " << address << endl;

	int asynAddr;
	pasynManager->getAddr(pasynUser, &asynAddr);
	cout << "Asyn address is " << asynAddr << endl;

	asynStatus aStat = asynError;
	if( function == MPODChannelNumber_ ) {
		vector<epicsInt32> nChanVec   = dmCrate->GetModuleChannels();
		*value = nChanVec[address];
		aStat = setIntegerParam( address,  MPODChannelNumber_,  *value );
	}
	if( aStat )
		asynPrint(pasynUser, ASYN_TRACE_ERROR,
	      "%s:%s error, status=%d address=%d, function=%d, value=%d\n",
	      driverName, functionName, aStat, address, function, value);
	else
	    asynPrint(pasynUser, ASYN_TRACEIO_DRIVER,
	      "%s:%s:: address=%d, function=%d, value=%d\n",
	      driverName, functionName, address, function, value);

	callParamCallbacks(address, address);

	return aStat;
}
*/



/* Report  parameters */
void drvMPOD::report( FILE *fp, int details ) {
  if ( details > 0 ) {
//     fprintf(fp, "  Scratch Content  = 0x%x\n",   MPODSratch_     );
  }
  // Call the base class method
  asynPortDriver::report( fp, details );
  return;
}

// This function reads the registers and calls the callbacks
// It is supposed to run in a separate thread for each board 
// Because the registers are read here we do not need to read 
// in our new readUInt32Digital function, just call the base version in 
// case the SCAN field is set to some fixed rate scanning. 
// The values read here will be moved to th appropriate records.  
void drvMPOD::readCrateParameters( void ) {
	asynStatus aStat ;
	// Set updating time to value in seconds
	double updateTime = 2.0;
	//  while( taskDelay(sysClkRateGet())  ) {
	while( 1 ) {
		epicsEventId eventID;
		{
			MtxLock objLock( dmMutex );
			eventID = this->dmEventID;
		}
		epicsEventWaitWithTimeout( eventID, updateTime );

		//   usleep( 100000 );
		//     if (run) epicsEventWaitWithTimeout(this->eventId, updateTime);
		//     else     epicsEventWait(this->eventId);
		//     /* run could have changed while we were waiting */
		//     getIntegerParam(P_Run, &run);
		//     if (!run) continue;

		// Read number channels per board and their types
		MtxLock objLock( dmMutex );
		vector<epicsInt32> nChanVec   = dmCrate->GetModuleChannels();
		vector<string>     brdTypeVec = dmCrate->GetBoardNames();
		if( nChanVec.size() < brdTypeVec.size() || nChanVec.size() > (unsigned)maxAddr ) {
			cout << "Bad number of slots: " <<  nChanVec.size() << " and " <<  brdTypeVec.size() << " . Exiting ... " << endl;
			abort();
		}
//		cout << "Checking Slots " << endl;
		for( unsigned iSlot = 0; iSlot < nChanVec.size(); iSlot++ ) {
//			cout << "Will set number of channels for " << iSlot << "-th slot, it is " << nChanVec[iSlot] << endl;
			aStat = setIntegerParam( iSlot, MPODChannelNumber_, nChanVec[iSlot] );
			if( aStat != asynSuccess ) cout << "Could not set Integer parameter " << MPODChannelNumber_ << " slot " << iSlot << endl;
			setStringParam( iSlot, MPODBoardType_, brdTypeVec[iSlot].c_str() );
			if( aStat != asynSuccess ) cout << "Could not set string parameter " << MPODBoardType_ << " slot " << iSlot << endl;
			callParamCallbacks( iSlot );
		}

		// Set the chassis parameters
		aStat = setStringParam( MPODChassisPort_, portName );
//		cout << "Set port parameter to " << portName << endl;
		aStat = setStringParam( MPODChassisAddr_, dmCrate->GetIPAddress().c_str() );
//		cout << "Set Address parameter to " << dmCrate->GetIPAddress() << endl;
		callParamCallbacks();
//		scopeLock.Unlock();
	}
}

int drvMPOD::loadRecords() {
	// First load global records
	{
		MtxLock classLock( dmClassMutex );
		// Loading the configuration records that use this driver
		string substitString = "PORT=" + string(portName) + string(",MBB=") + dmMbbPrefix ;
		string fullFileName = drvGlobalMPOD::getDirDB() + dmChassisFileNameDB;
		cout << "Will load from " << fullFileName << " with arguments " << substitString << endl;
		dbLoadRecords( fullFileName.c_str(), substitString.c_str() );
		cout << "Chassis Database loaded for chassis " << portName << endl;
	}

	{
		MtxLock classLock( dmClassMutex );
		// Now loading SNMP records for the MPOD chassis
		string substitString = "PORT=" + string(portName) + ",HOST=" + dmIP + ",COMMUNITY=guru,SCAN=2 second" ;
		string fullFileName = drvGlobalMPOD::getDirDB() + dmChassisSnmpFileNameDB;
		cout << "Will load from " << fullFileName << " with arguments " << substitString << endl;
		dbLoadRecords( fullFileName.c_str(), substitString.c_str() );
		cout << "Chassis SNMP Database loaded for chassis " << portName << endl;
	}

	// Now load records for each slot where there is a board
	vector<epicsInt32> nChanVec   = dmCrate->GetModuleChannels();
	vector<string>     brdNameVec = dmCrate->GetBoardNames();
	for( unsigned iSlot = 0; iSlot < brdNameVec.size(); iSlot++ ) {
		MtxLock classLock( dmClassMutex );
		string boardName 	= brdNameVec[iSlot];
		int nChan 			= nChanVec[iSlot];
		{
			// First load configuration records that this driver
			string fullFileName = drvGlobalMPOD::getDirDB() + dmBoardFileNameDB;
			stringstream ssSlot;
			ssSlot << iSlot;
			string substitString = "PORT=" + string(portName) + ",ADDR=" + ssSlot.str() ;
			cout << "Will load from " << fullFileName << " with arguments " << substitString << endl;
			dbLoadRecords( fullFileName.c_str(), substitString.c_str() );
			cout << "Board Database loaded for slot " << iSlot << " on chassis " << portName  << endl;
		}

		// Now load the database of records that use SNMP driver
		if( dmBoardFileNameMap.count( boardName ) > 0 ) {
			string boardFileName = dmBoardFileNameMap[boardName];
			string fullFileName = drvGlobalMPOD::getDirDB() + boardFileName ;
			for( epicsInt32 iChan = 0; iChan < nChanVec[iSlot]; iChan++ ) {
				stringstream ssChan;
				ssChan << (iSlot*100+iChan);
				string substitString = "PORT=" + string(portName) + ",HOST=" + dmIP + ",COMMUNITY=guru,SCAN=2 second,CH=" + ssChan.str() ;
				cout << "Will load from " << fullFileName << " with arguments " << substitString << endl;
				dbLoadRecords( fullFileName.c_str(), substitString.c_str() );
				cout << "Channel Database loaded for channel " << ssChan.str() << " for slot " << iSlot <<
						" on chassis " << portName  << endl;
			}
		} else {
			if( nChan > 0 ) {
				cout << "Error: could not find DB file for board type " << boardName << " that is slot "
						<< iSlot << " of the chassis " << portName << endl;
			}
		}
	}
	cout << "All DBs loaded for chassis " << portName << endl;
	return 0;
}


// This function simply calls the member function of the driver whose pointer
// is passed as the argument. This function is to be called from a separate
// thread and is specified in the argument when launching that thread
void readCrateParameters( void *drvPtr ) {
    drvMPOD* pPtr = (drvMPOD *)drvPtr;
    pPtr->readCrateParameters();
}

// Mutex manipulation functions

//! Initialize global mutex
int drvMPOD::initGlobalMutex() {
  pthread_mutexattr_init( &dmClassMtxAttr );
  pthread_mutexattr_setpshared( &dmClassMtxAttr, PTHREAD_PROCESS_PRIVATE );
  pthread_mutex_init( &dmClassMutex, &dmClassMtxAttr );
  return 0;
}

//! Initialize mutex for individual objects
void drvMPOD::initMutex() {
  pthread_mutexattr_init( &dmMtxAttr );
  pthread_mutexattr_setpshared( &dmMtxAttr, PTHREAD_PROCESS_PRIVATE );
  pthread_mutex_init( &dmMutex, &dmMtxAttr );

  return;
}

//! Destroy mutex for individual objects
void drvMPOD::closeMutex() {
  pthread_mutex_destroy( &dmMutex );
  pthread_mutexattr_destroy( &dmMtxAttr );
  return;
}


// Here we define IOC shell function calls

extern "C" {
  char* drvMPODConfig( const char *ipAddress,  const char *asynPortName, int maxNumOfSlots ) {
	  // Now create the asyn driver
	  drvMPOD* pMPOD = new drvMPOD( ipAddress, asynPortName, maxNumOfSlots );
	  return reinterpret_cast<char*>( pMPOD );
  }


  /* iocsh config function */
  static const iocshArg drvMPODConfigArg0 = { "Crate IP Address",   iocshArgString };
  static const iocshArg drvMPODConfigArg1 = { "Asyn port name"  ,   iocshArgString };
  static const iocshArg drvMPODConfigArg2 = { "Max N of Slots"  ,   iocshArgInt    };
  
  static const iocshArg * const drvMPODConfigArgs[] =
    { &drvMPODConfigArg0,
      &drvMPODConfigArg1,
      &drvMPODConfigArg2
   };
  
  static const iocshFuncDef drvMPODConfigFuncDef =
    { "drvMPODConfig", 3, drvMPODConfigArgs };
  
  static void drvMPODConfigCallFunc(const iocshArgBuf *args) {
    drvMPODConfig( args[0].sval, args[1].sval, args[2].ival );
  }
  
  
  void drvMPODRegister(void) {
    iocshRegister( &drvMPODConfigFuncDef, drvMPODConfigCallFunc );
  }
  
  epicsExportRegistrar( drvMPODRegister );
  
} // extern "C"

