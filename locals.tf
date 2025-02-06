locals {
  droplet_name = "${var.droplet_name}-${var.droplet_count}"
  vpc_uuid     = length(data.digitalocean_vpc.existing_vpc.id) > 0 ? data.digitalocean_vpc.existing_vpc.id : digitalocean_vpc.custom_vpc[0].id
  ssh_key_id   = [for key in data.digitalocean_ssh_keys.existing_keys.ssh_keys : key.id if key.name == var.existing_ssh_key_name]
  tags         = ["bot", "bot-sol-client-${var.droplet_count}", "sol"]
}
