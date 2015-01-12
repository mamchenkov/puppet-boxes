# Nagios server role
class role::server::nagios inherits role::base{
	include profile::server::nagios
}
