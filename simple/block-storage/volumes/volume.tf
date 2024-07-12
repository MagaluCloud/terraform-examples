# volume.tf
terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

# Create a volume 
resource "mgc_block_storage_volumes" "example_volume" {
  name = "example-volume"
  size = 10
  type = {
    name = "cloud_nvme"
  }
}

output "example_volume_id" {
  value = mgc_block_storage_volumes.example_volume.id
}