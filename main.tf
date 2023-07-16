provider "kubernetes" {
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "kube_prometheus" {
  source         = "git::https://github.com/theArcianCoder/terraform-module-kube-prometheus.git"
  eks_cluster_id = var.cluster_endpoint
  namespace      = var.namespace
  stack_name     = var.stack_name
}

output "eks_cluster_id" {
  description = "The endpoint URL of the EKS cluster."
  value       = data.aws_eks_cluster.cluster.endpoint
}