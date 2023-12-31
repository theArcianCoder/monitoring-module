provider "kubernetes" {
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

provider "helm" {
  kubernetes {
      exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        command     = "aws"
        args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      }
      host                   = data.aws_eks_cluster.cluster.endpoint
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "monitoring-kube-stack" {
  source         = "./terraform-module-monitoring-kube-stack"
  eks_cluster_id = data.aws_eks_cluster.cluster.endpoint
  namespace      = var.namespace
  stack_name     = var.stack_name
  cluster_name   = var.cluster_name
  mongo_db_expo_ip = var.mongo_db_expo_ip
  elasticsearch_expo_ip = var.elasticsearch_expo_ip
  az             = var.az
}
