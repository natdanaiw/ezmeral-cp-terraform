#### Gateway ####
# 
# Create vm with template
#

resource "vsphere_virtual_machine" "gateway" {
  for_each = {for vm in var.gateway_vm: vm.hostname => vm}


  name             = each.value.vmname #var.server1_vm_params["name"]
  num_cpus         = var.gateway_vm_params["vcpu"]
  memory           = var.gateway_vm_params["ram"]
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

  # Define template and customisation params
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = each.value.hostname                       #var.server1_vm_params["hostname"]
        domain    = var.gateway_network_params["domain"]
      }

      network_interface {
        ipv4_address    = each.value.ipv4_address                       #var.server1_network_params["ipv4_address"]
        ipv4_netmask    = var.gateway_network_params["prefix_length"]
      }

      ipv4_gateway = var.gateway_network_params["gateway"]
      dns_server_list = var.dns_servers
      dns_suffix_list = ["${var.gateway_network_params["domain"]}"]
    }
  }
  #depends_on = [vsphere_host_port_group.network_port]
}