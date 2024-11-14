provider "aws" {
  region = var.region
}

provider "kubernetes" {
 # config_context_cluster = "arn:aws:eks:eu-west-2:958215610051:cluster/guystack1-eks"
 # config_path            = "~/.kube/config"
 host                   = data.aws_eks_cluster.demo_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.demo_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
  }
}