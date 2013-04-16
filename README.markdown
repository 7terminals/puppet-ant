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
* bashrc file of the user
	
### Beginning with Apache Ant

To setup Apache Ant on a server

    ant::setup { "ant":
      ensure        => 'present',
      source        => 'apache-ant-1.9.0-bin.tar.gz',
      deploymentdir => '/path/to/install/ant',
      user          => 'user',
      pathfile      => '/path/to/bashrc/to/be/updated'
    }

Usage
------

The `ant` definition has several parameters to assist installation of ant.

**Parameters within `ant`**

####`ensure`

This parameter specifies whether ant should be deployed to the deployment directory or not.
Valid arguments are "present" or "absent"

####`source`

This parameter specifies the source for the ant archive.

####`deploymentdir`

This parameter specifies where ant will be installed.

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


Release Notes
--------------

**0.1.0**

First initial release.
