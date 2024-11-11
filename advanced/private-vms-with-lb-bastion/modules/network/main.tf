terraform {
  required_providers {
    mgc = {
      source  = "magalucloud/mgc"
      version = "0.29.2"
    }
  }
}

# resource "mgc_network_vpcs" "cluster_vpc" {
#   name        = "${var.project_name}-vpc"
#   description = "${var.project_name}-vpc"
# }

resource "mgc_network_security_groups" "ssh_sec_group" {
  name = "${var.project_name}-ssh-sec-group"
}

resource "mgc_network_security_groups" "instances_sec_group" {
  name = "${var.project_name}-workers-sec-group"
}

resource "mgc_network_security_groups" "lb_sec_group" {
  name = "${var.project_name}-lb-sec-group"
}

resource "mgc_network_security_groups_rules" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = 22
  port_range_min    = 22
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.ssh_sec_group.id
}

resource "mgc_network_security_groups_rules" "allow_tcp" {
  for_each          = toset([for port in var.allowed_tcp_ports : tostring(port)])
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = each.key
  port_range_min    = each.key
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.instances_sec_group.id
}

resource "mgc_network_security_groups_rules" "allow_udp" {
  for_each          = toset([for port in var.allowed_udp_ports : tostring(port)])
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = each.key
  port_range_min    = each.key
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.instances_sec_group.id
}

resource "mgc_network_security_groups_rules" "allow_tcp_lb" {
  for_each          = toset([for port in var.lb_tcp_ports : tostring(port)])
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = each.key
  port_range_min    = each.key
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.lb_sec_group.id
}

resource "mgc_network_security_groups_rules" "allow_udp_lb" {
  for_each          = toset([for port in var.lb_udp_ports : tostring(port)])
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = each.key
  port_range_min    = each.key
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.lb_sec_group.id
}
