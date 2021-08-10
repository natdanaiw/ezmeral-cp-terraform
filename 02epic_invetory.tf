resource "null_resource" "epic-ansible-provision" {

  depends_on = ["null_resource.k8snode-ansible-provision"]

  ##Create gateway Inventory
  provisioner "local-exec" {
    command =  "echo \"\n[ezmeral-epic]\" >> ansible/inventory/ezmeral"
  }
 
  for_each = {for vm in var.epic_vm: vm.hostname => vm}

  provisioner "local-exec" {
    command =  "echo \"${join("\n",formatlist("%s ansible_ssh_host=%s ansible_user=%s ansible_ssh_pass=%s", each.value.hostname, each.value.ipv4_address,var.vsphere_vm_username,var.vsphere_vm_password))}\" >> ansible/inventory/ezmeral"
  }
}