terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
  }
}

data "terraform_remote_state" "volume" {
  backend = "local" # ou outro backend que você esteja usando, como S3, etc.
  config = {
    path = "../volumes/terraform.tfstate" # caminho para o arquivo tfstate gerado pelo arquivo volume.tf
  }
}

resource "mgc_block_storage_snapshots" "snapshot_example" {
  description = "exemplo de snapshot descrição"
  name = "exemplo snapshot name"
  volume = {
    id = data.terraform_remote_state.volume.outputs.example_volume_id
  }
}