variable "cluster_name" {
  type = string
  description = "the EKS cluster name where Boundary will be deployed to"

}


variable "region" {
  type = string
  description = "The AWS region where the EKS cluster is deployed to"
  default = "eu-west-2"
}

variable "boundaryentlicense" {
  description = "Enterprise License for Boundary"
  type = string
}
