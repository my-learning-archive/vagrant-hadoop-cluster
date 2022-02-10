#!/bin/bash 

# If pdsh is not installed...
pdsh -V &> /dev/null || {

 # Install pdsf
 sudo apt-get -y update
 sudo apt-get -y install pdsh

}

# If hadoop tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^hadoop &> /dev/null || 
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz -P ../../vagrant/tar/

# If hadoop is not installed...
hadoop version &> /dev/null || {

# Install Hadoop
sudo tar -xvf ../../vagrant/tar/hadoop-3.3.1.tar.gz -C /usr/local/
sudo mv /usr/local/hadoop-3.3.1/ /usr/local/hadoop

# Set environmental variables
cat >> .bashrc << EOF

# PDSH Variables START
export PDSH_RCMD_TYPE=ssh
# PDSH Variables END

# HADOOP Variables START
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
export YARN_EXAMPLES=/usr/local/hadoop/share/hadoop/mapreduce
export PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin
# HADOOP Variables END
EOF

}