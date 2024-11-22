
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name            = var.namespace
    terraform      = true
    purpose        = "SE Boundary Test"
  }
}

variable "region" {
  description = "The region to create resources."
  default     = "eu-west-2"
}

variable "namespace" {
  description = <<EOH
this is the differantiates different this deployment on the same subscription, every cluster should have a different value
EOH
  default     = "boundaryexample"
}

variable "instance_type_worker" {
  description = "The type(size) of data workers (consul, nomad, etc)."
  default     = "t4g.xlarge"
}

variable "vpc_cidr_block" {
  description = "The top-level CIDR block for the VPC."
  default     = "10.1.0.0/16"
}

variable "cidr_blocks" {
  description = "The CIDR blocks to create the workstations in."
  default     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

variable "host_access_ip" {
  description = "CIDR blocks allowed to connect via SSH on port 22"
  default     = []
}

variable "public_key" {
  description = "The contents of the SSH public key to use for connecting to the cluster."
}

variable "boundaryentlicense" {
  description = "Enterprise License for Boundary"
  default     = ""
}
