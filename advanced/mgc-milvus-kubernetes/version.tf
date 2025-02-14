terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}