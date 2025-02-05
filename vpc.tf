resource "digitalocean_vpc" "custom_vpc" {
  count       = length(data.digitalocean_vpc.existing_vpc.id) > 0 ? 0 : 1
  name        = var.vpc_name
  region      = var.region
  description = "Custom VPC for secure networking"
  ip_range    = var.vpc_ip_rang
}

