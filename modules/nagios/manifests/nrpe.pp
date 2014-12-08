class nagios::nrpe {

	$nrpe = ['nrpe','nagios-plugins-all']

	service { 'nrpe':
		ensure => "running",
		enable => "true"
	}

	package { $nrpe:
		ensure => 'latest'
	}

	file { 'nrpe.cfg':
		notify => Service['nrpe'],
		path => '/etc/nagios/nrpe.cfg',
		ensure => file,
		source => 'puppet:///modules/nagios/nrpe.cfg',
		owner => 'root',
		group => 'root',
		mode => 644
	}


}
