#!/bin/sh

# force java version

if [ "$HOSTNAME" == "clonpc19.jlab.org" ]; then
echo "Running on clonpc19"
  export JAVA_HOME=/usr/lib/jvm/java-1.8.0-oracle.x86_64
  #export JAVA_HOME=/usr/lib/jvm/java-1.7.0-oracle.x86_64
  export PATH=$JAVA_HOME/bin:$PATH
else
  export JAVA_HOME=/usr/lib/jvm/java-1.8.0-oracle
  export PATH=$JAVA_HOME/bin:$PATH
fi

echo "Java jome = $JAVA_HOME"

java org/jlab/AutoLogEntry/MakeLogEntry $1 $2 
