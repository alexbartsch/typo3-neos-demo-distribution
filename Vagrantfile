# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.hostname = "neos.dev"

	config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
	config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true

	config.vm.provider "virtualbox" do |vb|
		vb.name = "TYPO3 Neos Dev"
		vb.customize ["modifyvm", :id, "--memory", "2048"]
		vb.customize ["modifyvm", :id, "--cpus", 4]
	end

	config.vm.synced_folder ".", "/vagrant", disabled: true
	config.vm.synced_folder ".", "/var/www", create: true, group: "www-data", owner: "www-data"

	config.ssh.forward_agent = true

	config.omnibus.chef_version = :latest

	config.vm.provision "chef_solo" do |chef|
		chef.roles_path = "roles"
		chef.cookbooks_path = ["site-cookbooks", "cookbooks"]

		chef.add_role "typo3-neos-dev"
	end
end
