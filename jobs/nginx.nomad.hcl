job "nginx" {
    # https://developer.hashicorp.com/nomad/docs/schedulers#service
    type = "service"

    group "nginx" {
        count = 1

        network { 
            port "web" {
                static = 80
            }
        }

        task "nginx" {
            driver = "docker"

            config {
                image = "nginx:1.27.2"
                # TODO: Is this the correct solution?
                network_mode = "host"
                ports = ["web"]
            }
        }
    }
}
