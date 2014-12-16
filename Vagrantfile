# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = ENV['BOXNAME'] || 'chef/ubuntu-14.04'
  config.vm.box_check_update = false

  # map folders into vm
  config.vm.synced_folder "project_step_definitions", "/spec_dockerbox/project_step_definitions"
  config.vm.synced_folder "tests", "/spec_dockerbox/tests"
  config.vm.synced_folder "dockerfiles", "/spec_dockerbox/dockerfiles"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
  
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision 'shell', path: 'provision.d/01_os.sh'
  config.vm.provision 'shell', path: 'provision.d/05_cucumber.sh'
  config.vm.provision 'shell', path: 'provision.d/10_docker.sh'
  config.vm.provision 'shell', path: 'provision.d/15_cucumber'
  config.vm.provision 'shell', path: 'provision.d/16_build_images.sh'
  config.vm.provision 'shell', path: 'provision.d/20_serverspec'
  config.vm.provision 'shell', path: 'provision.d/21_run_serverspec.sh'

  # build sample image for core-tests
  config.vm.provision 'shell', inline: <<EOF
cd /spec_dockerbox/tests/core-tests/sample_images
./build.sh
EOF


end
