resource "null_resource" "k8snode-ansible-provision" {

  depends_on = ["null_resource.gateway-ansible-provision"]

  ##Create gateway Inventory
  provisioner "local-exec" {
    command =  "echo \"\n[ezmeral-k8snode]\" >> ansible/inventory/ezmeral"
  }
 
  for_each = {for vm in var.k8snode_vm: vm.hostname => vm}

  provisioner "local-exec" {
    command =  "echo \"${join("\n",formatlist("%s ansible_ssh_host=%s ansible_user=%s ansible_ssh_pass=%s", each.value.hostname, each.value.ipv4_address,var.vsphere_vm_username,var.vsphere_vm_password))}\" >> ansible/inventory/ezmeral"
  }
}