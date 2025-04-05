resource "google_compute_firewall" "firewall_for_private_instances" {
    name    = "firewall-for-private-instances"
    network = google_compute_network.vpc_network.self_link
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
    source_ranges = ["0.0.0.0/0"] 
}