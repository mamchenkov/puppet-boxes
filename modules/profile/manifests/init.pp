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

	class { 'selinux':
		mode => 'disabled'
	}

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
