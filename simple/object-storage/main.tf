terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

resource "mgc_object_storage_buckets" "my-bucket" {
  provider = mgc.sudeste
  bucket = "bucket-name"
  enable_versioning = true
  recursive = true # If true, any configuration or operation specified in the resource will be applied not only to the bucket itself but also to all the objects contained within that bucket.
  bucket_is_prefix = false # Indicates whether the bucket name will be used as a prefix for objects.
}