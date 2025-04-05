/* module "gcp_network_resources" {
  source = "../gcp_vpc_module"
}

resource "google_compute_instance_template" "private-template-1" {
    name = "private-template1"
    machine_type = "n1-standard-1"
    disk {
        source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
        boot         = true
        auto_delete  = true
    }
    network_interface {
        network = module.gcp_network_resources.network_name
        subnetwork = module.gcp_network_resources.subnet_name
    }

    //metadata = {
    //    startup-script = file(var.startup_script)
    //}

    metadata_startup_script = <<-EOF
        #! /bin/bash
        sudo apt-get update -y
        sudo apt-get install -y apache2
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo echo "Hi from GCP instances in autoscalling group created using Terraform an my hostname is $(hostname) and my IP is $(hostname -i)" > /var/www/html/index.html
    EOF
}

resource "google_compute_instance_group_manager" "private-instance-group" {
    name = "private-instance-group"
    base_instance_name = "private-instance"
    target_size = 1
    zone = "us-east1-b"
    named_port {
        name = "http"
        port = 80
    }

    version {
      instance_template = google_compute_instance_template.private-template-1.self_link
    }
}

resource "google_compute_autoscaler" "private-autoscaler" {
    name = "private-autoscaler"
    zone = "us-east1-b"
    target = google_compute_instance_group_manager.private-instance-group.self_link
    autoscaling_policy {
        max_replicas = 5
        min_replicas = 2
        cpu_utilization {
            target = 0.8
        }
    }
} */