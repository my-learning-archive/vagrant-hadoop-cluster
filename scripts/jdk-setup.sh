#!/bin/bash 

java -version &> /dev/null || {

# Add the PPA for installing OpenJDK
sudo add-apt-repository -y ppa:openjdk-r/ppa;

# Update your local package index
sudo apt-get update;

# Install OpenJDK 8
sudo apt-get install -y openjdk-8-jdk;

# Set environmental variables
cat >> .bashrc << EOF
# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
PATH=$PATH:$JAVA_HOME/bin
# JAVA Variables END
EOF

}