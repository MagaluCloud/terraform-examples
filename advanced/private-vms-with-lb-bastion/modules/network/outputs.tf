# output "vpc_id" {
#   value = mgc_network_vpcs.cluster_vpc.id
# }

output "nodes_sec_group_id" {
  value = mgc_network_security_groups.instances_sec_group.id
}

output "lb_sec_group_id" {
  value = mgc_network_security_groups.lb_sec_group.id
}

output "ssh_sec_group_id" {
  value = mgc_network_security_groups.ssh_sec_group.id
}
