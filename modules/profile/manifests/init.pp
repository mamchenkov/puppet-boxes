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

	# Replace Postfix with Exim
	service { "postfix":
		ensure => "stopped",
		enable => "false"
	}
	package { "postfix": 
		ensure => "purged"
	}
	class { 'exim': }

}

# Only Linux boxes used with GUI should have this
class profile::desktop {
	include skype
	include web-browser

	$enhancers = [
		'terminator'
	]

	package { $enhancers:
		ensure => 'latest'
	}
}

# Web server
class profile::webserver {
	#include apache
	#include php
	include nginx
}
