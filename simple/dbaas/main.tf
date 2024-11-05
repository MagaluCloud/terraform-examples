terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
  }
}

resource "mgc_dbaas_instances" "dbaas_example" {
  flavor_id = "8bbe8e01-40c8-4d2b-80e8-189debc44b1c"
  name = "dbaas-example"
  user = "admin"
  password = "admin123"
  engine_id = "063f3994-b6c2-4c37-96c9-bab8d82d36f7"
  volume = {
    size = 10
    type = "CLOUD_NVME_15K"
  }
}
