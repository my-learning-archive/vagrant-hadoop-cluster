# -*- mode: ruby -*-
# vi: set ft=ruby :

#####################################################
# Cluster
#####################################################

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.base_mac = nil
  config.vm.provision "shell", privileged: false, path: "scripts/ssh-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/jdk-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/hadoop-setup.sh"
  config.vm.provider :virtualbox do |v, override|
    override.vm.box_url = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20220207.0.0/providers/virtualbox.box"
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.define :datanode1 do |datanode1_config|
    datanode1_config.vm.network :private_network, ip: "192.168.2.11"
    datanode1_config.vm.hostname = "datanode1"
  end

  config.vm.define :datanode2 do |datanode2_config|
    datanode2_config.vm.network :private_network, ip: "192.168.2.12"
    datanode2_config.vm.hostname = "datanode2"
  end

  config.vm.define :datanode3 do |datanode3_config|
    datanode3_config.vm.network :private_network, ip: "192.168.2.13"
    datanode3_config.vm.hostname = "datanode3"
  end

  config.vm.define :namenode do |namenode_config|
    namenode_config.vm.network :private_network, ip: "192.168.2.10"
    namenode_config.vm.hostname = "namenode"
    namenode_config.vm.provider :virtualbox do |namenode_config_v, override|
      namenode_config_v.customize ["modifyvm", :id, "--memory", "4096"]
    end
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/hive-setup.sh"
  end

end
