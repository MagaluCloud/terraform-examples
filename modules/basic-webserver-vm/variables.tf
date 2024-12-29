
variable "provider_region" {
  description = "Region (br-ne1 or br-se1)"
  type        = string
  default     = "br-se1"
}

variable "vm_name" {
  description = "VM Name"
  type        = string
}

variable "machine_type" {
  description = "Type of VM"
  type        = string
  default     = "cloud-bs1.xsmall"
}

variable "image" {
  description = "Image for VM"
  type        = string
  default     = "cloud-rocky-09"
}

variable "associate_public_ip" {
  description = "VM with public IP"
  type        = bool
  default     = true
}

variable "ssh_key" {
  description = "SSH Key"
  type        = string
}

variable "interface_id" {
  description = "Interface ID"
  type        = string
}