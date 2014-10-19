#
# Cookbook Name:: typo3neos
# Recipe:: default
#

#
# Setup vHost
#

nginx_site "neos.dev" do
  host "neos.dev"
  root "/var/www/htdocs"
  index "index.php index.html index.htm"
  location "try_files $uri $uri/ /index.php?$query_string"
  phpfpm true
  action [:create, :enable]
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
# Setup TYPO3 Neos
#



