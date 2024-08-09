terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}