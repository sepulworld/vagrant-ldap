# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.hostname = "server.puppetlabs.test"

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 389, host: 3890

  config.vm.network :private_network, ip: "192.168.33.20"
  config.vm.synced_folder "./ldap/", "/vagrant_data/deploy/"
  config.vm.provider :virtualbox do |vb|  
	vb.customize ["modifyvm", :id, "--memory", "1024"]
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.provision :puppet do |puppet|
  	puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
  end
end
