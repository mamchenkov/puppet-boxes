class skype {
	# Skype YUM repository
	file { 'skype.repo':
		path => '/etc/yum.repos.d/skype.repo',
		ensure => file,
		source => 'puppet:///modules/skype/skype.repo',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	# Install latest version of Skype once we have the repo configured
	package { 'skype':
		ensure => 'latest',
		require => File['skype.repo']
	}

}
