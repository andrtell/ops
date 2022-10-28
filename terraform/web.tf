# web01

resource "digitalocean_droplet" "web01" {
  image = "ubuntu-22-04-x64"
  name = "web01"
  region = "ams3"
  size = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.tellnet.id
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]
}

# web load-balancer

resource "digitalocean_loadbalancer" "public" {
  name   = "loadbalancer01"
  region = "ams3"

  vpc_uuid = digitalocean_vpc.tellnet.id

  redirect_http_to_https = false

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 443
    target_protocol = "https"

    tls_passthrough = true
  }

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.web01.id]
}
