# Easypanel Module on an MGC VM

This module creates a virtual machine on Magalu Cloud and runs an Easypanel container on it.

## Variables

- `provider_region`: Magalu Cloud provider region (default: `br-ne1`).
- `provider_api_key`: [API Key](https://docs.magalu.cloud/docs/devops-tools/api-keys/how-to/other-products/create-api-key)
- `vm_name`: Name of the virtual machine.
- `machine_type`: Type of the virtual machine (default: `cloud-bs1.xsmall`).
- `image`: Virtual machine image (default: `cloud-ubuntu-22.04 LTS`).
- `associate_public_ip`: Whether the VM should have a public IP (default: `true`).
- `ssh_key_name`: SSH key name.
- `private_key_path`: Path to the SSH private key (default: `~/.ssh/id_rsa`).

## Outputs

- `easypanel_vm_public_ip`: Public IP address of the virtual machine where Easypanel is running.

## How to Use

```hcl
module "easypanel_vm" {
  source           = "../mgc-module-easypanel"
  vm_name          = "my-vm-easypanel"
  ssh_key_name     = "my-ssh-key"
  private_key_path = "~/.ssh/id_rsa"
  provider_api_key = "api-key"
}
```

Then, simply access your VM's IP on port 3000, **exemplo**:
`http://201.23.18.205:3000/`


> 🚨 **Importante:**
> 
> Make sure to open port 3000 for access in the security group, learn more in the [oficial documentation](https://docs.magalu.cloud/docs/network/how-to/create-security-groups)


> This model it's [available in registry](https://registry.terraform.io/modules/lfpicoloto1/easypanel/mgc/latest)