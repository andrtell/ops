resource "digitalocean_domain" "tell-nu" {
  name = "tell.nu"
}

resource "digitalocean_vpc" "tellnet" {
  name     = "tellnet"
  region   = "ams3"
}
