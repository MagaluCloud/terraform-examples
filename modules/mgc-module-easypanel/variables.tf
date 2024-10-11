
variable "provider_region" {
  description = "Region (br-ne1 or br-se1)"
  type        = string
  default     = "br-se1"
}

variable "provider_api_key" {
  description = "API Key to Auth at MGC"
  type        = string
  sensitive   = true
}

variable "vm_name" {
  description = "VM Name"
  type        = string
  default     = "easypanel-vm"
}

variable "machine_type" {
  description = "Type of VM"
  type        = string
  default     = "cloud-bs1.xsmall"
}

variable "image" {
  description = "Image for VM"
  type        = string
  default     = "cloud-ubuntu-22.04 LTS"
}

variable "associate_public_ip" {
  description = "VM with public IP"
  type        = bool
  default     = true
}

variable "ssh_key_name" {
  description = "SSH Key Name"
  type        = string
  default     = "ssh_key"
}

variable "private_key_path" {
  description = "Path to SSH Key"
  type        = string
  default     = "~/.ssh/id_rsa"
}
