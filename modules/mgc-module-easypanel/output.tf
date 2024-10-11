output "easypanel_vm_public_ip" {
  value       = mgc_virtual_machine_instances.easypanel_vm.network.public_address
  description = "Endereço IP público da VM"
}