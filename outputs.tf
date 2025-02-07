output "vpc_uuid" {
  value = local.vpc_uuid
}

output "ipv4_address" {
  value = try(digitalocean_droplet.bot[0].ipv4_address, vultr_instance.my_instance[0].main_ip)
}

output "ipv6_address" {
  value = try(digitalocean_droplet.bot[0].ipv6_address, vultr_instance.my_instance[0].v6_main_ip)
}

output "droplet_name" {
  value = local.droplet_name
}
