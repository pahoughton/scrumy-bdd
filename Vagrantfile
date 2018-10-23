# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |cfg|

  nname = "gocd"

  cfg.vm.define nname do |ncfg|
    ncfg.vm.box      = "centos/7"
    ncfg.vm.hostname = "gocd"

    ncfg.vm.provider "virtualbox" do |vb|
      vb.cpus   = 2
      vb.memory = "4096"
    end
    ncfg.vm.network "forwarded_port", guest: 8153, host: 8153
    ncfg.vm.network "forwarded_port", guest: 8154, host: 8154
  end
  # Ansible provisioner.
  # cfg.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "wirde.yml"
  #   # ansible.inventory_path = "inventory"
  #   ansible.sudo = true
  # end

end
