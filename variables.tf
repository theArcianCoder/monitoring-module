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