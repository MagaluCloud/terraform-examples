# attach.tf
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

resource "mgc_block_storage_volume_attachment" "attach_example" {
  block_storage_id = data.terraform_remote_state.volume.outputs.example_volume_id
  virtual_machine_id = "addccc0a-dff6-4e2e-a6da-a9463eb5f73c"
}