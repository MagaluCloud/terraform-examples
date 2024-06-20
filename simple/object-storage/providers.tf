provider "mgc" {
  alias = "sudeste"
  region = "br-se1"
  api_key = "2cfc0ee3-521f-40a0-af99-095962da85ba"
  object_storage = {
    # To use with Object Storage, there is a difference. Since we use the S3 protocol, it is necessary to use key pairs (Key Pairs). To generate key pairs, follow the instructions here https://docs.magalu.cloud/docs/api-keys/how-to/create-api-keys
    key_pair = { 
      key_id = "8ce269da-5f44-4b40-ade7-5b37163b6807"
      key_secret = "f88ae6ef-8a58-437f-9698-8d2d6d5aeca9"
    }
  }
}