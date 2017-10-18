# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
   config.vm.box = "amonteilhet/debian-stretch64"
   config.vm.box_check_update = false
   config.vm.network "private_network", ip: "192.168.33.20"
   config.vm.synced_folder "./sites", "/vagrant/sites"
   config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = "2048"
   end
  config.ssh.forward_agent = true
  config.vm.provision :shell, path: "provision.sh"
end
