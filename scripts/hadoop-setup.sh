#!/bin/bash 

######################################
# INSTALL HADOOP
######################################

# Disable iptables
sudo ufw disable

# If pdsh is not installed, install pdsh
pdsh -V &> /dev/null || {
sudo apt-get -y update
sudo apt-get -y install pdsh
}

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If Hadoop tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^hadoop &> /dev/null || 
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz -P ../../vagrant/tar/

# If Hadoop is not installed, install Hadoop
hadoop version &> /dev/null || {
ls /usr/local/hadoop &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/hadoop-3.3.1.tar.gz -C /usr/local/
sudo mv -T /usr/local/hadoop-3.3.1/ /usr/local/hadoop
}
sudo chmod 777 /usr/local/hadoop/
}

# Set environmental variables
grep HADOOP .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# PDSH Variables START
export PDSH_RCMD_TYPE=ssh
# PDSH Variables END

# HADOOP Variables START
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export YARN_EXAMPLES=$HADOOP_HOME/share/hadoop/mapreduce
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
# HADOOP Variables END
EOF

######################################
# CONFIGURE HADOOP
######################################

# Set temporary environmental variables
export HADOOP_HOME=/usr/local/hadoop

# Deploy Hadoop configurations
sudo cp ../../vagrant/configs/hadoop/* $HADOOP_HOME/etc/hadoop/

# Format HDFS
[ $HOSTNAME == namenode ] && {
cat formatted_hdfs &> /dev/null || {
echo 'Y' | $HADOOP_HOME/bin/hdfs namenode -format &> /dev/null
touch formatted_hdfs
chmod 444 formatted_hdfs
}
} || echo "this is a datanode"