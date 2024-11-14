# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


data "aws_eks_cluster" "demo_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "demo_cluster" {
  name = var.cluster_name
}




# # Use a null_resource to trigger log fetching
# resource "null_resource" "get_logs" {
#   depends_on = [kubernetes_deployment.redis, kubernetes_deployment.postgres, kubernetes_deployment.boundary, kubernetes_deployment.boundary-worker]
#   provisioner "local-exec" {
#     command = "kubectl logs -l app=boundary -c boundary-init --tail=200 | grep \"Password:\""
#   }
# }


