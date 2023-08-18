locals {
  desired_cluster_name = var.cluster_name  # Replace with your desired cluster name

  cluster_endpoint = data.kubernetes_config.current_context.clusters[local.desired_cluster_name].cluster.server
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "cluster_endpoint" {
  description = "Cluster endpoint URL"
  default     = local.cluster_endpoint
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