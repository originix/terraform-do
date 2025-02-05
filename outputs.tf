output "vpc_uuid" {
  value = local.vpc_uuid
}

output "ipv4_address" {
  value = digitalocean_droplet.bot.ipv4_address
}

output "ipv6_address" {
  value = digitalocean_droplet.bot.ipv6_address
}

output "droplet_name" {
  value = local.droplet_name
}
