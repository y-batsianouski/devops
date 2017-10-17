job "hashi-ui" {
  region      = "global"
  datacenters = ["nomad"]
  type        = "service"

  constraint {
    attribute = "${attr.unique.hostname}"
  }

  group "server" {
    count = 1

    task "hashi-ui" {
      driver = "docker"

      artifact {
        source      = "file://hashi-ui.tar"
      }

      config {  
        load = ["hashi-ui.tar"]
        image = "hashi-ui"
      }

      service {
        port = "http"

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      env {
        NOMAD_ENABLE = 1
        NOMAD_ADDR   = "http://http.nomad.service.consul:4646"

        CONSUL_ENABLE = 1
        CONSUL_ADDR   = "consul.service.consul:8501"
      }

      resources {
        cpu    = 500
        memory = 512

        network {
          mbits = 5

          port "http" {
            static = 3000
          }
        }
      }
    }
  }
}