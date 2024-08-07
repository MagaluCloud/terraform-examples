output "cluster_name" {
  value = mgc_kubernetes_cluster.cluster_with_nodepool.name
}
output "cluster_id" {
  value = mgc_kubernetes_cluster.cluster_with_nodepool.id
}