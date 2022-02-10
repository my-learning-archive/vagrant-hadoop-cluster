# Vagrant Hadoop Cluster

## What is this project? 

This is a little personal project that attempts to create a working virtual Hadoop cluster with Hadoop + Hive + Spark + 
Zookeeper + Kafka, using Vagrant.

## Requirements

- VirtualBox 6.0
- Vagrant 2.2.10

## Basic management

To provision the cluster:

> vagrant up

The first time this command is executed, it's going to take awhile, because vagrant will provision the machines. The second time it won't take so long. Also, to "vagrant up" a single node:

> vagrant up < host name >

To ssh into any of the machines:

> vagrant ssh < host name >

ssh is installed and configured within each machine so once inside a machine, you can ssh into any other machine with the host name or ip address:

> namenode$ ssh < host name >\
> namenode$ ssh < host ip address >

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

## Initial cluster setup

The initial cluster is configured with four nodes:
1. namenode: this node is more powerful than the others and is configured to run the following processes: 
   - *Namenode* 
   - *SecondaryNamenode* 
   - *ResourceManager* 
2. datanode1: this node runs the following processes:
   - *Datanode*
3. datanode2: this node runs the following processes:
   - *Datanode*
4. datanode3: this node runs the following processes:
   - *Datanode*

Adding nodes is a matter of editing the VagrantFile and worker files of Hadoop.

## Future work

1. Make it possible to add Datanodes easily.

2. Right now, Vagrant runs shell scripts on all nodes upon provisioning. These shell scripts are responsible for the instalation and configuration of the tools. It would be interesting to do this with **Ansible** playbooks instead.
