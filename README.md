TYPO3 Neos and Vagrant
============================

A Vagrant setup with TYPO3 Neos and the Neos demo website for development.

Steps for using the Vagrant setup:

## Install TYPO3 Neos ##
- `cd htdocs`
- `composer create-project --no-dev typo3/neos-base-distribution TYPO3-Neos-1.1`
- `cd ..`

## Setup Vagrant ##
- install Vagrant
- `vagrant plugin install vagrant-omnibus`

- add line `10.0.0.3	neos.dev` to `/etc/hosts`

## Create VM ##
- `vagrant up`

- go to `http://neos.dev/setup` (Database "neos" - User: "root", Pass "root")