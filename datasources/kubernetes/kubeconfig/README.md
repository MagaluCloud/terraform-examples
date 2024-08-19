# Terraform Configuration for Magalu Cloud Kubernetes Cluster

This Terraform configuration demonstrates how to use the Magalu Cloud (`mgc`) provider to retrieve the kubeconfig for a Kubernetes cluster and save it as a local file using the `local` provider. This setup is useful for managing Kubernetes clusters in Magalu Cloud and automating the retrieval of kubeconfig files for local use or CI/CD pipelines.

## Prerequisites

- Terraform installed on your machine.
- Access to Magalu Cloud with permissions to manage Kubernetes clusters.
- An existing Kubernetes cluster in Magalu Cloud.

## Configuration Overview

The configuration is divided into several sections:

1. **Required Providers:** Specifies the Terraform providers required for this configuration. It includes the `mgc` provider for interacting with Magalu Cloud resources and the `local` provider for managing local files.

2. **Provider Configuration:** Initializes the `mgc` provider. No additional configuration is required for the `local` provider in this example.

3. **Data Source - Kubernetes Cluster Kubeconfig:** Uses the `mgc_kubernetes_cluster_kubeconfig` data source to retrieve the kubeconfig of a specified Kubernetes cluster in Magalu Cloud.

4. **Resource - Local File:** Creates a local file named `kubeconfig.yaml` containing the kubeconfig data retrieved from Magalu Cloud.

## Usage

1. **Initialize Terraform:**

    Run `terraform init` to initialize the working directory and download the required providers.

2. **Plan the Terraform Execution:**

    Execute `terraform plan` to preview the actions Terraform will perform based on the current configuration.

3. **Apply the Configuration:**

    Run `terraform apply` to apply the configuration. Terraform will retrieve the kubeconfig for the specified Kubernetes cluster and save it as `kubeconfig.yaml` in the current module's directory.

## Example Output

Below is an example of the kubeconfig file content that will be saved as `kubeconfig.yaml`:

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQVRFL0VYQU1QTEUtLS0tLS0tLS0=
    server: https://example-server:6443
  name: example-cluster
contexts:
- context:
    cluster: example-cluster
    user: example-admin
  name: example-admin@example-cluster
current-context: example-admin@example-cluster
kind: Config
preferences: {}
users:
- name: example-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQVRFL0VYQU1QTEUtLS0tLS0tLS0=
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLS0tLS0=