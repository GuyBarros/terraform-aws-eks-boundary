# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "kubernetes_config_map" "boundary" {
  metadata {
    name = "boundary-config"
  }

  data = {
    "boundary.hcl" = <<EOF
disable_mlock = true

log_level = "debug"

controller {
	name = "kubernetes-controller"
	description = "A controller for a kubernetes demo!"
	database {
			url = "env://BOUNDARY_PG_URL"
	}
	public_cluster_addr = "${kubernetes_service.boundary-controller.spec.0.cluster_ip}"
	license = "${var.boundaryentlicense}"
}

worker {
	name = "default-kubernetes-worker"
	description = "A worker for a kubernetes demo"
	 controllers = ["${kubernetes_service.boundary-controller.spec.0.cluster_ip}:9201"]
	 public_addr = "${kubernetes_service.boundary-controller.status.0.load_balancer.0.ingress.0.hostname}:9202"
}

listener "tcp" {
	address = "0.0.0.0:9200"
	purpose = "api"
	tls_disable = true
}

listener "tcp" {
	address = "0.0.0.0:9201"
	purpose = "cluster"
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
	purpose = "root"
	aead_type = "aes-gcm"
	key = "sP1fnF5Xz85RrXyELHFeZg9Ad2qt4Z4bgNHVGtD6ung="
	key_id = "global_root"
}

kms "aead" {
	purpose = "worker-auth"
	aead_type = "aes-gcm"
	key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
	key_id = "global_worker-auth"
}

kms "aead" {
	purpose = "recovery"
	aead_type = "aes-gcm"
	key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
	key_id = "global_recovery"
}


EOF
  }
}