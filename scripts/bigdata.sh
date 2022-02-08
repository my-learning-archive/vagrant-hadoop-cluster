#!/bin/bash 

# put this in /etc/profile.d so it runs on login

# Environment Variables for Big Data tools
export BigDataSH=/etc/profile.d/bigdata.sh
#export IdentityFile=~/.ssh/hadoopkeypair.pem
#export SSHConfigFile=~/.ssh/config

# Cluster Variables START
export NameNodeDNS="namenode"
export DataNode001DNS="datanode1"
export DataNode002DNS="datanode2"
export DataNode003DNS="datanode3"
export NameNodeIP="192.168.2.10"
export DataNode001IP="192.168.2.11"
export DataNode002IP="192.168.2.12"
export DataNode003IP="192.168.2.13"
# Cluster Variables END

# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
PATH=$PATH:$JAVA_HOME/bin
# JAVA Variables END

# PDSH Variables START
export PDSH_RCMD_TYPE=ssh
# PDSH Variables END

# HADOOP Variables START
export HADOOP_HOME="/usr/local/hadoop"
export HADOOP_CONF_DIR="${HADOOP_HOME}/etc/hadoop"
export YARN_EXAMPLES="${HADOOP_HOME}/share/hadoop/mapreduce"
PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
# HADOOP Variables END

# Hive Variables START
export HIVE_HOME="/usr/local/hive"
PATH=$PATH:$HIVE_HOME/bin:$HIVE_HOME/sbin
# Hive Variables END

# Spark Variables START
export SPARK_HOME="/usr/local/spark"
PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python3
# Spark Variables END

# Kafka Variables START
export KAFKA_HOME="/usr/local/kafka"
# Kafka Variables END
