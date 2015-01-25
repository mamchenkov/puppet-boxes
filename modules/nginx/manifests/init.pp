class nginx {

	# These are the same packages, sorted alphabetically
	$install_packages = $operatingsystem ? {
		Amazon => [
			'nginx', 
			'php55-cli', 
			'php55-fpm', 
			'php55-gd', 
			'php55-mbstring', 
			'php55-mcrypt',
			'php55-mysqlnd', 
			'php55-pdo', 
			'php55-soap', 
			'php55-xml', 
		],
		Fedora => [
			'nginx', 
			'php-cli', 
			'php-fpm', 
			'php-gd', 
			'php-mbstring', 
			'php-mcrypt',
			'php-mysqlnd', 
			'php-pdo', 
			'php-soap', 
			'php-xml', 
		],
		default => [
			'nginx', 
			'php-cli', 
			'php-fpm', 
			'php-gd', 
			'php-mbstring', 
			'php-mcrypt',
			'php-mysqlnd', 
			'php-pdo', 
			'php-soap', 
			'php-xml', 
		],
	}

	$fpm_service = $operatingsystem ? {
		Fedora => 'php-fpm',
		CentOS => 'php-fpm',
		Amazon => 'php-fpm-5.5',
	}

	$fpm_file_path = $operatingsystem ? {
		Fedora => '/etc/php-fpm.d/www.conf',
		CentOS => '/etc/php-fpm.d/www.conf',
		Amazon => '/etc/php-fpm-5.5.d/www.conf',
	}

	# Make sure Apache is stopped
	service { "httpd":
		ensure => "stopped",
		enable => "false"
	}

	service { $fpm_service:
		ensure => "running",
		enable => "true"
	}

	service { 'nginx':
		ensure => "running",
		enable => "true"
	}

	package { ['httpd-tools', 'httpd']:
		ensure => 'purged'
	}

	package { $install_packages:
		ensure => 'latest'
	}

	file { 'sessions':
		path => '/var/lib/php/session',
		ensure => directory,
		owner => 'nginx',
		group => 'nginx',
		mode => 770
	}

	file { 'nginx.conf':
		notify => Service['nginx'],
		path => '/etc/nginx/nginx.conf',
		ensure => file,
		source => 'puppet:///modules/nginx/nginx/nginx.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	file { 'restrictions.conf':
		notify => Service['nginx'],
		path => '/etc/nginx/restrictions.conf',
		ensure => file,
		source => 'puppet:///modules/nginx/nginx/restrictions.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	file { 'www.conf':
		notify => Service[$fpm_service],
		path => $fpm_file_path,
		ensure => file,
		source => 'puppet:///modules/nginx/php-fpm/www.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	file { 'composer':
		path => '/usr/bin/composer',
		ensure => file,
		source => 'puppet:///modules/nginx/composer',
		owner => 'root',
		group => 'root',
		mode => 755
	}

}
