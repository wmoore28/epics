/*
 * jlabFADC250Board.hh
 *
 *  Created on: June 16, 2014
 *      Author:
 *
 *      This class provides interface that EPICS support will use to monitor
 *      and control the JLAB discriminator boards.
 *      All methods, including accesssors, need to be thread-safe since they
 *      may be executing simultaneousely on multiple threads.
 */

#ifndef _jlabFADC250Board_HH_
#define _jlabFADC250Board_HH_

#include <stdint.h>

#include <iostream>
#include <string>
#include <vector>
#include <map> 

#include "jlabBoard.hh" 

using namespace std;

class jlabFADC250Board : public jlabBoard {

protected:
	// Prevent copying boards
	jlabFADC250Board(const jlabFADC250Board& board);
	jlabFADC250Board& operator=(const jlabFADC250Board& board);

	static const unsigned jfbChanNumber = 16;
		
public:

	// Constructor. Create FADC250 board object specified by base address
	// Create all channel objects on that board and fill the channel vector. 
	// Throws an exception if fails to create the object.
	jlabFADC250Board( uint32_t  address, string ip = "127.0.0.1" );

	// Destructor. Destroys this board. 
	virtual ~jlabFADC250Board();
	
	// Return boards type FADC250_v2 or whatever
	virtual string 				GetType();

	// Return the 32-bit status word for this board
	virtual uint32_t			GetStatus();

	// Return the number of channels this board is serving
	virtual uint32_t			GetNumberOfChannels();

	// Return the base address of the board
	virtual uint32_t			GetBaseAddress();
		
	// Return scaler values for particular channel for this board, in Hz or raw
	virtual vector<double>		GetScalerCounts( const unsigned chanNumber, const string scalerType, bool inHz = true );
	// Return clock counts for this board for a particular type (GATED, UNGATED, etc)
	virtual vector<double>		GetClockCounts( const string type );
		
	// Get a vector of thresholds for  a particular type of thresholds
	virtual vector<double>		GetThresholds( const string threshType );
	// Get the values of threshold for a single channel of a partcular threshold type
  virtual double				GetThreshold( const unsigned chanNumb, const string threshType );
	
	// Return the histogram for energy spectrum for a particular channel
	vector<double>				GetSpectrum( const unsigned chanNumb );
};

#endif /* _jlabFADC250Board_HH_ */
