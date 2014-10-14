#!/bin/bash

echo "Provisioning virtual machine..."

echo "Updating repositories"
apt-add-repository ppa:chris-lea/node.js -y
add-apt-repository ppa:ondrej/php5 -y
apt-get update

echo "Installing Git"
apt-get install git -y

echo "Installing Nginx"
apt-get install nginx -y

echo "Installing PHP"
apt-get install python-software-properties build-essential -y
apt-get install php5-common php5-dev php5-cli php5-fpm -y

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y

apt-get install debconf-utils -y

echo "Installing MySQL"
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

apt-get install mysql-server -y

echo "Configuring MySQL"
cp -r /var/www/Provision/config/mysql /etc/mysql/conf.d/vagrant.cnf

sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

service mysql restart

echo "Create database"
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS 'neos-dev' CHARACTER SET utf8 COLLATE utf8_general_ci;"

echo "Configuring Nginx"
cp -r /var/www/Provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost

ln -sf /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

rm -rf /etc/nginx/sites-available/default

service nginx restart

echo "Installing Node.js"
apt-get install nodejs -y

echo "Installing Node.js modules"
npm install -g crawler --unsafe-perm true

echo "Configuring User"
cp -r /etc/skel/.bashrc ~/
sed -i "s/^#force_color_prompt=yes/force_color_prompt=yes/" ~/.bashrc

v1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
v2="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]"
var_a=$(printf "%q" $v1)
var_b=$(printf "%q" $v2)
sed "s/${var_a}/${var_b}/g" ~/.bashrc

. ~/.bashrc