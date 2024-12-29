terraform {
  required_providers {
    mgc = {
      source = "MagaluCloud/mgc"
      version = "0.31.0"
    }
  }
}

provider "mgc" {
  alias  = "mgc"
  region = var.provider_region
}

resource "mgc_ssh_keys" "my_key" {
  provider = mgc
  name = "local"
  key = var.ssh_key
}

resource "mgc_network_security_groups" "basic_security_group" {
  name                  = "basic-security-group"
  description           = "A basic security group"
  disable_default_rules = false
}

resource "mgc_network_security_groups_rules" "allow_ssh" {
  description      = "Allow incoming SSH traffic"
  direction        = "ingress"
  ethertype        = "IPv4"
  port_range_max   = 22
  port_range_min   = 22
  protocol         = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_network_security_groups_rules" "allow_ssh_ipv6" {
  description      = "Allow incoming SSH traffic from IPv6"
  direction        = "ingress"
  ethertype        = "IPv6"
  port_range_max   = 22
  port_range_min   = 22
  protocol         = "tcp"
  remote_ip_prefix = "::/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_network_security_groups_rules" "allow_http" {
  description      = "Allow incoming HTTP traffic"
  direction        = "ingress"
  ethertype        = "IPv4"
  port_range_max   = 80
  port_range_min   = 80
  protocol         = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_network_security_groups_rules" "allow_http_ipv6" {
  description      = "Allow incoming HTTP traffic from IPv6"
  direction        = "ingress"
  ethertype        = "IPv6"
  port_range_max   = 80
  port_range_min   = 80
  protocol         = "tcp"
  remote_ip_prefix = "::/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_network_security_groups_rules" "allow_https" {
  description      = "Allow incoming HTTPS traffic"
  direction        = "ingress"
  ethertype        = "IPv4"
  port_range_max   = 443
  port_range_min   = 443
  protocol         = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_network_security_groups_rules" "allow_https_ipv6" {
  description      = "Allow incoming HTTPS traffic from IPv6"
  direction        = "ingress"
  ethertype        = "IPv6"
  port_range_max   = 443
  port_range_min   = 443
  protocol         = "tcp"
  remote_ip_prefix = "::/0"
  security_group_id = mgc_network_security_groups.basic_security_group.id
}

resource "mgc_virtual_machine_instances" "server" {
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
    interface = {
      security_groups = [{ id = mgc_network_security_groups.basic_security_group.id }]
    }  
  }

  ssh_key_name = mgc_ssh_keys.my_key.name
}

resource "mgc_network_security_groups_attach" "attach_sg_to_interface" {
  security_group_id = mgc_network_security_groups.basic_security_group.id
  interface_id = var.interface_id
}
