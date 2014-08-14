class google-chrome {
	# Google Chrome YUM repository
	file { 'google-chrome.repo':
		path => '/etc/yum.repos.d/google-chrome.repo',
		ensure => file,
		source => 'puppet:///modules/google-chrome/google-chrome.repo',
		owner => 'root',
		group => 'root',
		mode => 644
	}

	# Install latest stable Google Chrome version
	package { 'google-chrome-stable':
		ensure => 'latest',
		require => File['google-chrome.repo']
	}
}
