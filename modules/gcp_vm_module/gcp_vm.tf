/* module "gcp_vpc" {
  source = "../gcp_vpc_module"
}

resource "google_compute_instance" "private-instance-1" {
  name = "private-instance1"
  machine_type = "n1-standard-1"
  zone = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = module.gcp_vpc.network_name
    subnetwork = module.gcp_vpc.subnet_name
  }
}

resource "google_compute_instance" "public-instance-1" {
  name = "public-instance1"
  machine_type = "n1-standard-1"
  zone = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = module.gcp_vpc.network_name
    subnetwork = module.gcp_vpc.subnet_name
    access_config {
      
    }
  }
} */