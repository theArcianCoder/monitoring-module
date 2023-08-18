output "eks_cluster_id" {
  description = "The endpoint URL of the EKS cluster."
  value       = data.aws_eks_cluster.cluster.endpoint
}
