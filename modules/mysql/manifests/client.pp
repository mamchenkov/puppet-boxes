# MySQL client
class mysql::client {

	$install_packages = $operatingsystem ? {
		Amazon => ['mysql55'],
		Fedora => ['mariadb'],
		default => ['mysql'],
	}

	package { $install_packages:
		ensure => 'latest'
	}

}
