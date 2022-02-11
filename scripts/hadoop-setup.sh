#!/bin/bash 

# Disable iptables
sudo ufw disable

# If pdsh is not installed...
pdsh -V &> /dev/null || {
# Install pdsf
sudo apt-get -y update
sudo apt-get -y install pdsh
}

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If hadoop tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^hadoop &> /dev/null || 
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz -P ../../vagrant/tar/

# If hadoop is not installed...
hadoop version &> /dev/null || {

# Install Hadoop
ls /usr/local/hadoop &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/hadoop-3.3.1.tar.gz -C /usr/local/
sudo mv -T /usr/local/hadoop-3.3.1/ /usr/local/hadoop
}
sudo chmod 777 /usr/local/hadoop/

# Set environmental variables
grep HADOOP .bashrc &> /dev/null || cat >> .bashrc << EOF

# PDSH Variables START
export PDSH_RCMD_TYPE=ssh
# PDSH Variables END

# HADOOP Variables START
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export YARN_EXAMPLES=/usr/local/hadoop/share/hadoop/mapreduce
export PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin
# HADOOP Variables END
EOF

# Configure Hadoop
sudo cp ../../vagrant/configs/hadoop/* /usr/local/hadoop/etc/hadoop/

}

