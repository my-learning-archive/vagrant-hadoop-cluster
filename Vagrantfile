# -*- mode: ruby -*-
# vi: set ft=ruby :

#global script
$global = <<SCRIPT

#####################################################
# SSH
#####################################################

#check for private key for vm-vm comm
[ -f /vagrant/id_rsa ] || {
  ssh-keygen -t rsa -f /vagrant/id_rsa -q -N ''
}

#deploy key
[ -f /home/vagrant/.ssh/id_rsa ] || {
    cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
    chmod 0600 /home/vagrant/.ssh/id_rsa
}

#allow ssh passwordless
grep 'vagrant@node' ~/.ssh/authorized_keys &>/dev/null || {
  cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
}

#exclude node* from host checking
cat > ~/.ssh/config <<EOF
Host datanode1
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
Host datanode2
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
Host datanode3
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
Host namenode
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF

#populate /etc/hosts
sudo chmod 0777 /etc/hosts
grep "192.168.2.11" /etc/hosts &> /dev/null || sudo echo "192.168.2.11 datanode1" >> /etc/hosts
grep "192.168.2.12" /etc/hosts &> /dev/null || sudo echo "192.168.2.12 datanode2" >> /etc/hosts
grep "192.168.2.13" /etc/hosts &> /dev/null || sudo echo "192.168.2.13 datanode3" >> /etc/hosts
grep "192.168.2.14" /etc/hosts &> /dev/null || sudo echo "192.168.2.10 namenode" >> /etc/hosts

#end script
SCRIPT

#####################################################
# Cluster
#####################################################

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provision "shell", privileged: false, inline: $global
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
  end

end
