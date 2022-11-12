# builder01

# resource "digitalocean_droplet" "builder01" {
#   image = "ubuntu-22-04-x64"
#   name = "builder01"
#   region = "ams3"
#   size = "s-1vcpu-1gb"
#   vpc_uuid = digitalocean_vpc.tellnet.id
#   ssh_keys = [
#     data.digitalocean_ssh_key.default.id
#   ]
# }

# builder network

# resource "digitalocean_reserved_ip" "builder01" {
#   region = "ams3"
# }

# resource "digitalocean_record" "builder" {
#   domain = digitalocean_domain.tell-nu.id
#   type   = "A"
#   name   = "builder"
#   value  = digitalocean_reserved_ip.builder01.ip_address
# }

# resource "digitalocean_reserved_ip_assignment" "builder01" {
#   ip_address = digitalocean_reserved_ip.builder01.ip_address
#   droplet_id = digitalocean_droplet.builder01.id
# }
