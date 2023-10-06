variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "namespace" {
  description = "Namespace for the Helm release"
}

variable "stack_name" {
  description = "Name of the Helm release stack"
}
variable "ebs_volume_id1" {
  description = "The ID of the ebs volume."
}
variable "ebs_volume_id2" {
  description = "The ID of the ebs volume for grafana."
}
variable "mongo_db_expo_ip" {
  description = "The first target IP and port"
  default     = "18.236.158.154:9114"
}

variable "elasticsearch_expo_ip" {
  description = "The second target IP and port"
  default     = "18.236.158.154:9216"
}
variable "az" {
  description = "Value of the az for the prometheus pod to be deployed in"
}
