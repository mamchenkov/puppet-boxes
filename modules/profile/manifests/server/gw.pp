# Gateway server
class profile::server::gw {

	include profile::server
	sysctl { 'net.ipv4.ip_forward': value => '1' }
}
