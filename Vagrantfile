# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.hostname = "neos.dev"

	#config.vm.network "public_network"

	config.vm.network "private_network", ip: "10.0.0.3"

	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", "4096"]
		vb.customize ["modifyvm", :id, "--cpus", 4]
	end

	config.vm.synced_folder ".", "/vagrant", disabled: true

	# share site folder into releases folder
	config.vm.synced_folder "htdocs", "/var/www",
		type: "rsync",
		group: "www-data",
		rsync__args: ["--verbose", "--archive", "--delete", "-z", "--perms", "--chmod=Dg+s,Dg+rwx"],
		rsync__exclude: [
			".git/",
			".idea/",
			".DS_Store",
			"Configuration/PackageStates.php",
			#"Configuration/Production/" + PROJECT_NAME.gsub(".", "").capitalize + "vm",
			#"Configuration/Development/" + PROJECT_NAME.gsub(".", "").capitalize + "vm",
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

		chef.add_role "typo3-neos-dev"
	end
end
