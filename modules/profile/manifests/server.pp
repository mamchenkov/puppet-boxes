# Every server should have this
class profile::server {

	include hashbackup

	$enhancers = [ 
		'logwatch',
		'mutt',
	]

	package { $enhancers:
		ensure => 'present'
	}

}
