output "basic_intance_id" {
  value = mgc_virtual-machine_instances.basic_instance_nordeste.id
}

output "bs_id" {
  value = mgc_block-storage_volumes.example_volume.id
}