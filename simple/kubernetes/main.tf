terraform {
  required_providers {
    mgc = {
      source = "registry.terraform.io/magalucloud/mgc"
    }
  }
}

# Create a Cluster with nodepool
resource "mgc_kubernetes_cluster" "cluster" {
  name                 = "cluster-example"
  version              = "v1.28.5"
  enabled_server_group = false
  description          = "Cluster Example"
}


# Create a Nodepool
resource "mgc_kubernetes_nodepool" "gp1_small" {
  depends_on = [ mgc_kubernetes_cluster.cluster ]
  name       = "apis-2cpu-4gb-20gb"
  cluster_id = mgc_kubernetes_cluster.cluster.id
  flavor_name     = "cloud-k8s.gp1.small"
  replicas   = 1
  min_replicas = 1
  max_replicas = 3
}


