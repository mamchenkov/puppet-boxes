# Every server should have this
class profile::server {

	include hashbackup

	$enhancers = [ 
		'logwatch'
	]

	package { $enhancers:
		ensure => 'present'
	}

}
