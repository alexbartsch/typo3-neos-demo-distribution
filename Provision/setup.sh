#!/bin/bash

echo "Provisioning virtual machine..."

echo "Updating repositories"
apt-add-repository ppa:chris-lea/node.js -y > /dev/null
add-apt-repository ppa:ondrej/php5 -y > /dev/null
apt-get update  > /dev/null

echo "Installing Git"
apt-get install git -y > /dev/null

echo "Installing Nginx"
apt-get install nginx -y > /dev/null

echo "Installing PHP"
apt-get install python-software-properties build-essential -y > /dev/null
apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null

apt-get install debconf-utils -y > /dev/null

echo "Installing MySQL"
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

apt-get install mysql-server -y > /dev/null

echo "Configuring MySQL"
cp -r /srv/www/Provision/config/mysql /etc/mysql/conf.d/vagrant.cnf > /dev/null

sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf > /dev/null
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;" > /dev/null

service mysql restart > /dev/null

echo "Create database"
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS `neos-dev` CHARACTER SET utf8 COLLATE utf8_general_ci;" > /dev/null

echo "Configuring Nginx"
cp -r /srv/www/Provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null

ln -sf /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/ > /dev/null

rm -rf /etc/nginx/sites-available/default > /dev/null

service nginx restart > /dev/null

echo "Installing Node.js"
apt-get install nodejs -y > /dev/null

echo "Installing Node.js modules"
npm install -g crawler --unsafe-perm true > /dev/null

echo "Configuring User"
cp -r /etc/skel/.bashrc ~/ > /dev/null
sed -i "s/^#force_color_prompt=yes/force_color_prompt=yes/" ~/.bashrc > /dev/null

v1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
v2="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]"
var_a=$(printf "%q" $v1)
var_b=$(printf "%q" $v2)
sed "s/${var_a}/${var_b}/g" ~/.bashrc > /dev/null

. ~/.bashrc > /dev/null