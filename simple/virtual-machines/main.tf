terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
      version = "0.18.10"
    }
  }
}


# Create a VM at Nordeste br-ne1
resource "mgc_virtual-machine_instances" "basic_instance_nordeste" {
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

# Create a VM at Sudeste br-se1
resource "mgc_virtual-machine_instances" "basic_instance" {
  provider = mgc.sudeste
  name = "basic-instance"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false
  }
  delete_public_ip = false
  ssh_key_name   = var.ssh_key_name
}

# Create a VM and associate a Public IP
resource "mgc_virtual-machine_instances" "basic_instance" {
  provider = mgc.sudeste
  name = "basic-instance"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = true
  }
  delete_public_ip = true # We specify that when this VM is deleted, the public IP should be deleted as well.
  ssh_key_name   = var.ssh_key_name
}