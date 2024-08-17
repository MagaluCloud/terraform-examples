# Authenticating with the MGC Provider in Terraform

To use the Magalu Cloud (MGC) provider in Terraform, you need to authenticate using an API key and configure object storage keys. This guide will walk you through the process of setting up your Terraform configuration to authenticate with the MGC provider.

## Step 1: Obtain Your API Key and Object Storage Keys

Follow the instructions in [this document](https://docs.magalu.cloud/docs/terraform/how-to/auth/) to obtain your API key, object storage key ID, and secret.

**Note:** You can also access your API keys through the Magalu Cloud console at the following URL: [https://id.magalu.com/api-keys](https://id.magalu.com/api-keys).

## Step 2: Set Environment Variables

Before configuring the MGC provider in Terraform, you need to ensure that the following environment variables are set. These variables will be used to pass sensitive information to Terraform securely:

- `TF_VAR_mgc_api_key=`
- `TF_VAR_mgc_obj_key_id=`
- `TF_VAR_mgc_obj_key_secret=`
- `TF_VAR_mgc_region=`

Make sure to replace the empty values with your actual credentials.

### Example

You can set these variables in your shell before running Terraform commands:

```bash
export TF_VAR_mgc_api_key="your-api-key"
export TF_VAR_mgc_obj_key_id="your-object-key-id"
export TF_VAR_mgc_obj_key_secret="your-object-key-secret"
export TF_VAR_mgc_region="your-region"
```

## Step 3: Configure the MGC Provider in Terraform

Once you have your API key and object storage keys set in the environment variables, you can configure the MGC provider in your Terraform configuration files. Here's how to do it:

1. Open your Terraform configuration files (e.g., `main.tf`, `providers.tf`, `variables.tf`).
2. Add the `mgc` provider block in `providers.tf`, specifying the `region`, `api_key`, and `object_storage` attributes with appropriate variables.

Here is an example configuration:

```terraform
// providers.tf
provider "mgc" {
  region  = var.mgc_region
  api_key = var.mgc_api_key
  object_storage = {
    key_pair = {
      key_id     = var.mgc_obj_key_id
      key_secret = var.mgc_obj_key_secret
    }
  }
}

// variables.tf
variable "mgc_api_key" {
  type        = string
  description = "Chave da Magalu Cloud"
  sensitive   = true
  nullable    = false
}

variable "mgc_obj_key_id" {
  type        = string
  description = "ID da Chave do Object Storage"
  sensitive   = true
  nullable    = false
}

variable "mgc_obj_key_secret" {
  type        = string
  description = "Secret da Chave do Object Storage"
  sensitive   = true
  nullable    = false
}

variable "mgc_region" {
  type        = string
  description = "Região da Magalu Cloud"
  sensitive   = true
  nullable    = false
}
```

## Step 4: Define Your Resources

You can now define the resources you want to manage using the MGC provider. Below is an example of defining a virtual machine instance:

```terraform
// main.tf
resource "mgc_virtual_machine_instances" "basic_instance" {
  name          = "basic-instance"
  machine_type  = {
    name = "cloud-bs1.xsmall"
  }
  image = {
    name = "cloud-ubuntu-22.04 LTS"
  }
  network = {
    associate_public_ip = false
    delete_public_ip    = false
  }

  ssh_key_name = "ssh_key"
}
```

## Step 5: Initialize Terraform

After configuring the provider and defining your resources, you need to initialize your Terraform workspace. This step downloads the MGC provider plugin and prepares your workspace for use. Run the following command in your terminal:

```bash
terraform init
```

## Step 6: Plan and Apply Your Configuration

With the provider configured and your workspace initialized, you can now plan and apply your Terraform configuration. Run the following commands to see what Terraform will do and then apply the changes:

```bash
terraform plan
terraform apply
```

## Conclusion

You have successfully configured the MGC provider in Terraform using your API key and object storage keys for authentication. You can now proceed to define and manage your Magalu Cloud infrastructure using Terraform.
