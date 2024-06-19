terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
      version = "0.19.0"
    }
  }
}

# Create a volume 
resource "mgc_block-storage_volumes" "example_volume" {
  name = "example-volume"
  size = 10
  type = {
    name = "cloud_nvme"
  }
}

# Attaching the VM with Block Storage
resource "mgc_block-storage_volume-attachment" "attached_block_storage" {
  block_storage_id = mgc_block-storage_volumes.example_volume.id
  virtual_machine_id = mgc_virtual-machine_instances.basic_instance.id # This it's just a examples of VM
}

# Create a snapshot
resource "mgc_block-storage_snapshots" "snapshot_example_colume" {
  description = "exemplo de snapshot descrição"
  name = "exemplo snapshot name"
  volume = {
    id = mgc_block-storage_volumes.example_volume.id
    name = mgc_block-storage_volumes.example_volume.name
  }
}