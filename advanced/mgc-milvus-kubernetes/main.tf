provider "mgc" {
  region="br-ne1"
}

resource "mgc_kubernetes_cluster" "cluster" {
  provider = mgc
  name                 = var.cluster_name
  version              = var.kubernetes_version
  enabled_server_group = false
  description          = var.cluster_description
}

# Criando um nodepool
resource "mgc_kubernetes_nodepool" "gp1_medium" {
  depends_on  = [mgc_kubernetes_cluster.cluster]
  name        = "apis-4cpu-8gb-50gb"
  cluster_id  = mgc_kubernetes_cluster.cluster.id
  flavor_name = var.nodepool_flavor
  replicas    = var.nodepool_replicas
  min_replicas = var.nodepool_replicas
  max_replicas = 5
}

# Pegando o kubeconfig do cluster
data "mgc_kubernetes_cluster_kubeconfig" "cluster" {
  cluster_id = mgc_kubernetes_cluster.cluster.id
}

# Salvando o kubeconfig em um arquivo local
resource "local_file" "kubeconfig" {
  content  = data.mgc_kubernetes_cluster_kubeconfig.cluster.kubeconfig
  filename = "${path.module}/kubeconfig.yaml"
}

# Outputs
output "cluster_name" {
  value = mgc_kubernetes_cluster.cluster.name
}

output "cluster_id" {
  value = mgc_kubernetes_cluster.cluster.id
}
