terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
      version = "0.23.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
