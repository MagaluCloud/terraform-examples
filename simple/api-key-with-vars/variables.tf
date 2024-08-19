
variable "mgc_api_key" {
  type = string
  description = "Chave da Magalu Cloud"
  sensitive = true
  nullable = false
}

variable "mgc_obj_key_id" {
  type = string
  description = "ID da Chave do Object Storage"
  sensitive = true
  nullable = false
}

variable "mgc_obj_key_secret" {
  type = string
  description = "Secret da Chave do Object Storage"
  sensitive = true
  nullable = false
}

variable "mgc_region" {
  type = string
  description = "Região da Magalu Cloud"
  sensitive = true
  nullable = false
}