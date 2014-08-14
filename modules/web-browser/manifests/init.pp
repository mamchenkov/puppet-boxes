class web-browser {
	include google-chrome
	include flash-plugin

	package { 'firefox':
		ensure => 'latest'
	}
}
