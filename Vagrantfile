# -*- mode: ruby -*-
# vi: set ft=ruby :

PROJECT_NAME = "neos.demo.typo3.org.vm"

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"

	# Forward ports
	config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
	config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true

	# adjust VirtualBox specific settings
	config.vm.provider "virtualbox" do |vb|
		vb.name = "TYPO3 Neos Demo Distribution"
		vb.customize ["modifyvm", :id, "--memory", "2048"]
		vb.customize ["modifyvm", :id, "--cpus", 4]
	end

	config.vm.synced_folder ".", "/vagrant", disabled: true
	#config.vm.synced_folder "src", "/var/www", create: true, group: "www-data", owner: "www-data"

	config.ssh.forward_agent = true

	# share site folder into releases folder
	config.vm.synced_folder ".", "/var/www/" + config.vm.hostname + "/releases/vagrant",
		type: "rsync",
		group: "www-data",
		rsync__args: ["--verbose", "--archive", "--delete", "-z", "--perms", "--chmod=Dg+s,Dg+rwx"],
		rsync__exclude: [
			".git/",
			".idea/",
			".DS_Store",
			"Configuration/PackageStates.php",
			"Configuration/Production/" + PROJECT_NAME.gsub(".", "").capitalize + "vm",
			"Configuration/Development/" + PROJECT_NAME.gsub(".", "").capitalize + "vm",
			"Configuration/Testing/Behat",
			"Data/Sessions/**",
			"Data/Temporary/**",
			"Data/Persistent/**",
			"Data/Surf/**",
			"Data/Logs/**",
			"Web/_Resources/Persistent",
			"Web/_Resources/Static"
		]

	config.vm.provision "shell", path: "provision/setup.sh"
end
