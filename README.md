# Vagrant Hadoop Cluster

This is a little personal project that attempts to create a working virtual Hadoop cluster with Hadoop + Hive + Spark, using Vagrant. This project is to be extended with the deployment of Zookeeper + Kafka as well.

---
## Requirements

- VirtualBox 6.0
- Vagrant 2.2.10
- Minimum of 16GB RAM (as-is, the full cluster allocates 10GB of RAM in total - 4GB for the namenode, 2GB for each datanode)

---
## Basic management

To provision the cluster:

> vagrant up

The first time this command is executed, it's going to take awhile, because vagrant will provision the machines. The second time it won't take so long. Also, to "vagrant up" a single node:

> vagrant up < host name >

To ssh into any of the machines:

> vagrant ssh < host name >

ssh is installed and configured within each machine so once inside a machine, you can ssh into any other machine with the host name or ip address:

> **namenode$** ssh < host name >\
> **namenode$** ssh < host ip address >

To halt the nodes (and save changes):

> vagrant halt

Again, you can halt a single node:

> vagrant < host name >

To completely wipe the nodes and state:

> vagrant destroy

To wipe a single node:

> vagrant destroy < host name >

To check the statuses of the vagrant environment:

> vagrant global-status

**Start the Hadoop daemons before starting the work:**

> vagrant ssh namenode\
> **namenode$** start-all.sh

Verify if daemons are working correctly with the jps command in each node. The processes that should be running are listed in the [**Initial cluster setup**](#initial-cluster-setup).

Additionally, very if all datanodes are listed in Hadoop's WebUI: [**192.168.2.10:9870**](192.168.2.10:9870)

---
## Initial cluster setup

The initial cluster is configured with four nodes:
1. **namenode** (4GB RAM): this node is more powerful than the others and is configured to run the following processes: 
   - *Namenode* 
   - *SecondaryNamenode* 
   - *ResourceManager* 
2. **datanode1** (1GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*
3. **datanode2** (1GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*
4. **datanode3** (1GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*

Scaling horizontally by adding datanodes is a matter of editing the following files:
 - [Vagrantfile](./Vagrantfile)
 - [ssh-setup.sh](./scripts/ssh-setup.sh)
 - [workers](./configs/hadoop/workers) (Hadoop)
 - [workers](./configs/spark/workers) (Spark)

Scaling vertically by adding resources to each node is a matter of editing the following files:
 - [Vagrantfile](./Vagrantfile)

---
## Known exceptions/bugs:

1. If running a Spark workload throws **java.io.FileNotFoundException: File does not exist: hdfs://namenode:9000/spark-logs**:
   > **namenode$** hadoop fs -mkdir -p /spark-logs

2. The local host machine doesn't recognize the cluster hostnames, and that's why access to WebHDFS has to be done through the IP of the namenode, as mentioned earlier. Another consequence of this is that it won't be possible to preview or download HDFS files through WebHDFS in the host machine. If this is critical, the simple work-around is to add the IPs and hostnames of the VMs to the hosts file of your **host machine**:

   > In Windows: **C:\Windows\System32\drivers\etc\hosts**\
   > In Linux: **/etc/hosts**
   > > 192.168.2.10 namenode\
   > > 192.168.2.11 datanode1\
   > > 192.168.2.12 datanode2\
   > > 192.168.2.13 datanode3

3. Creating symbolic links (symlinks) in vagrant's shared folder won't work due to some Windows' incompatibility with Linux symlinks. There might be a work around for this, but my suggestion is to not make the shared folder the main work environment and have the code somewhere else, such as in /home/vagrant/Desktop, where there should be no problems with symlinks.

4. If running a Hadoop/Hive/Spark workload throws **org.apache.hadoop.hdfs.server.namenode.SafeModeException: ... Name node is in safe mode.**, this is due to HDFS entering SafeMode due to low resource availability. There are two fixes: either (1) wait for a few seconds a let the system recover from previous resource usage, or (2) increase the system resources of each node in the [Vagrantfile](./Vagrantfile). Consider the resources available in the local host machine and edit with care. Similarly, YARN can terminate workers that run out of memory, which produces the following warning: **Container killed on request. Exit code is 137**. The same fixes apply.

---
## TODO

1. Add deployment of Zookeeper + Kafka

## Future work

1. Make it possible to add Datanodes more easily.

2. Right now, Vagrant runs shell scripts on all nodes upon provisioning. These shell scripts are responsible for the instalation and configuration of the tools. It would be interesting to do a branch that uses **Ansible** playbooks instead.

3. Do a similar deployment for CentOS
