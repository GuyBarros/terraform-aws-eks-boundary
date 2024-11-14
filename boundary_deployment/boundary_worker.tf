# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "kubernetes_deployment" "boundary-worker" {
  timeouts {
    create = "2m"
  }
  depends_on = [kubernetes_deployment.redis, kubernetes_deployment.postgres, kubernetes_deployment.boundary]
  metadata {
    name = "boundary-worker"
    labels = {
      app = "boundary-worker"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "boundary-worker"
      }
    }

    template {
      metadata {
        labels = {
          app     = "boundary-worker"
          service = "boundary-worker"
        }
      }

      spec {
        volume {
          name = "boundary-worker-config"

          config_map {
            name = "boundary-worker-config"
          }
        }


        container {
          image = "hashicorp/boundary-enterprise:latest"
          name  = "boundary"

          volume_mount {
            name       = "boundary-worker-config"
            mount_path = "/boundary-worker"
            read_only  = true
          }
          args = [
            "server",
            "-config",
            "/boundary-worker/config.hcl"
          ]
          env {
            name  = "HOSTNAME"
            value = "boundary-worker"
          }
          port {
            container_port = 9202
            name           = "api"
          }
          port {
            container_port = 9203
            name           = "ops"
          }

          liveness_probe {
            http_get {
              path   = "/health"
              port   = "ops"
              scheme = "HTTP"
            }
            initial_delay_seconds = 5
            period_seconds        = 15
          }

          readiness_probe {
            http_get {
              path   = "/health"
              port   = "ops"
              scheme = "HTTP"
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "boundary-worker" {
  metadata {
    name = "boundary-worker"
    labels = {
      app = "boundary-worker"
    }
  }

  spec {
    type = "LoadBalancer"
    selector = {
      app = "boundary-worker"
    }

    port {
      name        = "api"
      port        = 9202
      target_port = 9202
    }
    port {
      name        = "ops"
      port        = 9203
      target_port = 9203
    }
  }
}

resource "kubernetes_service" "boundary-worker-internal" {
  metadata {
    name = "boundary-worker-internal"
    labels = {
      app = "boundary-worker"
    }
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "boundary-worker"
    }

    port {
      name        = "api"
      port        = 9202
      target_port = 9202
    }
    port {
      name        = "ops"
      port        = 9203
      target_port = 9203
    }
  }
}
