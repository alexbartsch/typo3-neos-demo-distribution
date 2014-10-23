#
# Cookbook Name:: typo3neos
# Recipe:: default
#

#
# Setup vHost
#

template "#{node.nginx.dir}/sites-available/neos.dev" do
  source "typo3-neos.erb"
  mode "0644"
  variables(
    :listen 	=> 80,
    :host 		=> "neos.dev",
    :root 		=> "/var/www/TYPO3-Neos-1.1/Web",
    :index 		=> "index.php index.html",
    :location	=> "rewrite \".*\" /index.php last",
	:phpfpm		=> true
  )
end

#
# Setup database
#

mysql_database 'neos' do
  connection(
    :host     => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  )
  action :create
end

#
# Add vagrant user to www-data group
#

group "www-data" do
  action :modify
  members "vagrant"
  append true
end

#
# Setup TYPO3 Neos
#

directory "/var/www" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
end

#
# Restart Nginx
#

nginx_site "neos.dev" do
  action :enable
end