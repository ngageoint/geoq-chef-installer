# GeoQ Chef Installer


Overview
========

This is a set of Chef recipes (think of them as macros to automatically build a running Virtual Machine) that will work to set the
geoq app up on either a local Virtualbox VM or onto an Amazon Web Service VM. This tool requires a working knowledge of chef and server management, but will streamline the installation and management of geoq.

The GeoQ Chef Installer software was developed at the National Geospatial-Intelligence Agency (NGA) in collaboration with [The MITRE Corporation] (http://www.mitre.org).  The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT] (http://choosealicense.com/licenses/mit/) license.  

###Pull Requests
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.  

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

###This project uses:
Chef under [Apache v2] (https://github.com/opscode/chef/blob/master/LICENSE)

Vagrant under [MIT](https://github.com/mitchellh/vagrant/blob/master/LICENSE)

Postgres under [PostgreSQL license] (http://www.postgresql.org/about/licence/)


Configuration
=============

1. Download VirtualBox and install it (free at https://www.virtualbox.org/)
2. Download Vagrant and install it (free at http://www.vagrantup.com/downloads)
3. Download Git and install it (free at http://git-scm.com/downloads or it might be preinstalled if on a mac)
4. Download Berkshelf and install it (works best through a gem install:
5. If you want to deploy to Amazon or some other provider, create a file named 'vagrant_dev_settings.yml' in the code directory (i.e. ~/Sites) and add in provider deployment details.
6. After everything is installed, you can type 'vagrant provision' to have it update code from github and install new libraries, or 'vagrant halt' to stop the VM.

Installation Steps
==================

    sudo gem install berkshelf
    sudo vagrant plugin install vagrant-berkshelf
    cd ~/Sites (or wherever you keep your code)
    git clone https://github.com/ngageoint/geoq-chef-installer.git
    cd geoq-chef-installer

    vagrant up (to deploy to a local virtualbox vm)

    (Or, if deploying to amazon)
    vagrant plugin install vagrant-aws
    vagrant plugin install unf
    vagrant up --provider=aws (if using AWS, and the vagrant_dev_settings.yml were created)
