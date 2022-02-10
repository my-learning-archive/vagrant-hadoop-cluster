#!/bin/bash 

If jdk is not installed...
java -version &> /dev/null || {

# Install OpenJDK 8
sudo add-apt-repository -y ppa:openjdk-r/ppa;
sudo apt-get update;
sudo apt-get install -y openjdk-8-jdk;

# Set environmental variables
cat >> .bashrc << EOF

# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin
# JAVA Variables END
EOF

}