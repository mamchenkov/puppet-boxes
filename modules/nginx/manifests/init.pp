class nginx {

	$remove_packages = $operatingsystem ? {
		Fedora => ['httpd-tools', 'httpd'],
		CentOS => ['httpd-tools', 'httpd'],
		Amazon => ['httpd-tools', 'httpd', 'php-fpm', 'php-cli', 'php-xml', 'php-gd', 'php-mbstring', 'php-mcrypt'],
	}

	$install_packages = $operatingsystem ? {
		Fedora => ['nginx', 'php-fpm', 'php-cli', 'php-xml', 'php-gd', 'php-mbstring', 'php-mcrypt'],
		CentOS => ['nginx', 'php-fpm', 'php-cli', 'php-xml', 'php-gd', 'php-mbstring', 'php-mcrypt'],
		Amazon => ['nginx', 'php55-fpm', 'php55-cli', 'php55-xml', 'php55-gd', 'php55-mbstring', 'php55-mcrypt'],
	}

	# Make sure Apache is stopped
	service { "httpd":
		ensure => "stopped",
		enable => "false"
	}

	service { ['nginx', 'php-fpm']:
		ensure => "running",
		enable => "true"
	}

	package { $remove_packages:
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
		notify => Service['php-fpm'],
		path => '/etc/php-fpm.d/www.conf',
		ensure => file,
		source => 'puppet:///modules/nginx/www.conf',
		owner => 'root',
		group => 'root',
		mode => 644
	}

}
