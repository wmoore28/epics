#!/bin/bash
#
# testbuild.sh
# 
# Test build system for HPS EPICS.  On success, things will be fully compiled, 
# but no tools installed.
# 
# Returns:
# 0=success
# 1=failure
# 
# Author: Wesley Moore (wmoore@jlab.org)
# Date:   Nov 2014
# 

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
col=$(tput cols)

# $1 - 0=passed, 1=failed
# $2 - test name
passFail ()
{
  	len=${#2}
  	spc=$(expr $col - $len - 3)
  	if [ $1 = 0 ]; then
		printf '%s%*s%s' "$2" $spc "$GREEN" "[passed]" "$NORMAL"
 	else
		printf '%s%*s%s' "$2" $spc "$RED" "[failed]" "$NORMAL"
  	fi
  	printf '\n'
  	return 0
}

printBreak ()
{
  	eval printf -- '-%.s' {1..$col} ; echo
}

printErr ()
{
	printBreak
	echo "Use .setup-hps to setup the environmental variables (source .setup-hps)."
}

declare -a vars=("CLAS" "EPICS_BASE" "EPICSB_DRIVERS")
err=0
printf "Testing environment variables:\n"
for var in "${vars[@]}"; do
  	if [ -n "${!var}" ]; then
  		passFail 0 "  $var=`printenv $var`"
  	else
  		passFail 1 "  $var not set"
  		err=1
  	fi
done

if [ $err = "1" ]; then
	printErr
  	exit 1
fi

declare -a tests=("make distclean" "make install" "make rebuild" "make clean-tools" "make tools")

printf "\nTesting build for:\n"
for test in "${tests[@]}"; do
  	printf '%s\n' "  $test"
done

for test in "${tests[@]}"; do
  	printBreak
  	sleep 5
  	$test
	result=$? 
  	printBreak
  	if [ $result -eq 0 ]; then
		passFail 0 "$test"
  	else 
		passFail 1 "$test"
    	exit 1
  	fi
done

printBreak
printf "Run 'make install-tools' as needed\n"
printBreak

exit 0
