output "boundary-controller"{
    value = "http://${kubernetes_service.boundary-controller.status.0.load_balancer.0.ingress.0.hostname}:9200"
}

output "boundary-controller-internal"{
    value = "internal controller: ${kubernetes_service.boundary-controller-internal.spec.0.cluster_ip}"
}
output "connect_to_Bounday" {
    value = <<EOF
        to connect to boundary, first get the dynamically generate admin password from kubectl
        aws eks --region ${var.region}  update-kubeconfig --name ${var.cluster_name}
        kubectl logs -l app=boundary -c boundary-init --tail=200 | grep "Password:"
    EOF
  
}

# output "boundary-worker"{
#     value = "${kubernetes_service.boundary-worker.status.0.load_balancer.0.ingress.0.hostname}:9201"
# }

