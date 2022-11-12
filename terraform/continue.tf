# continue01

resource "digitalocean_droplet" "continue01" {
  image = "ubuntu-22-04-x64"
  name = "continue01"
  region = "ams3"
  size = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.tellnet.id
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]
}

# continue network

resource "digitalocean_reserved_ip" "continue01" {
  region = "ams3"
}

resource "digitalocean_record" "continue" {
  domain = digitalocean_domain.tell-nu.id
  type   = "A"
  name   = "continue"
  value  = digitalocean_reserved_ip.continue01.ip_address
}

resource "digitalocean_reserved_ip_assignment" "continue01" {
  ip_address = digitalocean_reserved_ip.continue01.ip_address
  droplet_id = digitalocean_droplet.continue01.id
}
