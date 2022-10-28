# registry01

resource "digitalocean_droplet" "registry01" {
  image = "ubuntu-22-04-x64"
  name = "registry01"
  region = "ams3"
  size = "s-1vcpu-1gb"
  vpc_uuid = digitalocean_vpc.tellnet.id
  ssh_keys = [
    data.digitalocean_ssh_key.default.id
  ]
}

# registry network

resource "digitalocean_record" "registry" {
  domain = digitalocean_domain.tell-nu.id
  type   = "A"
  name   = "registry"
  value  = digitalocean_reserved_ip.registry01.ip_address
}

resource "digitalocean_reserved_ip" "registry01" {
  region = "ams3"
}

resource "digitalocean_reserved_ip_assignment" "registry01" {
  ip_address = digitalocean_reserved_ip.registry01.ip_address
  droplet_id = digitalocean_droplet.registry01.id
}

# registry volume

resource "digitalocean_volume" "registry01" {
  region                   = "ams3"
  name                     = "registry"
  size                     = 50
  initial_filesystem_type  = "ext4"
  initial_filesystem_label = "registry"
  description              = "registry01 volume"
}

resource "digitalocean_volume_attachment" "registry01" {
  droplet_id = digitalocean_droplet.registry01.id
  volume_id  = digitalocean_volume.registry01.id
}
