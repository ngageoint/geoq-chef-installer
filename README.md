# GeoQ Chef Installer


Overview
========

This is a set of Chef recipes (think of them as macros to automatically build a running Virtual Machine) that will work to set the
geoq app up on either a local Virtualbox VM or onto an Amazon Web Service VM. This tool requires a working knowledge of chef and server management, but will streamline the installation and management of geoq.

The GeoQ and geoq-chef-installer software was developed at the National Geospatial-Intelligence Agency (NGA) as a joint effort between NGA and The MITRE Corporation. The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions.  You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.  NGA assumes no responsibility for the use of the software by any parties, and makes no guarantees, expressed or implied, about the software quality, reliability, or any other characteristic.  The GeoQ software can be redistributed and/or modified freely provided that any derivative work bears the following notice: "Elements of this work contain GeoQ: The National Geospatial-Intelligence Agency and The MITRE Corporation jointly produced this work."

###Pull request

If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. By submitting a pull request you agree to keep this work free of restrictions.  You are free to fork this project and add unique elements with your own stipulations in another repository or platform, but this version shall remain free of restrictions.

###This project uses:
Chef under [Apache v2] (https://github.com/opscode/chef/blob/master/LICENSE)

Vagrant under [MIT](https://github.com/mitchellh/vagrant/blob/master/LICENSE

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
    cd geoq-chef-repo

    vagrant up (to deploy to a local virtualbox vm)

    (Or, if deploying to amazon)
    vagrant plugin install vagrant-aws
    vagrant plugin install unf
    vagrant up --provider=aws (if using AWS, and the vagrant_dev_settings.yml were created)
