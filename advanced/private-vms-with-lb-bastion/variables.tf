variable "project_name" {
  type    = string
  default = "my_project_name"
}

variable "hosts_ini_path" {
  type        = string
  description = "hosts.ini file to be exported with cluster nodes and bastion host"
  default     = "./hosts.ini"
}

variable "allowed_tcp_ports" {
  type    = list(number)
  default = [80, 443, 2377, 7946]
}

variable "allowed_udp_ports" {
  type    = list(number)
  default = [4789]
}

variable "lb_tcp_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "lb_udp_ports" {
  type    = list(number)
  default = []
}

variable "nodes_machine_type" {
  type    = string
  default = "BV1-1-10"
}

variable "lb_machine_type" {
  type    = string
  default = "BV1-1-10"
}

variable "cluster_size" {
  type    = number
  default = 3
}

variable "api_key" {
  description = "MGC_API_KEY"
  type        = string
}

variable "ssh_key" {
  description = "ssh key to access all machines in cluster"
  type        = string
}

variable "ssh_private_key_path" {
  description = "privkey used to provision lb"
  type        = string
  default     = "~/.ssh/id_rsa"
}
