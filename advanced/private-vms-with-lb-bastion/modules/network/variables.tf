variable "project_name" {
  type = string
}

variable "allowed_udp_ports" {
  type    = list(number)
  default = []
}

variable "allowed_tcp_ports" {
  type    = list(number)
  default = []
}

variable "lb_tcp_ports" {
  type    = list(number)
  default = []
}

variable "lb_udp_ports" {
  type    = list(number)
  default = []
}

variable "api_key" {
  description = "MGC_API_KEY"
  type        = string
}
