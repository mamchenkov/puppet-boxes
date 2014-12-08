class nagios {

	$nagios = ['nagios','nagios-plugins-all','nagios-plugins-nrpe']

	service { 'nagios':
		ensure => "running",
		enable => "true"
	}

	package { $nagios:
		ensure => 'latest'
	}

}
