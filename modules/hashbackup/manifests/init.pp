# Hashbackup - http://www.hashbackup.com/
class hashbackup {

	# Architecture specific binary
	$binary = $architecture ? {
		'i386' => 'puppet:///modules/hashbackup/hb32',
		default => 'puppet:///modules/hashbackup/hb64',
	}

	file { 'hb':
		path => '/usr/bin/hb',
		ensure => file,
		source => $binary,
		owner => 'root',
		group => 'root',
		mode => 755
	}
}
