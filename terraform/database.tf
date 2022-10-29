resource "digitalocean_database_cluster" "db" {
  name       = "db"
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  private_network_uuid = digitalocean_vpc.tellnet.id
  node_count = 1
}
