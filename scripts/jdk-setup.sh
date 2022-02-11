#!/bin/bash 

######################################
# INSTALL JDK
######################################

# If jdk is not installed, install OpenJDK 8
java -version &> /dev/null || {
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
}

# Set environmental variables
grep JAVA .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# JAVA Variables END
EOF