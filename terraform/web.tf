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

# web network

resource "digitalocean_reserved_ip" "web01" {
  region = "ams3"
}

resource "digitalocean_record" "web" {
  domain = digitalocean_domain.tell-nu.id
  type   = "A"
  name   = "@"
  value  = digitalocean_reserved_ip.web01.ip_address
}

resource "digitalocean_reserved_ip_assignment" "web01" {
  ip_address = digitalocean_reserved_ip.web01.ip_address
  droplet_id = digitalocean_droplet.web01.id
}
