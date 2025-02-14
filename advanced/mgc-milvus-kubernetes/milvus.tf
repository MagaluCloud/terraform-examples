provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig.yaml"
  }
  experiments {
    manifest = true
  }
}

resource "helm_release" "milvus" {
  name       = "milvus"
  repository = "https://zilliztech.github.io/milvus-helm/"
  chart      = "milvus"

  depends_on = [ resource.mgc_kubernetes_nodepool.gp1_medium, data.mgc_kubernetes_cluster_kubeconfig.cluster ]

  values = [file("values.yaml")] # Referencia o arquivo
}
