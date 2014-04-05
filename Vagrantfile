# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# If deploying to AWS, create 'vagrant_dev_settings.yml' (in project dir, or one right above it)
# with these settings:
#KEYPAIR_NAME: 'my_keyfile_name-aws-ssh'
#KEYPAIR_PATH: '~/.ssh/my_key_file-aws-ssh.pem'
#
#AWS-GEOQ:
#  DEPLOY_TO_AWS: False
#  ACCESS_KEY_ID: 'XXX'
#  SECRET_ACCESS_KEY: 'XXX'
#  AMI: 'ami-xxx'
#  SECURITY_GROUPS: ["mywebserver"]
#
require 'yaml'
if File.exists? ("../vagrant_dev_settings.yml")
    vagrant_config = YAML::load_file("../vagrant_dev_settings.yml")
elsif File.exists? ("vagrant_dev_settings.yml")
    vagrant_config = YAML::load_file("vagrant_dev_settings.yml")
end

host_cache_path = File.expand_path("../.cache", __FILE__)
guest_cache_path = "/tmp/vagrant-cache"

# ensure the cache path exists
FileUtils.mkdir(host_cache_path) unless File.exist?(host_cache_path)

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.berkshelf.enabled = true  

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  if vagrant_config and vagrant_config['AWS-GEOQ']['DEPLOY_TO_AWS']==true
    config.vm.box = "ubuntu_aws"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    config.vm.provider :aws do |aws, override|
      aws.instance_type = "t1.micro"
      aws.access_key_id = vagrant_config['AWS-GEOQ']['ACCESS_KEY_ID']
      aws.secret_access_key = vagrant_config['AWS-GEOQ']['SECRET_ACCESS_KEY']
      aws.keypair_name = vagrant_config['KEYPAIR_NAME']
      aws.security_groups = vagrant_config['AWS-GEOQ']['SECURITY_GROUPS']
      aws.ami = vagrant_config['AWS-GEOQ']['AMI']
      aws.tags = {
        'Name' => 'Geoq',
        'Maturity' => 'Deployed'
      }
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = vagrant_config['KEYPAIR_PATH']
    end
  else
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.network :public_network
  end

  if vagrant_config and vagrant_config['AWS-GEOQ']['SKIP_SCRIPTS']

      if vagrant_config and vagrant_config['AWS-GEOQ']['USE_LOCAL_REPO']==true
          config.vm.synced_folder "../geoq-django", "/vagrant/geoq-repo"
      end

  else
      config.vm.provision :shell, :path => "scripts/install_rvm.sh"
      config.vm.provision :shell, :path => "scripts/install_ruby.sh"
      config.vm.provision :shell, :path => "scripts/install_PIL.sh"
      config.vm.provision :shell, :path => "scripts/install_lessc.sh"
      config.vm.provision :shell, :inline => "gem install chef --version 11.6.0 --no-rdoc --no-ri --conservative"

      config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.add_recipe "apt"
        chef.add_recipe "python"
        chef.add_recipe "git"
        chef.add_recipe "nginx"
        chef.add_recipe "geoq"

        if vagrant_config and vagrant_config['AWS-GEOQ']['USE_LOCAL_REPO']==true
          config.vm.synced_folder "../geoq-django", "/vagrant/geoq-repo"

        chef.json = {
          :geoq => {
            :git_repo => {
              :location => "file:///vagrant/geoq-repo/"
            }
          }
        }

        end
      end

      config.vm.provision :shell, :path => "scripts/restart_web_server.sh"

  end

end
