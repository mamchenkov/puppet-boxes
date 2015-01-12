# Amazone EC2 base role
class role::base::ec2 inherits role{
	include profile::base::ec2
}
