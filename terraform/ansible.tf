resource "local_file" "inventory" {
  content = <<_EOT
[web]
web01 ansible_host=${digitalocean_droplet.web01.ipv4_address}

[registry]
registry01 ansible_host=${digitalocean_droplet.registry01.ipv4_address}

[builder]
builder01 ansible_host=${digitalocean_droplet.builder01.ipv4_address}
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
${digitalocean_droplet.builder01.ipv4_address_private} builder01
EOT
  filename = "../ansible/roles/common-files/files/hosts"
  file_permission = "0644"
}
