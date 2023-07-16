<h1 align="center">
  <img src="https://img.icons8.com/external-soft-fill-juicy-fish/60/external-terraform-space-exploration-soft-fill-soft-fill-juicy-fish.png" alt="Terraform Logo" width="96"> 
  <br>
  Monitoring Terraform Module
</h1>

<p align="center">
  <a href="https://github.com/theArcianCoder/monitoring-module">
    <img src="https://img.icons8.com/bubbles/50/github.png" alt="GitHub Repo Icon" width="100">
  </a>
</p>

## Introduction

This Terraform module deploys and configures resources for your Kubernetes cluster using AWS EKS and Helm. It sets up the Kube Prometheus stack to enable monitoring and observability for your cluster.

<p align="center">
  <img src="https://img.icons8.com/color/48/prometheus-app.png" alt="Prometheus Stack" width="100">
  <img src="https://img.icons8.com/color/48/kubernetes.png" alt="Prometheus Stack" width="100">
  <img src="https://img.icons8.com/fluency/48/grafana.png" alt="Prometheus Stack" width="100">
  
</p>

## Prerequisites

Before using this module, ensure that you have the following prerequisites:

- An existing AWS EKS cluster
- AWS CLI and AWS IAM Authenticator configured
- Terraform installed locally
- kubectl and Helm installed locally
- AWS credentials with necessary permissions

## Usage

To use this module in your infrastructure, create a `main.tf` file and include the following code:

```terraform
module "my_kube_prometheus" {
  source           = "git::https://github.com/theArcianCoder/monitoring-module.git"
  cluster_name     = "cluster's-name"
  cluster_endpoint = "cluster's-endpoint"
  namespace        = "monitoring"
  stack_name       = "monitoring-stack"
}

output "eks_cluster_id" {
  description = "The endpoint URL of the EKS cluster."
  value       = module.my_kube_prometheus.eks_cluster_id
}

```

