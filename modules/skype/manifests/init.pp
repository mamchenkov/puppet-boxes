class skype {
	# Skype YUM repository (legacy)
	file { 'skype.repo':
		path => '/etc/yum.repos.d/skype.repo',
		ensure => 'absent'
	}

	# Install Skype directly from the skype.com website
	package { 'skype':
		ensure => 'installed',
		provider => 'rpm',
		source => 'http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm'
	}

}
