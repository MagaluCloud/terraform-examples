terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
  }
  backend "s3" {
    bucket = "tf-state"
    key        = "terraform.tfstate"
    secret_key = "0f7e6ed0-288a-40b2-88c2-6a10ad0717cf"
    access_key = "2b4d2ec6-5871-4f4a-8e5e-d13c154b8c61"
    region = "br-se1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_s3_checksum = true
    endpoints = {
      s3 = "https://br-se1.magaluobjects.com/"
    }
  }
}