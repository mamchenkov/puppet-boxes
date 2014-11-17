# Every Linux box should have this
class profile::base {

	include ntp
	include hashbackup
	include exim

	$enhancers = [ 
		'git', 'tig',
		'screen',
		'mc',
		'vim-enhanced'
	]

	package { $enhancers:
		ensure => 'latest'
	}

	# Remove SELinux
	$selinux = ['selinux-policy', 'selinux-policy-targeted']
	package { $selinux:
		ensure => 'purged'
	}

	# Install swap file
	class { 'swap_file':
		swapfile => '/swapfile'
	}
	
}
