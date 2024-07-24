provider "mgc" {
  alias = "sudeste"
  region = "br-se1"
  api_key = "1585f53f-8f86-483a-850e-e2e7528ea14e"
  object_storage = {
    # To use with Object Storage, there is a difference. Since we use the S3 protocol, it is necessary to use key pairs (Key Pairs). To generate key pairs, follow the instructions here https://docs.magalu.cloud/docs/api-keys/how-to/create-api-keys
    key_pair = { 
      key_id = "1585f53f-8f86-483a-850e-e2e7528ea14e"
      key_secret = "1585f53f-8f86-483a-850e-e2e7528ea14e"
    }
  }
}