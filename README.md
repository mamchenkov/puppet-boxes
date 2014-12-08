puppet-boxes
============

Masterless puppet configuration for my desktop/laptop Fedora boxes.  This
is heavily based on the Roles and Profiles approach described by Craig
Dunn in [this blog post](http://www.craigdunn.org/2012/05/239/).

This is highly experimental and unstable, since I'm still learning Puppet.
It works for me on Fedora 20.  If doesn't for you - send me a pull request.
Or at least a bug report.  I'm interested in figuring out 'why'.

Features
--------

There are currently two manifests that can be applied: minimal and desktop.

### Base

* Time synchroniztion (using ntpdate and hwclock, via hourly cron job);
* Packages enhancing command line work: git, tig, screen, mc, vim-enhanced;
* Disable SELinux
* Add /swapfile twice the size of RAM

### Desktop

* Skype (via extra YUM repository)
* Web browser configuration
  * Google Chrome (via extra YUM repository)
  * Adobe Flash (via extra YUM repository)
  * Firefox browser
* Terminator - muliple GNOME terminals in one window

### Gateway Server

* Allow ipv4 forwarding in sysctl

### Nagios Server

* Nagios with all plugins, including NRPE

This is currently incomplete in terms of configuration

### Nagios Server NRPE

* NRPE agent with all Nagios plugins

### Web Server

* Nginx + php-fpm

### Database Server

* MySQL/MariaDB

### Development Server

* Whatever Web Server has
* Whatever DB Server has

### Development Desktop

* Whatever Desktop has
* Whatever Development server has

Usage
-----

### Install prerequisites

```
$ sudo yum install git puppet
```

### Clone the repository

```
$ git clone git@github.com:mamchenkov/puppet-boxes.git
```

or using HTTPS:

```
$ git clone https://github.com/mamchenkov/puppet-boxes.git
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

TODO
----
- [x] Proof of concept
- [x] Marginally useful 
- [x] Separate text-based and GUI-based setups
  - [x] Separate roles and profiles
  - [x] Create a separate manifest for text-only boxes
- [ ] Add user manifests to manifests/people/username.pp

