  resource "null_resource" "ezmeral-ansible-provision" {

    depends_on = ["vsphere_virtual_machine.controller","null_resource.controller-ansible-provision","null_resource.gateway-ansible-provision"]
    
    #Run Ansible
    provisioner "local-exec" {
        command =  "ansible-playbook ansible/playbook.yaml -i ansible/inventory/ezmeral"
    }
  }