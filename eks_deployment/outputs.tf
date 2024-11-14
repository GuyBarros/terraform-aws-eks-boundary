output "kubernetes-cluster"{
    value = aws_eks_cluster.eks.endpoint
}

output "kubernetes-cluster-name"{
    value = aws_eks_cluster.eks.name
}