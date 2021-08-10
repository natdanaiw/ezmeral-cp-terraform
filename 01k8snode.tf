#### K8s nodes ####
# 
# Create vm with template
#

resource "vsphere_virtual_machine" "k8snode" {
  depends_on = ["vsphere_virtual_machine.controller","vsphere_virtual_machine.gateway"]

  for_each = {for vm in var.k8snode_vm: vm.hostname => vm}


  name             = each.value.vmname #var.server1_vm_params["name"]
  num_cpus         = var.k8snode_vm_params["vcpu"]
  memory           = var.k8snode_vm_params["ram"]
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  folder           = "${vsphere_folder.folder.path}" #"MCC_TLE_VM/K8S"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  firmware         = var.vsphere_vm_firmware

  # Configure network interface
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Configure Disk
  #disk {
  #  name = "${var.server1_vm_params["hostname"]}.vmdk"
  #  size = var.server1_vm_params["disk_size"]
  #}

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label            = "disk1"
    #size             = "${data.vsphere_virtual_machine.template.disks.1.size}"
    #eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.1.eagerly_scrub}"
    #thin_provisioned = "${data.vsphere_virtual_machine.template.disks.1.thin_provisioned}"
    size             = 500
    thin_provisioned = true
    unit_number      = 1
  }

  disk {
    label            = "disk2"
    #size             = "${data.vsphere_virtual_machine.template.disks.2.size}"
    #eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.2.eagerly_scrub}"
    #thin_provisioned = "${data.vsphere_virtual_machine.template.disks.2.thin_provisioned}"
    size             = 500
    thin_provisioned = true
    unit_number      = 2
  }

  
  # Define template and customisation params
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = each.value.hostname                       #var.server1_vm_params["hostname"]
        domain    = var.k8snode_network_params["domain"]
      }

      network_interface {
        ipv4_address    = each.value.ipv4_address                       #var.server1_network_params["ipv4_address"]
        ipv4_netmask    = var.k8snode_network_params["prefix_length"]
      }

      ipv4_gateway = var.k8snode_network_params["gateway"]
      dns_server_list = var.dns_servers
      dns_suffix_list = ["${var.k8snode_network_params["domain"]}"]
    }
  }
  #depends_on = [vsphere_host_port_group.network_port]
}