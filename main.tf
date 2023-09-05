terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "kubernetes" {
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}


provider "kubectl" {  
  host = module.eks_cluster.cluster_endpoint  
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)  
  exec {    
    api_version = "client.authentication.k8s.io/v1beta1"    
    command     = "aws"    
    args = ["eks", "get-token", "--cluster-name", local.workspace.eks_cluster.name,"--role-arn" ,"arn:aws:iam::${local.workspace.aws.account_id}:role/${local.workspace.aws.role}" ]  
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
  eks_cluster_id = data.aws_eks_cluster.cluster.endpoint
  namespace      = var.namespace
  stack_name     = var.stack_name
  ebs_volume_id  = var.ebs_volume_id
}
