# There must be a better way of doing this. But I am yet to find it.
node default {
	include role::base

	mailalias { 'root':
		ensure => 'present',
		recipient => 'leonid@mamchenkov.net',
		target => '/etc/aliases',
	}
}
