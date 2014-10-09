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
