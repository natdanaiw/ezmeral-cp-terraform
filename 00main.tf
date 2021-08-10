provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_template
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  # If you haven't resource pool, put "Resources" after cluster name
  name          = "${var.cluster}/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Exctrat data port vlan creation
data "vsphere_host" "host" {
  name          = var.host
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "folder" {
  path          = "MCC_TLE_VM/EzmeralCP"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}