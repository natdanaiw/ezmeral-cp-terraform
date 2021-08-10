resource "null_resource" "controller-ansible-provision" {

  depends_on = ["vsphere_virtual_machine.controller"]

  ##Create controller Inventory
  provisioner "local-exec" {
    command =  "echo \"[ezmeral-controller]\" > ansible/inventory/ezmeral"
  }
 
  for_each = vsphere_virtual_machine.controller

  provisioner "local-exec" {
    command =  "echo \"${join("\n",formatlist("%s ansible_ssh_host=%s ansible_user=%s ansible_ssh_pass=%s", each.value.clone.0.customize.0.linux_options.0.host_name, each.value.clone.0.customize.0.network_interface.0.ipv4_address,var.vsphere_vm_username,var.vsphere_vm_password))}\" >> ansible/inventory/ezmeral"
  }
}