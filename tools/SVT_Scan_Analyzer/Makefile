CC              = g++
CC_OBJ_FLAGS    = -c -fPIC
CC_Shared_FLAGS = -shared -Wl,-soname,libSVTwirePosition.so
ROOT_CFLAGS     = $(shell root-config --cflags)
ROOT_LIBS       = $(shell root-config --libs)
Link            = ld -r


all: analyze_svt_scan.exe

analyze_svt_scan.exe:	libSVTwirePosition.so analyze_svt_scan.cc
			$(CC) analyze_svt_scan.cc -o $@ $(ROOT_CFLAGS) $(ROOT_LIBS) -lSpectrum -I. -L. -lSVTwirePosition


libSVTwirePosition.so:	SVTwirePosition.o 
			$(CC) $(CC_Shared_FLAGS) -o libSVTwirePosition.so.1.0.1 $^ ; ln -sf  libSVTwirePosition.so.1.0.1 $@ ; ln -sf libSVTwirePosition.so.1.0.1 libSVTwirePosition.so.1


SVTwirePosition.o:	SVTwirePosition.h SVTwirePosition.cc
			$(CC) $(CC_OBJ_FLAGS) SVTwirePosition.cc -o $@

clean:			
			rm -f *.so *.so.* *.o analyze_svt_scan.exe
