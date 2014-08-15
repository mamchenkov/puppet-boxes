class role {
	include profile::base
}

class role::base inherits role{
}

class role::desktop inherits role{
	include profile::desktop
}
