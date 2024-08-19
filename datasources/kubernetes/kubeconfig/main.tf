terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "mgc" {
}

data "mgc_kubernetes_cluster_kubeconfig" "cluster" {
  cluster_id = "a132d346-cfe9-4f0e-bf88-4688437ee8fe"
}

resource "local_file" "kubeconfig" {
  provider = local
  content  = data.mgc_kubernetes_cluster_kubeconfig.cluster.kubeconfig
  filename = "${path.module}/kubeconfig.yaml"
}
