terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
      version = "0.18.10"
    }
  }
}

resource "mgc_object-storage_buckets" "my-bucket" {
  bucket = "bucket-name"
  enable_versioning = true
  recursive = true # If true, any configuration or operation specified in the resource will be applied not only to the bucket itself but also to all the objects contained within that bucket.
}