# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "apolloblack/ruby"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    ln -s /vagrant_data ~/ripcord
    cd ~/ripcord && /home/vagrant/bin/bundler install
  SHELL
end
