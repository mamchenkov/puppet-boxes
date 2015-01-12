# Amazone EC2 base role
class role::server::ec2 inherits role{
	include profile::server::ec2
}
