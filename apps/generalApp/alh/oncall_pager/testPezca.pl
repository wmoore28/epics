#!/bin/env perl

#use lib ('/usr/local/clas/devel/R3.14.8.2/base/lib/solaris-x86/');

use Pezca;

($error, $sigVal) = Pezca::GetDouble("PI1022");

print "PI1022: $sigVal";

