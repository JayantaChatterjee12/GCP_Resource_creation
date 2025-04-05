resource "google_compute_router" "router_for_nat" {
    name = "router-for-nat"
    network = google_compute_network.vpc_network.self_link
    region = var.gcp_region 
}

resource "google_compute_router_nat" "nat_gw" {
    name = "nat-gw"
    router = google_compute_router.router_for_nat.name
    region = var.gcp_region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

output "nat_gw_ip" {
    value = google_compute_router_nat.nat_gw.nat_ip_allocate_option
}