output "cluster_info" {
  value = <<-EOT
Cluster:
Cluter Size: ${var.cluster_size}
Marjority: ${local.cluster_majority}
Minority: ${local.cluster_minority}
Bastion/LB IP: ${mgc_virtual_machine_instances.cluster_lb.network.public_address}
EOT
}

resource "local_file" "hosts_ini" {
  filename = var.hosts_ini_path
  content  = <<-EOT
[bastion]
${mgc_virtual_machine_instances.cluster_lb.network.public_address}

[nodes]
%{for node in mgc_virtual_machine_instances.node_instances[*]~}
${node.network.private_address} ansible_ssh_common_args="-J debian@${mgc_virtual_machine_instances.cluster_lb.network.public_address}"
%{endfor~}

[all]
${mgc_virtual_machine_instances.cluster_lb.network.public_address}
%{for node in mgc_virtual_machine_instances.node_instances[*]~}
${node.network.private_address} ansible_ssh_common_args="-J debian@${mgc_virtual_machine_instances.cluster_lb.network.public_address}"
%{endfor~}
EOT
}


# output "haproxy_cfg" {
#   value = <<-EOT
# %{for port in var.lb_tcp_ports[*]~}
# frontend tcp_${port}_in
#   bind *:${port}
#   default_backend tcp_${port}_out
# %{endfor~}

# %{for port in var.lb_udp_ports[*]~}
# frontend udp_${port}_in
#   bind *:${port}
#   default_backend udp_${port}_out
# %{endfor~}

# %{for port in var.lb_tcp_ports[*]~}
# backend tcp_${port}_out
#   mode tcp
#   %{for node in mgc_virtual_machine_instances.node_instances[*]~}
#   server ${node.name} ${node.network.private_address}:${port} check
#   %{endfor~}

# %{endfor~}

# %{for port in var.lb_udp_ports[*]~}
# backend udp_${port}_out
#   mode udp
#   %{for node in mgc_virtual_machine_instances.node_instances[*]~}
#   server ${node.name} ${node.network.private_address}:${port} check
#   %{endfor~}

# %{endfor~}
# EOT
# }
