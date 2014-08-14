class role {
	include profile::base
}

class role::desktop inherits role{
	include profile::desktop
}
