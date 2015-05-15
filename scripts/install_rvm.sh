#!/usr/bin/env bash

sudo apt-get install -y curl

sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 # RVM installer key
curl -sSL https://get.rvm.io | bash -s stable --ruby