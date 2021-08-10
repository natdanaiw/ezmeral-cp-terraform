variable "vsphere_user" {
  type = string
  default = "administrator@vsphere.local" 
}

variable "vsphere_password" {
  type    = string
  default = "P@ssw0rd"
}

variable "vsphere_server" {
  type    = string
  default = "10.41.37.217"
}

variable "vsphere_datacenter" {
  type = string
  default = "MCC_Datacenter"
}

variable "vsphere_datastore" {
  type = string
  #default = "A9000_HPE_BladeESX_DS3"
  default = "ESXi171LocalDisk2"
}

variable "vsphere_network" {
  type = string
  default = "VM Network"
}

variable "vsphere_vm_template" {
  type = string
  default = "MCC_Tle_RHEL7_1"
}

variable "vsphere_vm_username" {
  type = string
  default = "root"
}

variable "vsphere_vm_password" {
  type = string
  default = "P@ssw0rd"
}

variable "vsphere_vm_firmware" {
  description = "Firmware set to bios or efi depending on Template in case os not found"
  #default = "efi"
  default = "bios"
}

# Set cluster where you want deploy your vm
variable "cluster" {
  type = string
  #default = "MCC-HPE Cluster"
  default = "MCC-HPE-Container"
}

# Set host where you want deploy your vm
variable "host" {
  default = "10.41.37.140"
}

variable "dns_servers" {
  default = ["10.41.37.70"]
}

#### PARAMS controller INSTANCES #####################################
#
#
#

variable "controller_vm" {
  type = list(object({
    vmname = string
    hostname = string
    ipv4_address = string 
  }))
  default = [
    {
        vmname = "MCCTLEController01"
        hostname = "controller01",
        ipv4_address = "10.41.37.141"
    }
  ]
}

variable "controller_vm_params" {
  default = {
    vcpu     = "8"
    ram      = "32768"
    disk_size      = "500"
 
    #name     = "MCCTLEcontroller01"
    #hostname = "controller01"
    # You can't set a datastore name with interspace
    #disk_datastore = "datastore_test"
  }
}

variable "controller_network_params" {
  default = {
    domain        = "mcc.local"
    label         = "vm_network_1"
    vlan_id       = "1"
    prefix_length = "24"
    gateway       = "10.41.37.1"

    #ipv4_address  = "10.41.37.136"
    
  }
}

#### PARAMS GATEWAY INSTANCES #####################################
#
#
#

variable "gateway_vm" {
  type = list(object({
    vmname = string
    hostname = string
    ipv4_address = string 
  }))
  default = [
    {
        vmname = "MCCTLEGateway01"
        hostname = "gateway01",
        ipv4_address = "10.41.37.139"
    }
  ]
}

variable "gateway_vm_params" {
  default = {
    vcpu     = "4"
    ram      = "16384"
    disk_size      = "500"

  }
}

variable "gateway_network_params" {
  default = {
    domain        = "mcc.local"
    label         = "vm_network_1"
    vlan_id       = "1"
    prefix_length = "24"
    gateway       = "10.41.37.1"

  }
}

#### PARAMS K8S INSTANCES #####################################
#
#
#

variable "k8snode_vm" {
  type = list(object({
    vmname = string
    hostname = string
    ipv4_address = string 
  }))
  default = [
    {
        vmname = "MCCTLEEZMaster01"
        hostname = "master01",
        ipv4_address = "10.41.37.91"
    },
    {
        vmname = "MCCTLEEZWorker01"
        hostname = "worker01",
        ipv4_address = "10.41.37.92"
    },
    {
        vmname = "MCCTLEEZWorker02"
        hostname = "worker02",
        ipv4_address = "10.41.37.93"
    },
    {
        vmname = "MCCTLEEZWorker03"
        hostname = "worker03",
        ipv4_address = "10.41.37.94"
    }

  ]
}

variable "k8snode_vm_params" {
  default = {
    vcpu     = "8"
    ram      = "32768"
    disk_size      = "500"

  }
}

variable "k8snode_network_params" {
  default = {
    domain        = "mcc.local"
    label         = "vm_network_1"
    vlan_id       = "1"
    prefix_length = "24"
    gateway       = "10.41.37.1"

  }
}
#### PARAMS EPIC INSTANCES #####################################
#
#
#

variable "epic_vm" {
  type = list(object({
    vmname = string
    hostname = string
    ipv4_address = string 
  }))
  default = [
    {
        vmname = "MCCTLEEPIC01"
        hostname = "epic01",
        ipv4_address = "10.41.37.81"
    },
    {
        vmname = "MCCTLEEPIC02"
        hostname = "epic02",
        ipv4_address = "10.41.37.82"
    },
    {
        vmname = "MCCTLEEPIC03"
        hostname = "epic03",
        ipv4_address = "10.41.37.83"
    },
    {
        vmname = "MCCTLEEPIC04"
        hostname = "epic04",
        ipv4_address = "10.41.37.84"
    },
    {
        vmname = "MCCTLEEPIC05"
        hostname = "epic05",
        ipv4_address = "10.41.37.86"
    }

  ]
}

variable "epic_vm_params" {
  default = {
    vcpu     = "8"
    ram      = "32768"
    disk_size      = "500"

  }
}

variable "epic_network_params" {
  default = {
    domain        = "mcc.local"
    label         = "vm_network_1"
    vlan_id       = "1"
    prefix_length = "24"
    gateway       = "10.41.37.1"

  }
}
