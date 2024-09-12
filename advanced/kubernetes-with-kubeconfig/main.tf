# Criando um cluster com um nodepool
resource "mgc_kubernetes_cluster" "cluster" {
  name                 = var.cluster_name
  version              = var.kubernetes_version
  enabled_server_group = false
  description          = var.cluster_description
}


# Criando um nodepool
resource "mgc_kubernetes_nodepool" "gp1_small" {
  depends_on = [mgc_kubernetes_cluster.cluster_with_nodepool]
  name       = "apis-2cpu-4gb-20gb"
  cluster_id = mgc_kubernetes_cluster.cluster_with_nodepool.id
  flavor     = var.nodepool_flavor
  replicas   = var.nodepool_replicas
  auto_scale = {
    min_replicas = 1
    max_replicas = 3
  }
}


# Pegar o kubeconfig do cluster usando o output do cluster_id
data "mgc_kubernetes_cluster_kubeconfig" "cluster" {
  depends_on = [time_sleep.wait_for_cluster]
  cluster_id = mgc_kubernetes_cluster.cluster_with_nodepool.id
}

# Salvar o kubeconfig em um arquivo local
resource "local_file" "kubeconfig" {
  provider = local
  content  = data.mgc_kubernetes_cluster_kubeconfig.cluster.kubeconfig
  filename = "${path.module}/kubeconfig.yaml"
}
