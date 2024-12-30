# Basic Webserver VM Module

This module creates a virtual machine on Magalu Cloud with a basic webserver configuration.

## Variables

The following variables are required:

* `provider_region`: The region where the VM will be created (br-ne1 or br-se1)
* `vm_name`: The name of the VM
* `machine_type`: The type of VM (default: cloud-bs1.xsmall)
* `image`: The image for the VM (default: cloud-rocky-09)
* `associate_public_ip`: Whether the VM should have a public IP (default: true)
* `ssh_key`: The SSH key to use for the VM
* `interface_id`: The ID of the interface to attach to the VM

## Outputs

The following output is available:

* `server_id`: The ID of the created server

## Usage

To use this module, create a `main.tf` file with the following content:
```hcl
module "basic_webserver_vm" {
  source = "../modules/basic-webserver-vm"

  provider_region = "br-se1"
  vm_name         = "my-webserver-vm"
  ssh_key         = "my-ssh-key"
}
```
Then, run `terraform apply` to create the VM.

Note: This module assumes that you have already set up a Magalu Cloud provider and have the necessary credentials.