data "digitalocean_ssh_keys" "existing_keys" {}
data "digitalocean_vpc" "existing_vpc" {
  name = var.vpc_name
}