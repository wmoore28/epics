CC              = g++
ROOT_CFLAGS     = $(shell root-config --cflags)
ROOT_LIBS       = $(shell root-config --libs)

all: harp_fitter.exe

harp_fitter.exe:	harp_fitter.cc
	$(CC) harp_fitter.cc -o $@ $(ROOT_CFLAGS) $(ROOT_LIBS) -lSpectrum

clean:			
	rm -f harp_fitter.exe
