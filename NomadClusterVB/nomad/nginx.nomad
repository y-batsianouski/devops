job "nginx-loadbalancer" {
  region      = "global"
  datacenters = ["nomad"]
  type        = "service"
  constraint {
    attribute = "${node.class}"
    value     = "public"
  }

  group "server" {

    task "nginx" {

      driver = "docker"

      config {
        load = "/opt/nginx/nginx-lb.tar"
        image = "nginx"
        dns_servers = ["192.168.33.11", "192.168.33.12", "192.168.33.13"]
      }

      service {
        tags = ["http"]
        port = "https"

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      env {
        NGINX_HOST="nomad.local"
      }

      resources {

        network {
          port "http" {
            static = 80
          }
          port "https" {
            static = 443
          }
        }
      }
    }
  }
}