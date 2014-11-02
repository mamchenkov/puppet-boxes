# Gateway server
class profile::server-gw {
	sysctl { 'net.ipv4.ip_forward': value => '1' }
}
