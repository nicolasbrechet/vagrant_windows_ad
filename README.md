# Vagrant + Windows 2012 R2 + Puppet

## Pre-requisites

* Vagrant (www.vagrantup.com)
* Vagrant plugins:
  * vagrant-hostmanager: `vagrant plugin install vagrant-hostmanager`
  * vagrant-r10k: `vagrant plugin install vagrant-r10k`

## Quick start

Run `vagrant up` and then... wait

## What it does

- Vagrant will use the R10K plugin to download the Puppet modules needed to configure an AD
- Vagrant will download the box used for Windows 2012
- Vagrant will start the box and use the hostmanager plugin to configure local DNS
- Vagrant will use its shell provisionner to install the Puppet agent with the `installPuppet.ps1` script
- Vagrant will use the puppet agent provisionner to setup the machine as an Active Directory, and create the users, groups and OU

## Todo

* use Hiera
* use Roles & Profiles
