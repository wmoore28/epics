
/* File:    drvGlobalMPOD.h
 * Author:  Hovanes Egiyan, Jefferson Lab
 * Date:    05-Mar-2013
 *
 * Purpose: 
 * This module provides the driver support for the asyn device support layer
 * for the MPOD crates.
 *
 *
 */


#include "drvGlobalMPOD.hh"

//! Declare global mutex and its attributes
pthread_mutex_t     drvGlobalMPOD::dgmClassMutex;
pthread_mutexattr_t drvGlobalMPOD::dgmClassMtxAttr;

//! Initialize global mutex and its attributes
static int dummyInt = drvGlobalMPOD::initGlobalMutex();

static const char *driverName="asynGlobalMPOD";

string drvGlobalMPOD::dgmPortName = "GlobalPortForMPOD";			// Asyn port name for the global port
string drvGlobalMPOD::dmgDirDB = "db/";								// Directory prefix
string drvGlobalMPOD::dmgFileNameDB = "readConfigGlobalMPOD.db";	// Template DB file name
drvGlobalMPOD* drvGlobalMPOD::dgmInstancePtr = 0;					// The only instance of this object type

/*Constructor */
drvGlobalMPOD::drvGlobalMPOD() :
  asynPortDriver( dgmPortName.c_str(), 1, NUM_GLOBAL_MPOD_PARAMS,
		  asynInt32Mask | asynDrvUserMask | asynCommonMask | asynOptionMask,
		  asynInt32Mask | asynDrvUserMask | asynCommonMask | asynOptionMask,
		  ASYN_CANBLOCK, 1, 0, 0 )
//		  0, 1, 0, 0 )
{
	static const char* functionName = "drvGlobalMPOD::drvGlobalMPOD";
	cout << "In function " << functionName << endl;

	initMutex();

	{
		MtxLock scopeLock( dgmMutex );
		this->dgmEventID = epicsEventCreate( epicsEventEmpty );
		createParam( MPODChassisNumberString	,    asynParamInt32			, &MPODChassisNumber_	);  /*  string, RO  */
	}

	// Uncomment this line to enable asynTraceFlow during the constructor
	//	pasynTrace->setTraceMask( pasynUserSelf, 0x11 );
	pasynTrace->setTraceMask( pasynUserSelf, 0x255 );

	int status = 0;
	/* Create the thread that reads the values from the registers in the background */
	status = (asynStatus)(
	        epicsThreadCreate("MPOD_GLOBAL", epicsThreadPriorityMedium,
	                epicsThreadGetStackSize(epicsThreadStackMedium),
	                (EPICSTHREADFUNC) ::readGlobalParameters, this) == NULL);
	if ( status ) {
		printf( "%s:%s: epicsThreadCreate failure\n", driverName, functionName );
		return;
	}

	cout << "Finished " << functionName << endl;

	return;
}

// Destructor
drvGlobalMPOD::~drvGlobalMPOD() {
	MtxLock classLock( dgmClassMutex );
	closeMutex();
	return;
}

// Return the only instance of the class
drvGlobalMPOD* 	drvGlobalMPOD::getInstance() {
	if( dgmInstancePtr == 0 ) {
		MtxLock classLock( dgmClassMutex );
		dgmInstancePtr = new drvGlobalMPOD();
	}
	return dgmInstancePtr;
}

