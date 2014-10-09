# Web/DB development desktop role
class role::desktop-dev inherits role::base{
	include profile::server-web
	include profile::server-db
	include profile::desktop
}
