# Authenticating with the MGC Provider in Terraform

To use the Magalu Cloud (MGC) provider in Terraform, you need to authenticate using an API key. This guide will walk you through the process of setting up your Terraform configuration to authenticate with the MGC provider.

## Step 1: Obtain Your API Key

Follow the instructions in [this document](https://docs.magalu.cloud/docs/terraform/how-to/auth/) to obtain the API key

## Step 2: Configure the MGC Provider in Terraform

Once you have your API key, you can configure the MGC provider in your Terraform configuration file. Here's how to do it:

1. Open your Terraform configuration file (e.g., `main.tf`).
2. Add the `mgc` provider block to your configuration, specifying the `source` attribute as `magalucloud/mgc`.
3. Inside the `provider` block, set the `api_key` attribute to your actual API key.

Here is an example configuration:

```terraform
terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

provider "mgc" {
  api_key = "your-api-key-here"
}
```

Replace `"your-api-key-here"` with your actual API key.

## Step 3: Initialize Terraform

After configuring the provider, you need to initialize your Terraform workspace. This step downloads the MGC provider plugin and prepares your workspace for use. Run the following command in your terminal:

```bash
terraform init
```

## Step 4: Plan and Apply Your Configuration

With the provider configured and your workspace initialized, you can now plan and apply your Terraform configuration. Run the following commands to see what Terraform will do and then apply the changes:

```bash
terraform plan
terraform apply
```

## Conclusion

You have successfully configured the MGC provider in Terraform using your API key for authentication. You can now proceed to define resources and manage your Magalu Cloud infrastructure using Terraform.