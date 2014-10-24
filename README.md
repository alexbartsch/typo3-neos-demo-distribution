Vagrant and TYPO3 Neos
============================

A Vagrant setup with TYPO3 Neos and the Neos demo website for development.

## Requirements on your host machine ##
- vagrant
- composer

## Steps for using this ##

### Install Vagrant plugins ###
- `vagrant plugin install vagrant-omnibus`

- add line `10.0.0.3	neos.dev` to `/etc/hosts`

### Create VM ###
- `vagrant up`

### Get TYPO3 Neos ###
- `cd htdocs`
- `composer create-project --no-dev typo3/neos-base-distribution TYPO3-Neos-1.1`

### Setup TYPO3 Neos ###
- add `TYPO3:Flow:core:subRequestPhpIniPathAndFilename: '/etc/php5/fpm/php.ini'` to your global Settings.yaml
- go to `http://neos.dev/setup` and use your capitalized project name as your database and "root" for user and password

## Start development ##
My best practice is to use PhpStorm with "Deployment" set up an "Automatic Upload" enabled.

### Deployment settings ###
__Connection__

- Type: SFTP
- Host: 10.0.0.3
- Port: 22
- Root path: /var/www
- User name: vagrant
- Auth type: Key pair
- Private key file: ~/.vagrant.d/insecure_private_key

__Mappings__

- Local path: PROJECT_PATH/htdocs
