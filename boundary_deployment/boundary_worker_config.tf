# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "kubernetes_config_map" "boundary-worker" {
  metadata {
    name = "boundary-worker-config"
  }

  data = {
    "config.hcl" = <<EOF
disable_mlock = true

log_level = "debug"


worker {
	name = "kubernetes-worker"
	 description = "A worker for a kubernetes demo"
	initial_upstreams = ["${kubernetes_service.boundary-controller.spec.0.cluster_ip}:9201"]
	# initial_upstreams = ["${kubernetes_service.boundary-controller.status.0.load_balancer.0.ingress.0.hostname}:9201"]
	# initial_upstreams = ["${kubernetes_service.boundary-controller-internal.spec.0.cluster_ip}:9201"]
	# public_addr = "localhost"
	public_addr = "${kubernetes_service.boundary-worker.status.0.load_balancer.0.ingress.0.hostname}:9202"
	# auth_storage_path = "/boundary/file/boundary-worker"
}


listener "tcp" {
	address = "0.0.0.0:9202"
	purpose = "proxy"
}

listener "tcp" {
	address = "0.0.0.0:9203"
	purpose = "ops"
	tls_disable = true
}

kms "aead" {
	purpose = "worker-auth"
	aead_type = "aes-gcm"
	key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
	key_id = "global_worker-auth"
}




EOF
  }
}