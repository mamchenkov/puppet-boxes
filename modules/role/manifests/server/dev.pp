# Web/DB development server role
class role::server::dev inherits role::base{
	include profile::server::web
	include profile::server::db
}
