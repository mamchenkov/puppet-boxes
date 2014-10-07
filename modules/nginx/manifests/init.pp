class nginx {

	$install_packages = $operatingsystem ? {
		Amazon => ['nginx', 'php55-fpm', 'php55-cli', 'php55-xml', 'php55-gd', 'php55-mbstring', 'php55-mcrypt'],
		default => ['nginx', 'php-fpm', 'php-cli', 'php-xml', 'php-gd', 'php-mbstring', 'php-mcrypt'],
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

	file { 'www.conf':
		notify => Service[$fpm_service],
		path => $fpm_file_path,
		ensure => file,
		source => 'puppet:///modules/nginx/www.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

}
