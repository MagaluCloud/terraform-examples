terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

# Create a volume 
resource "mgc_block-storage_volumes" "example_volume" {
  name = "example-volume"
  size = 10
  type = {
    name = "cloud_nvme"
  }
}

# Create a snapshot
resource "mgc_block-storage_snapshots" "snapshot_example_colume" {
  description = "exemplo de snapshot descrição"
  name = "exemplo snapshot name"
  volume = {
    id = mgc_block-storage_volumes.example_volume.id
    name = mgc_block-storage_volumes.example_volume.name
  }
}