class ntp {

	# Dtermine util-linux package based on the operatingsystem fact
	$util_linux = $operatingsystem ? {
		Fedora => 'util-linux',
		CentOS => 'util-linux-ng',
	}

	# For synchronizing time over the network
	package { 'ntpdate':
		ensure => 'latest'
	}

	# For hwclock time writing
	package { "$util_linux":
		ensure => 'latest'
	}

	# cron.hourly sync
	file { 'ntpdate':
		path => '/etc/cron.hourly/ntpdate',
		ensure => file,
		source => 'puppet:///modules/ntp/ntpdate',
		owner => 'root',
		group => 'root',
		mode => 755
	}
}
