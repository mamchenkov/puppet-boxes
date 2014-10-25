class exim {

	$exim_alternatives = ['sendmail', 'qmail', 'postfix']
	service { $exim_alternatives:
		ensure => "stopped",
		enable => false
	}

	package { $exim_alternatives:
		ensure => 'absent'
	}

	service { 'exim':
		ensure => "running",
		enable => "true"
	}

	package { 'exim':
		ensure => 'latest'
	}

}
