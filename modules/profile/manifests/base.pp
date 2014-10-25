# Every Linux box should have this
class profile::base {

	include ntp

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
	
	# Use Exim for MTA
	include exim

}
