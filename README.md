puppet-boxes
============

Masterless puppet configuration for my desktop/laptop Fedora boxes.  This
is heavily based on the Roles and Profiles approach described by Craig
Dunn in [this blog post](http://www.craigdunn.org/2012/05/239/).

This is highly experimental and unstable, since I'm still learning Puppet.
It works for me on Fedora 20.  If doesn't for you - send me a pull request.
Or at least a bug report.  I'm interested in figuring out 'why'.

Installation
------------

```
$ sudo yum install git puppet
$ git clone git@github.com:mamchenkov/puppet-boxes.git
$ # or git clone https://github.com/mamchenkov/puppet-boxes.git
$ cd puppet-boxes
$ sudo puppet apply manifests/desktop.pp --modulepath=modules/
```

Updates
-------

```
$ cd puppet-boxes
$ git pull origin master
$ sudo puppet apply manifests/desktop.pp --modulepath=modules/
```

TODO
----
- [x] Proof of concept
- [x] Marginally useful 
- [ ] Separate text-based and GUI-based setups
  - [x] Separate roles and profiles
  - [ ] Create a separate manifest for text-only boxes
- [ ] Add user manifests to manifests/people/username.pp

