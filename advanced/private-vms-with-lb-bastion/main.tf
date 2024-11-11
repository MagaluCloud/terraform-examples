terraform {
  required_providers {
    mgc = {
      source  = "magalucloud/mgc"
      version = "0.29.2"
    }
  }
}

module "network" {
  source = "./modules/network"

  api_key = var.api_key

  project_name      = var.project_name
  allowed_tcp_ports = var.allowed_tcp_ports
  allowed_udp_ports = var.allowed_udp_ports
  lb_tcp_ports      = var.lb_tcp_ports
  lb_udp_ports      = var.lb_udp_ports
}

resource "mgc_ssh_keys" "ssh_keys" {
  name = "${var.project_name}-ssh-key"
  key  = var.ssh_key
}

locals {
  cluster_majority = floor(0.5 + (var.cluster_size + 1) / 2)
  cluster_minority = var.cluster_size - local.cluster_majority
}

resource "mgc_virtual_machine_instances" "cluster_lb" {
  name = "${var.project_name}-lb"
  machine_type = {
    name = var.lb_machine_type
  }
  image = {
    name = "cloud-debian-12 LTS"
  }
  network = {
    # vpc = {
    #   id = module.network.vpc_id
    # }
    associate_public_ip = true
    delete_public_ip    = true
    interface = {
      security_groups = [
        { id = module.network.lb_sec_group_id },
        { id = module.network.ssh_sec_group_id },
      ]
    }
  }

  ssh_key_name = mgc_ssh_keys.ssh_keys.name
}

resource "mgc_virtual_machine_instances" "node_instances" {
  count = var.cluster_size
  name  = "${var.project_name}-node-${count.index}"
  machine_type = {
    name = var.nodes_machine_type
  }
  image = {
    name = "cloud-debian-12 LTS"
  }
  network = {
    # vpc = {
    #   id = module.network.vpc_id
    # }
    associate_public_ip = false
    delete_public_ip    = false
    interface = {
      security_groups = [
        { id = module.network.nodes_sec_group_id },
        { id = module.network.lb_sec_group_id },
        { id = module.network.ssh_sec_group_id },
      ]
    }
  }

  ssh_key_name = mgc_ssh_keys.ssh_keys.name
}

resource "null_resource" "provision_lb" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install haproxy -y",
      "sudo bash -c 'echo \"ENABLED=1\" >> /etc/default/haproxy'"
    ]
  }

  provisioner "file" {
    content = <<-EOT
%{for port in var.lb_tcp_ports[*]~}
frontend tcp_${port}_in
  bind *:${port}
  default_backend tcp_${port}_out
%{endfor~}

%{for port in var.lb_udp_ports[*]~}
frontend udp_${port}_in
  bind *:${port}
  default_backend udp_${port}_out
%{endfor~}

%{for port in var.lb_tcp_ports[*]~}
backend tcp_${port}_out
  mode tcp
  %{for node in mgc_virtual_machine_instances.node_instances[*]~}
  server ${node.name} ${node.network.private_address}:${port} check
  %{endfor~}

%{endfor~}

%{for port in var.lb_udp_ports[*]~}
backend udp_${port}_out
  mode udp
  %{for node in mgc_virtual_machine_instances.node_instances[*]~}
  server ${node.name} ${node.network.private_address}:${port} check
  %{endfor~}

%{endfor~}
EOT
    # destination = "/etc/haproxy/haproxy.cfg"
    destination = "/home/debian/haproxy.cfg"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/debian/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "sudo service haproxy restart",
    ]
  }

  connection {
    type        = "ssh"
    user        = "debian"
    private_key = file(var.ssh_private_key_path)
    host        = mgc_virtual_machine_instances.cluster_lb.network.public_address
  }
}