/* Report  parameters */
void drvGlobalMPOD::report( FILE *fp, int details ) {
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
void drvGlobalMPOD::readGlobalParameters( void ) {
	asynStatus aStat ;
	// Set updating time to value in seconds
	double updateTime = 2.0;
	//  while( taskDelay(sysClkRateGet())  ) {
	while( 1 ) {
		epicsEventId eventID;
		{
			MtxLock scopeLock( dgmMutex );
			eventID = this->dgmEventID;
		}
		epicsEventWaitWithTimeout( eventID, updateTime );
		//   usleep( 100000 );
		//     if (run) epicsEventWaitWithTimeout(this->eventId, updateTime);
		//     else     epicsEventWait(this->eventId);
		//     /* run could have changed while we were waiting */
		//     getIntegerParam(P_Run, &run);
		//     if (!run) continue;
		MtxLock scopeLock( dgmMutex );
		aStat = setIntegerParam( MPODChassisNumber_, drvMPOD::getPortMap().size() );
		callParamCallbacks();
	}
}

// Method to first load the global DB records, then call methods to
// load DB records for each chassis
int  drvGlobalMPOD::loadRecords() {
	{
		MtxLock classLock( dgmClassMutex );
		// First load global records
		string substitString = "PORT=" + drvGlobalMPOD::dgmPortName;
		string fullFileName = dmgDirDB + dmgFileNameDB;
		cout << "Will load from " << fullFileName << endl;
		dbLoadRecords(fullFileName.c_str(), substitString.c_str());
	}
	cout << "Global Database loaded" << endl;

	// Now load records for each chassis
	map<string,drvMPOD*> chassisPortMap = drvMPOD::getPortMap();
	cout << "Got iterators" << endl;
	for( map<string,drvMPOD*>::iterator it = chassisPortMap.begin(); it != chassisPortMap.end(); it++ ) {
		drvMPOD* chassisPtr = it->second;
		chassisPtr->loadRecords();
	}
	cout << "Finished loading DBs for all chassis" << endl;
	return 0;
}

// Mutex manipulation functions

//! Initialize global mutex
int drvGlobalMPOD::initGlobalMutex() {
  pthread_mutexattr_init( &dgmClassMtxAttr );
  pthread_mutexattr_setpshared( &dgmClassMtxAttr, PTHREAD_PROCESS_PRIVATE );
  pthread_mutex_init( &dgmClassMutex, &dgmClassMtxAttr );
  return 0;
}

//! Initialize mutex for individual objects
void drvGlobalMPOD::initMutex() {
  pthread_mutexattr_init( &dgmMtxAttr );
  pthread_mutexattr_setpshared( &dgmMtxAttr, PTHREAD_PROCESS_PRIVATE );
  pthread_mutex_init( &dgmMutex, &dgmMtxAttr );

  return;
}

//! Destroy mutex for individual objects
void drvGlobalMPOD::closeMutex() {
  pthread_mutex_destroy( &dgmMutex );
  pthread_mutexattr_destroy( &dgmMtxAttr );
  return;
}




// This function simply calls the member function of the driver whose pointer
// is passed as the argument. This function is to be called from a separate
// thread and is specified in the argument when launching that thread
void readGlobalParameters( void *drvPtr ) {
    drvGlobalMPOD* pPtr = (drvGlobalMPOD *)drvPtr;
    pPtr->readGlobalParameters();
}




// Here we define IOC shell function calls

extern "C" {
  int dbLoadRecordsMPOD( const char* dummy ) {
	  drvGlobalMPOD* instancePtr = drvGlobalMPOD::getInstance();
	  return instancePtr->loadRecords();
  }


  /* iocsh config function */
  static const iocshArg dbLoadRecordsMPODArg0 = { "Crate IP Address",   iocshArgString };

  static const iocshArg * const dbLoadRecordsMPODArgs[] =
    { &dbLoadRecordsMPODArg0 };

  static const iocshFuncDef dbLoadRecordsMPODFuncDef =
    { "dbLoadRecordsMPOD", 1,  dbLoadRecordsMPODArgs};

  static void dbLoadRecordsMPODCallFunc(const iocshArgBuf *args) {
	  dbLoadRecordsMPOD( args[0].sval );
  }


  void drvGlobalMPODRegister(void) {
    iocshRegister( &dbLoadRecordsMPODFuncDef,  dbLoadRecordsMPODCallFunc );
  }

  epicsExportRegistrar( drvGlobalMPODRegister );

} // extern "C"

