variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "milvus-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "v1.30.2"
}

variable "cluster_description" {
  description = "Cluster description"
  type        = string
  default     = "A Kubernetes cluster to deploy milvus."
}

variable "nodepool_name" {
  description = "Nodepool name"
  type        = string
  default     = "milvus"
}

variable "nodepool_replicas" {
  description = "Number of nodepool replicas"
  type        = number
  default     = 3
}

variable "nodepool_flavor" {
  description = "Nodepool flavor"
  type        = string
  default     = "cloud-k8s.gp1.medium"
}
