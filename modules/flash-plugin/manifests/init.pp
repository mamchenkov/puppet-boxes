class flash-plugin {
	# Adobe YUM repository
	file { 'adobe-linux-i386.repo':
		path => '/etc/yum.repos.d/adobe-linux-i386.repo',
		ensure => file,
		source => 'puppet:///modules/flash-plugin/adobe-linux-i386.repo',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	# Install latest version of Adobe Flash once we have the repo configured
	package { 'flash-plugin':
		ensure => 'latest',
		require => File['adobe-linux-i386.repo']
	}
}
