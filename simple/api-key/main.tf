terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

provider mgc {
    api_key = "your-api-key"
}

resource "mgc_virtual_machine_instances" "basic_instance" {
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
  ssh_key_name = "ssh-key-name"
}