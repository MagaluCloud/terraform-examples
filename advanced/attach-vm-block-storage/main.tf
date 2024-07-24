terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

# Create a volume 
resource "mgc_block_storage_volumes" "example_volume" {
  provider = mgc.nordeste
  name = "example-volume"
  size = 10
  type = {
    name = "cloud_nvme"
  }
}

# Create a VM at Nordeste br-ne1
resource "mgc_virtual_machine_instances" "basic_instance_nordeste" {
  provider = mgc.nordeste # We specify the provider region here to indicate that this VM should be created in the Nordeste region.
  name = "basic-instance-nordeste"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false # If true, will create a public IP
  }
  delete_public_ip = false
  ssh_key_name   = var.ssh_key_name
}

# Attaching the VM with Block Storage
resource "mgc_block_storage_volume-attachment" "attached_block_storage" {
  block_storage_id = mgc_block-storage_volumes.example_volume.id
  virtual_machine_id = mgc_virtual-machine_instances.basic_instance_nordeste.id
}