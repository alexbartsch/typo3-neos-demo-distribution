name "typo3-neos-dev"

override_attributes(
	"nginx" => {
		"default_site_enabled" => false
	},

	"php" => {
		"directives" => {
			"date.timezone" => "Europe/Berlin"
		}
	},

	"php-fpm" => {
    	"pools" => {
    		"default" => {
    			:enable => false
    		},
    		"www" => {
    			:enable => "true",
    			:listen => "/var/run/php5-fpm.sock",
    			:php_options => {
    				"php_admin_value[date.timezone]" => "Europe/Berlin"
    			}
    		}
    	}
    },

    "mysql" => {
        "server_root_password" => 'root',
        "server_repl_password" => 'root',
        "server_debian_password" => 'root'
    }
)

run_list(
	"recipe[apt]",
	"recipe[base]",

	"recipe[nginx]",
	"recipe[nginx::server]",

	"recipe[php-fpm]",
	"recipe[composer]",

	"recipe[mysql::server]",
	"recipe[database::mysql]",

	"recipe[typo3neos]"
)