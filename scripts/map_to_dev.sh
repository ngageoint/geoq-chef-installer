#!/usr/bin/env bash

cd /usr/src
sudo mv geoq geoq.github
sudo ln -s /vagrant/geoq-repo geoq
sudo source /vagrant/scripts/restart_web_server.sh