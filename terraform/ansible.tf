resource "local_file" "inventory" {
  content = <<_EOT
continue01  ansible_host=${digitalocean_droplet.continue01.ipv4_address}
registry01  ansible_host=${digitalocean_droplet.registry01.ipv4_address}
web01       ansible_host=${digitalocean_droplet.web01.ipv4_address}

[web]
web01

[registry]
registry01

[continue]
continue01

[terraform]
web01
registry01
continue01

_EOT
  filename = "../ansible/inventory"
  file_permission = "0644"
}

resource "local_file" "hosts" {
  content = <<EOT
127.0.0.1   localhost.localdomain	localhost
::1         localhost.localdomain	localhost ip6-localhost
${digitalocean_droplet.web01.ipv4_address_private} web01
${digitalocean_droplet.registry01.ipv4_address_private} registry01
${digitalocean_droplet.continue01.ipv4_address_private} continue01
EOT
  filename = "../ansible/roles/terraform/files/hosts"
  file_permission = "0644"
}

resource "local_file" "terraform_group_vars" {
  content = <<EOT
---
private_vpc_ip_range: ${digitalocean_vpc.tellnet.ip_range}
EOT
  filename = "../ansible/group_vars/terraform.yml"
  file_permission = "0644"
}
