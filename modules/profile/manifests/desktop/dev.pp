# Development desktop
class profile::desktop::dev {
	include profile::desktop
	include nginx
	include mysql
	include mysql::client
}
