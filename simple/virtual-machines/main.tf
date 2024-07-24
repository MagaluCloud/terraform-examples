terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}


# Create a VM at Nordeste br-ne1
resource "mgc_virtual_machine_instances" "basic_instance_nordeste" {
  provider = mgc.nordeste # We specify the provider region here to indicate that this VM should be created in the Nordeste region.
  name     = "basic-instance-nordeste"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false # If true, will create a public IP
    delete_public_ip    = false
  }

  ssh_key_name = "ssh_key"
}

# Create a VM at Sudeste br-se1
resource "mgc_virtual_machine_instances" "basic_instance_sudeste" {
  provider = mgc.sudeste
  name     = "basic-instance-sudeste"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false
    delete_public_ip    = false
  }

  ssh_key_name = "ssh_key"
}

# Create a VM and associate a Public IP
resource "mgc_virtual_machine_instances" "basic_instance_public_ip" {
  provider = mgc.sudeste
  name     = "basic-instance-public-ip"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = true
    delete_public_ip    = true # We specify that when this VM is deleted, the public IP should be deleted as well.
  }

  ssh_key_name = "ssh_key"
}

# Create a VM and associate with specific Security Group
resource "mgc_virtual_machine_instances" "basic_instance_with_SG" {
  name = "basic-instance-nordeste-with-sg"
  machine_type = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false # If true, will create a public IP
    delete_public_ip = false
    interface = {
      security_groups = [{ "id" : "2b4d2ec6-5871-4f4a-8e5e-d13c154b8c61" }]
    }
  }
  ssh_key_name = "ssh_key"
}
