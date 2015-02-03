/***************************************************************************/
/*                                                                         */
/*        --- CAEN Engineering Srl - Computing Systems Division ---        */
/*                                                                         */
/*    CAENHVOSLIB.H                                            		   */
/*                                                                         */
/*                                                                         */
/*    Source code written in ANSI C                                        */
/*                                                                         */ 
/*    March     2000:            - Created.                                */
/*    May       2002: Rel. 2.4 : - Added multiplatform support in the same */
/*				   files.                                  */
/*                                                                         */
/***************************************************************************/

#ifndef __CAENHVOSLIB_H
#define __CAENHVOSLIB_H

#ifdef UNIX                           // Rel. 2.0 - Linux
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#define CAENHVLIB_API 

extern void Sleep(unsigned long x);

#else // UNIX

#include <windows.h>

#ifdef CAENHVLIB
#define CAENHVLIB_API __declspec(dllexport) 
#else
#define CAENHVLIB_API 
#endif

#endif // UNIX

#endif // __CAENHVOSLIB_H
