module "gcp_network_resources" {
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
} 



/* resource "google_compute_instance" "public-instance" {
    name = "public-instance"
    machine_type = "n1-standard-1"
    zone = "us-east1-b"
    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
        auto_delete  = true
    }
    network_interface {
        network = module.gcp_network_resources.network_name
        subnetwork = module.gcp_network_resources.public_subnet_name
        access_config {
            //nat_ip = google_compute_address.my_static_ip.address
        }
    }
} */

resource "google_compute_global_address" "static-ip" {
  name     = "lb-static-ip"
}

# http proxy
resource "google_compute_target_http_proxy" "http-proxy" {
  name     = "lb-target-http-proxy"
  url_map  = google_compute_url_map.url-map.id
}

# url map
resource "google_compute_url_map" "url-map" {
  name            = "lb-url-map"
  default_service = google_compute_backend_service.lb-backend-service.id
}

resource "google_compute_global_forwarding_rule" "lb_frontend" {
  name                  = "lb-frontend"
  target                = google_compute_target_http_proxy.http-proxy.self_link
  ip_address            = google_compute_global_address.static-ip.id
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}

//resource "google_compute_target_pool" "lb_target_pool" {
//  name = "lb-target-pool"
//  health_checks = [google_compute_http_health_check.lb_health_check.self_link]
//}

resource "google_compute_http_health_check" "lb_health_check" {
  name               = "lb-health-check"
  check_interval_sec = 1
  timeout_sec        = 1
  healthy_threshold  = 1
  unhealthy_threshold = 2
  port               = 80
  request_path       = "/"
}

resource "google_compute_backend_service" "lb-backend-service" {
  name                    = "lbbackendservice"
  protocol                = "HTTP"
  port_name               = "http-port"
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = false
  health_checks           = [google_compute_http_health_check.lb_health_check.id]
  backend {
    group           = google_compute_instance_group_manager.private-instance-group.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}