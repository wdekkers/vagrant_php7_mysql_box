# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Load a base Centos 6.5 box
  config.vm.box = "nrel/CentOS-6.5-x86_64"

  # Set up port 80 to access
  config.vm.network "forwarded_port", guest: 80, host: 1234

  # Set here your prefferd IP
  config.vm.network "private_network", ip: "192.168.88.10"

  # Load the bootstrap file
  config.vm.provision :shell, :path => "etc/scripts/bootstrap.sh"
  
end