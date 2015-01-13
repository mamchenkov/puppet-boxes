puppet-boxes
============

[![Build Status](https://travis-ci.org/QoboLtd/puppet-boxes.svg?branch=master)](https://travis-ci.org/QoboLtd/puppet-boxes)

Masterless puppet configuration for my server and desktop boxes.  This
is heavily based on the Roles and Profiles approach described by Craig
Dunn in [this blog post](http://www.craigdunn.org/2012/05/239/).

This is highly experimental and unstable, since I'm still learning Puppet.
It works for me on a variety of Red Hat based distributions - CentOS 6.5+, 
Fedora 20+, and Amazon.  If doesn't work for you - send me a pull request.
Or at least a bug report.  I'm interested in figuring out 'why'. I'd also
appreciate any suggestions on how to improve this setup.

Features
--------

### Test Script

In the root folder of the project you'll find the ```test``` script.  It's a
useful quick way to check the syntax of all your puppet files after any
modifications.  Simply run it without any parameters:

```
$ ./test
```

It's print the name of each file that is checked, together with any warnings
found on the way.  The execution will stop if any syntax errors are found.

### Shortcut script to install/apply

In the root folder of the project you'll find the ```apply``` script.  It's a
simply shortcut that does the following:

* Checks if you are root or not.  If you are not, sudo is prepended to all commands.
* Makes sure puppet is installed.  This is handy for freshly installed boxes.
* Tries to guess which manifest you want to run

You can use the regular puppet command line like so:

```
$ puppet apply --modulepath=modules/ manifests/base.pp
```

Or you can use the ```apply``` shortcut with the full path to the manifest (to
avoid any guessing):

```
$ ./apply manifests/base.pp
```

Or you can use the shortcut version:

```
$ ./apply base
```

The variety of manifests is available.  Keep reading for descriptions, or just 
examine the ```manifests/``` folder.  Each manifest applies a role (roles can
be found in ```modules/roles/manifests/```).  Each role applies one or more
profiles (profiles can be found in ```modules/profiels/manifests/```).

You can as easily create your own manifests, roles, and profiles.

### Base Configuration

```./apply base```

This is the minimal base configuration that is applicable to all boxes.  It is
included with all other configurations automatically, so you don't need to apply
it separately.  It includes the following:

* Time synchroniztion (using ntpdate and hwclock, via hourly cron job);
* Packages enhancing command line work: git, tig, screen, mc, vim-enhanced;
* Disable SELinux
* Add /swapfile twice the size of RAM
* Better bash prompt with a bit of color
* Kernel optimization via sysctl tweaking

### Desktop Configuration

```./apply desktop```

This is a generic GUI desktop configuration.  It includes the base configuration
and adds a few enhancements like:

* Skype (via extra YUM repository)
* Web browser configuration
  * Google Chrome (via extra YUM repository)
  * Adobe Flash (via extra YUM repository)
  * Firefox browser
* Terminator - muliple GNOME terminals in one window

All other desktop* configurations include this one automatically.

### Development Desktop Configuration

```./apply desktop/dev```

This is a desktop configuration with tools for web development.  It includes
everything that a base desktop configuration has, with additions of web and
database servers.  The generic server configuration is excluded to avoid
local backups, logwatch and such.

* Whatever Desktop has
* Whatever Development server has
* Except for what generic server has

### Server Configuration

```./apply server```

This is the minimal server configuration.  It includes the base configuration and
adds a few enhancements like:

* HashBackup configuration for daily local backups to /var/backup/files
* logwatch for server log monitoring
* mutt for easier access to local server mailboxes

All other server* configurations include this one automaticallyj so there is no 
need to run this separately.

### Web Server Configuration

```./apply server/web```

* Base configuration
* Server configuration
* Nginx with PHP (php-fpm)
* MySQL client

### Database Server Configuration

```./apply server/db```

* Base configuration
* Server configuration
* MySQL/MariaDB server
* MySQL/MariaDB client

### Development Server Configuration

```./apply server/dev```

* Whatever Web Server has
* Whatever DB Server has

### Gateway Server Configuration

```./apply server/gw```

* Base configuration
* Server configuration
* Allow ipv4 forwarding in sysctl

### Nagios Server Configuration

* Base configuration
* Server configuration
* Nagios server with all plugins
* NRPE (Nagios Remote Plugin Executor)

This is currently incomplete in terms of configuration

### Nagios NRPE Client Configuration

* Base configuration
* Server configuration
* NRPE agent (Nagios Remote Plugin Executor)
* All Nagios plugins

Usage
-----

### Install prerequisites

```
$ sudo yum install git puppet
```

### Clone the repository

```
$ git clone git@github.com:QoboLtd/puppet-boxes.git
```

or using HTTPS:

```
$ git clone https://github.com/QoboLtd/puppet-boxes.git
```

### Apply puppet configuration

You can either apply the minimal configuration (good for headless servers):

```
$ cd puppet-boxes
$ sudo puppet apply --modulepath=modules/ manifests/base.pp
```

Or a full featured configuration for machines with GUI setup:

```
$ cd puppet-boxes
$ sudo puppet apply --modulepath=modules/ manifests/desktop.pp
```

There is no need to apply minimal before deskop, as desktop includes the minimal.


Updates
-------

```
$ cd puppet-boxes
$ git pull origin master
$ sudo puppet apply --modulepath=modules/ manifests/desktop.pp
```

