/*
 * jlabDiscBoard.hh
 *
 *  Created on: June 16, 2014
 *      Author:
 *
 *      This class provides interface that EPICS support will use to monitor
 *      and control the JLAB discriminator boards.
 *      All methods, including accesssors, need to be thread-safe since they
 *      may be executing simultaneousely on multiple threads.
 */

#ifndef _JLABDISCBOARD_HH_
#define _JLABDISCBOARD_HH_

#include <stdint.h>

#include <iostream>
#include <string>
#include <vector>
#include <map> 

#include "jlabBoard.hh" 

using namespace std;

class jlabDiscBoard : public jlabBoard {

protected:
	// Prevent copying boards
	jlabDiscBoard(const jlabDiscBoard& board);
	jlabDiscBoard& operator=(const jlabDiscBoard& board);

	static const unsigned jdbChanNumber = 16;
		
public:

	// Constructor. Create the discriminator board object specified by the base address.
	// Create all channel objects on that board and fill the channel vector. 
	// Throws an exception if fails to create the object.
	jlabDiscBoard( uint32_t  address, string ip = "127.0.0.1" );

	// Destructor. Destroys this board. 
	virtual ~jlabDiscBoard();
	
	// Return boards type JlabDisc_v2 or whatever
	virtual string 				GetType();

	// Return the 32-bit status word for this board
	virtual uint32_t			GetStatus();

	// Return the number of channels this board is serving
	virtual uint32_t			GetNumberOfChannels();

	// Return the base address of the board
	virtual uint32_t			GetBaseAddress();
	
	// Start reading the scaler data for this board from VME bus
	virtual void 				StartScalers( const string scalerType = "" ); 
	// Stop reading the scaler data for this board from VME bus 
	virtual void				StopScalers( const string scalerType = "" );
	
	// Return scaler values for particular channel for this board, in Hz or raw
	virtual vector<double>		GetScalerCounts( const unsigned chanNumber, const string scalerType, bool inHz = true );
	// Return clock counts for this board for a particular type (GATED, UNGATED, etc)
	virtual vector<double>		GetClockCounts( const string type );
	
	// Set thresholds for particlular type of thresholds for all channels
	virtual void				SetThresholds( const double threshold, const string threshType = "" );
	// Set thresholds for particular type of threshold for a single channel
	virtual void 				SetThreshold( const unsigned chanNumber, const double threshold, const string threshType );
	
	// Get a vector of thresholds for  a particular type of thresholds
	virtual vector<double>		GetThresholds( const string threshType );
	// Get the values of threshold for a single channel of a partcular threshold type
	virtual double				GetThreshold( const unsigned chanNumb, const string threshType );
};

#endif /* _JLABDISCBOARD_HH_ */
