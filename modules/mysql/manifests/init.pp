class mysql {

	$install_packages = $operatingsystem ? {
		Amazon => ['mysql55', 'mysql55-server'],
		Fedora => ['mariadb', 'mariadb-server'],
		default => ['mysql', 'mysql-server'],
	}

	$mysql_service = $operatingsystem ? {
		Fedora => 'mariadb',
		default => 'mysqld',
	}


	service { $mysql_service:
		ensure => "running",
		enable => "true"
	}

	package { $install_packages:
		ensure => 'latest'
	}

}
