# Vagrant Development Environment

This is my base development environment for some of my projects.

__Requirements on your host machine__

- vagrant
- composer

## Virtual Machine

1. `vagrant plugin install vagrant-omnibus`
2. add line `10.0.0.3	example.com.dev` to your `/etc/hosts`
3. `vagrant up`

Now you have a clean dev environment. Please notice that the VM needs a `htdocs` folder to bind the nginx document root on.

You can create it with `mkdir dirname` or add your git project as submodule. Last one is recommended.

One more thing needed is an config file `vagrant_config.json` inside of the htdocs folder. 
This is where chef get's it's informations from.

__vagrant_config.json__

```javascript
{
	"type": 		"typo3-neos", 
    // Defines what type of Open-Source System you want to install.

	"name": 		"example.com",
   // Domain-Name of your project.
    
	"nameClean":	"exampleCom"
    // Clean Domain-Name of your project, used as e.g. database name.
}
```

## Install Open-Source Software #

This setup belongs to your defined `type` from your `vagrant_config.json`.

### TYPO3 Neos ###
1. In your `vagrant_config.json` set `type` to `typo3-neos`
2. add 
```
  TYPO3:
    Flow:
      core:
        subRequestPhpIniPathAndFilename: '/etc/php5/fpm/php.ini'
``` 
to your global Settings.yaml
- `vagrant ssh` into your VM and set `date.timezone` in your `/ec/php5/fpm/php.ini`
- go to `http://example.com.dev/setup` and use your `nameClean` as your database name and "root" for user and password

## Development #
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
