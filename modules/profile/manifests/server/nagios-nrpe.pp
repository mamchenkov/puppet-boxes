# Nagios NRPE agent
class profile::server::nagios-nrpe {
	include profile::server
	include nagios::nrpe
}
