variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "cluster_endpoint" {
  description = "Endpoint URL of the EKS cluster"
}

variable "namespace" {
  description = "Namespace for the Helm release"
}

variable "stack_name" {
  description = "Name of the Helm release stack"
}

variable "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  default     = data.kubernetes_config.current_context.clusters[var.cluster_name].cluster.server
}