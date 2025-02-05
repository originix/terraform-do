data "digitalocean_project" "name" {
  name = var.project_name
}

resource "digitalocean_project_resources" "proj" {
  project = data.digitalocean_project.name.id
  resources = [
    digitalocean_droplet.bot.urn
  ]
}

resource "digitalocean_droplet" "bot" {
  vpc_uuid   = local.vpc_uuid
  name       = local.droplet_name
  region     = var.region
  size       = var.droplet_size
  image      = var.image
  ipv6       = var.enable_ipv6
  monitoring = var.enable_monitoring
  ssh_keys   = local.ssh_key_id
  tags       = local.tags

  user_data = <<-EOF
    #!/bin/bash
    set -e

    if ! id "solarbx" &>/dev/null; then
      useradd -m -s /bin/bash solarbx
    fi

    mkdir -p /home/solarbx/.ssh
    chmod 700 /home/solarbx/.ssh

    echo "${file(var.solarbx_ssh_key_path)}" > /home/solarbx/.ssh/authorized_keys
    chown -R solarbx:solarbx /home/solarbx/.ssh
    chmod 600 /home/solarbx/.ssh/authorized_keys

    # Disable password login for solarbx user
    # echo "solarbx ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/solarbx
    # chmod 440 /etc/sudoers.d/solarbx
  EOF

}

resource "digitalocean_firewall" "firewall" {
  count = var.create_firewall
  name  = var.firewall_name
  # droplet_ids = [digitalocean_droplet.bot.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.firewall_port_22
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  tags = local.tags
}
