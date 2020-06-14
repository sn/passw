# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "apollo-rails"
  config.vm.box_url = "https://d1hsi8odkb69rd.cloudfront.net/apollo-rails.box"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    ln -s /vagrant_data ~/passw
  SHELL
end