class nginx {
	# Make sure Apache is stopped
	service { "httpd":
		ensure => "stopped",
		enable => "false"
	}

	service { ['nginx', 'php-fpm']:
		ensure => "running",
		enable => "true"
	}

	package { ['nginx', 'php-fpm', 'php-common', 'php-cli', 'php-xml', 'php-gd', 'php-mbstring', 'php-mcrypt']:
		ensure => 'latest'
	}

	file { 'nginx.conf':
		notify => Service['nginx'],
		path => '/etc/nginx/nginx.conf',
		ensure => file,
		source => 'puppet:///modules/nginx/nginx.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	file { 'restrictions.conf':
		notify => Service['nginx'],
		path => '/etc/nginx/restrictions.conf',
		ensure => file,
		source => 'puppet:///modules/nginx/restrictions.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

}
