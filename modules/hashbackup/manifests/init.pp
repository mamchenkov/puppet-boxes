# Hashbackup - http://www.hashbackup.com/
class hashbackup (
	$hashbackup = '/usr/bin/hb',
	$backup_dir='/var/backup/files',
	$check_hb_updates='yes',
	$verbose=0,
	$dedup_memory=100m,
	$max_file_size=1g,
	$retain_policy='-t all',
	$backup_targets='/etc /root /home /var/www /var/spool/mail /var/log'
	) {


	# Architecture specific binary
	$binary = $architecture ? {
		'i386' => 'puppet:///modules/hashbackup/hb32',
		default => 'puppet:///modules/hashbackup/hb64',
	}

	file { $hashbackup:
		ensure => file,
		source => $binary,
		owner => 'root',
		group => 'root',
		mode => 755
	}

	case $operatingsystem {
			/(?i:RedHat|CentOS|Amazon|Fedora)/: {
				file { "/etc/cron.daily/hashbackup.sh":
					require => File[$hashbackup],
					content => template('hashbackup/hashbackup.sh.erb'),
					ensure => "file",
					mode => 755,
					owner => "root",
					group => "root"
				}
			}
	}
}
