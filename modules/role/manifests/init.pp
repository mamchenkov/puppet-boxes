class role {
}

class role::base inherits role{
	include profile::base
}

class role::desktop inherits role::base{
	include profile::desktop
}

class role::webserver inherits role::base{
	include profile::webserver
}

class role::dbserver inherits role::base{
	include profile::dbserver
}
