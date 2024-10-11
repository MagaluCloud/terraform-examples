terraform {
  required_providers {
    mgc = {
      source = "MagaluCloud/mgc"
      version = "0.27.1"
    }
  }
}

provider "mgc" {
  alias  = "mgc"
  region = var.provider_region
  api_key = var.provider_api_key
}

resource "mgc_virtual_machine_instances" "easypanel_vm" {
  provider = mgc.mgc
  name = var.vm_name
  machine_type = {
    name = var.machine_type
  }
  image = {
    name = var.image
  }
  network = {
    associate_public_ip = var.associate_public_ip    
    }
  ssh_key_name = var.ssh_key_name  

  provisioner "remote-exec" {
    inline = [
      # Update the VM
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      # Start docker
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      # Run easypanel
      "sudo docker run --rm -it -v /etc/easypanel:/etc/easypanel -v /var/run/docker.sock:/var/run/docker.sock:ro easypanel/easypanel setup"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"  
      private_key = file(var.private_key_path)
      host        = mgc_virtual_machine_instances.easypanel_vm.network.public_address
    }
}
}
