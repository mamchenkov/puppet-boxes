# Every Linux box should have this
class profile::base {

	include ntp
	include exim

	$enhancers = [ 
		'git', 'tig',
		'ack',
		'htop',
		'screen',
		'mc',
		'vim-enhanced',
	]

	package { $enhancers:
		ensure => 'present'
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

	# Bash prompt with colors
	class { '::cosmetic::bash':
		# Green user with blue directory
		ps1 => '[\[\033[01;32m\]\u\[\033[00m\]@\H\[\033[01;34m\] \w\[\033[00m\]]\$ ',
		# Red user with blue directory
		ps1_root => '[\[\033[01;31m\]\u\[\033[00m\]@\H\[\033[01;34m\] \w\[\033[00m\]]\$ ',
	}

	# Tweak sysctl
	# Thanks to: https://rtcamp.com/tutorials/linux/sysctl-conf/

	# Memory management
	 
	# Increase size of file handles and inode cache
	sysctl { 'fs.file-max': value => 2097152 }

	# Do less swapping
	sysctl { 'vm.swappiness': value => 10 }
	sysctl { 'vm.dirty_ratio': value => 60 }
	sysctl { 'vm.dirty_background_ratio': value => 2 }

	# Network security
	 
	# Number of times SYNACKs for passive TCP connections
	sysctl { 'net.ipv4.tcp_synack_retries': value => 2 }
	# Protect against TCP Time-Wait
	sysctl { 'net.ipv4.tcp_rfc1337': value => 1 }
	# Decrease the time default value for tcp_fin_timeout connection
	sysctl { 'net.ipv4.tcp_fin_timeout': value => 15 }

	# Decrease the time default value for connections to keep alive
	sysctl { 'net.ipv4.tcp_keepalive_time': value => 300 }
	sysctl { 'net.ipv4.tcp_keepalive_probes': value => 5 }
	sysctl { 'net.ipv4.tcp_keepalive_intvl': value => 15 }

	# Network performance

	# Defautl socket receive buffer
	sysctl { 'net.core.rmem_default': value => 31457280 }
	# Maximum socket receive buffer
	sysctl { 'net.core.rmem_max': value => 12582912 }
	# Defautl socket send buffer
	sysctl { 'net.core.wmem_default': value => 31457280 }
	# Maximum socket send buffer
	sysctl { 'net.core.wmem_max': value => 12582912 }

	# Increase number of incoming connections
	sysctl { 'net.core.somaxconn': value => 65536 }
	# Increase number of incoming connections backlog
	sysctl { 'net.core.netdev_max_backlog': value => 65536 }

}
