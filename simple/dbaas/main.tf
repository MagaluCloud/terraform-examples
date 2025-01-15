terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
  }
}

resource "mgc_dbaas_instances" "dbaas_instances" {
  name                = "my-database-instance"
  user                = "db_user"
  password            = "secure_password123"
  engine_name         = "mysql 8.0"
  instance_type_name  = "cloud-dbaas-bs1.medium"
  volume_size         = 50
}