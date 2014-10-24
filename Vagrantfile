# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# Load config from htdocs
#

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
config         = YAML.load_file("#{current_dir}/htdocs/vagrant_config.yaml")
vagrant_config = config['config']

PROJECT_NAME   = vagrant_config['project']['name']
PROJECT_NAME_C = PROJECT_NAME.gsub(".", "").gsub("-", "").capitalize
PROJECT_TYPE   = vagrant_config['project']['type']

#
# Vagrant setup
#

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.hostname = PROJECT_NAME + ".dev"

	config.vm.network "private_network", ip: "10.0.0.3"

	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", "4096"]
		vb.customize ["modifyvm", :id, "--cpus", 4]
	end

	config.vm.synced_folder ".", "/vagrant", disabled: true

	config.vm.synced_folder "htdocs", "/var/www",
		type: "rsync",
		group: "www-data",
		rsync__args: ["--verbose", "--archive", "--delete", "-z", "--perms", "--chmod=Dg+s,Dg+rwx"],
		rsync__exclude: [
			".git/",
			".idea/",
			".DS_Store",
			"Configuration/PackageStates.php",
			"Configuration/Production/" + PROJECT_NAME_C,
			"Configuration/Development/" + PROJECT_NAME_C,
			"Configuration/Testing/Behat",
			"Data/Sessions/**",
			"Data/Temporary/**",
			"Data/Persistent/**",
			"Data/Surf/**",
			"Data/Logs/**",
			"Web/_Resources/Persistent",
			"Web/_Resources/Static"
		]

	config.ssh.forward_agent = true

	config.omnibus.chef_version = :latest

	config.vm.provision "chef_solo" do |chef|
		chef.roles_path = "roles"
		chef.cookbooks_path = ["site-cookbooks", "cookbooks"]

		chef.add_role "webserver"
	end
end
