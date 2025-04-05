resource "google_compute_network" "vpc_network" {
    name                    = var.vpc_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
    name          = "my-firstworking-subnet"
    ip_cidr_range = var.ip_cidr_range
    network = google_compute_network.vpc_network.self_link
    region = var.gcp_region
}

output "network_name" {
    value = google_compute_network.vpc_network.name
}

output "subnet_name" {
    value = google_compute_subnetwork.vpc_subnet.name 
}