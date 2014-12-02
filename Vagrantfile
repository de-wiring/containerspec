# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = ENV['BOXNAME'] || 'chef/debian-7.7'
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
  
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision 'shell', path: 'provision.d/01_os.sh'
  config.vm.provision 'shell', path: 'provision.d/05_cucumber.sh'
  config.vm.provision 'shell', path: 'provision.d/10_docker.sh'
  config.vm.provision 'shell', path: 'provision.d/20_serverspec'
  config.vm.provision 'shell', path: 'provision.d/21_run_serverspec.sh'
end
