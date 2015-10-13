# -*- mode: ruby -*-
# vi: set ft=ruby :

memory = 2048
cpu = 2
server_name = "ad"
domain_name = "test.lab"
server_fqdn = "#{server_name}.#{domain_name}"

Vagrant.configure(2) do |config|
  
  config.vm.box = "opentable/win-2012r2-standard-amd64-nocm"

  config.hostmanager.enabled           = true
  config.hostmanager.manage_host       = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline   = true
  
  config.r10k.puppet_dir = 'puppet' 
  config.r10k.puppetfile_path = 'puppet/Puppetfile' 
  config.r10k.module_path = 'puppet/vendor'

  config.vm.provider "virtualbox" do |v|
    v.memory = memory
    v.cpus = cpu
  end
  
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"]  = memory
    v.vmx["numvcpus"] = cpu
  end
  
  config.vm.define "domaincontroller", primary: true do |dc|
    dc.vm.hostname = server_name
    dc.vm.provision "shell", path: "installPuppet.ps1"
    dc.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "site.pp"
      puppet.module_path = ["puppet/modules", "puppet/vendor"]
    end
  end
end
