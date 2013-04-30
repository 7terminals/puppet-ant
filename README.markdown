ant
====


Overview
--------

The Apache Ant module installs the ant build tool.


Module Description
-------------------

The Apache Ant module allows Puppet to install ant and update the bashrc file to include ant in the path. 

Setup
-----

**What ant affects:**

* installation directory for Ant
* bashrc file of the user or /etc/bashrc if parameter pathfile is not set 
* ToDo - some more info about keeping apache Ant in its own folder so that on ensure => absent, someone' /usr/local does not disappear
	
### Beginning with Apache Ant

To setup Apache Ant on a server

    ant::setup { "example.com-ant":
      ensure        => 'present',
      source        => 'apache-ant-1.9.0-bin.tar.gz',
      deploymentdir => '/home/example.com/apps/apache-ant',
      user          => 'example.com',
      pathfile      => '/home/example.com/.bashrc'
    }

Usage
------

The `ant::setup` resource definition has several parameters to assist installation of ant.

**Parameters within `ant`**

####`ensure`

This parameter specifies whether ant should be deployed to the deployment directory and bashrc file is updated or not.
Valid arguments are "present" or "absent".

Default is present.


####`source`

This parameter specifies the source for the ant archive. 
This file must be in the files directory in the caller module. 
**Only .tar.gz source archives are supported.**

####`deploymentdir`

This parameter specifies the directory where ant will be installed.

Warning: If deploymentdir is set to /usr/local/, and you want to remove this installation in the future, setting ensure => 'absent' will cause the entire directory, i. e. /usr/local/ to be deleted permanently. It is strongly recommended to set deploymentdir to some dedicated directory e.g /opt/apache-ant or /home/example.com/apps/apache-ant

####`user`

This parameter is used to set the permissions for the installation directory of ant.

####`pathfile`

This parameter is used to find and update the bashrc file to include ant in the environment path.


Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* CentOS 5.9
* CentOS 6.4
* Debian 6.0 
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Bug Reports
-----------

Release Notes
--------------

**0.0.2**
Updated documentation in class
**0.0.1**
First initial release.
