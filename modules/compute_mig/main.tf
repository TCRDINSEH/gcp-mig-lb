# --- 1. Template creation with Apache image ---
resource "google_compute_instance_template" "default" {
  name    = "${var.name}-template"
  project = var.project_id
  region  = var.region
  disk {
    auto_delete  = true
    boot         = true
    device_name  = "persistent-disk-0"
    mode         = "READ_WRITE"
    source_image = "projects/${var.image_project}/global/images/family/${var.image_family}"
    type         = "PERSISTENT"
  }
  labels = {
    managed-by-cnrm = "true"
  }
  machine_type = var.instance_machine_type
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    network    = "projects/${var.project_id}/global/networks/${var.network_name}"
    subnetwork = var.subnetwork_self_link
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }
  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }
  tags = var.tags
}

# --- 2. Health Check (for Auto-healing) ---
# This checks if the Apache server is responding
resource "google_compute_health_check" "apache_http_check" {
  name    = "${var.name}-http-health-check"
  project = var.project_id

  timeout_sec        = 5
  check_interval_sec = 10

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

# --- 3. Managed Instance Group (with Auto-healing) ---
resource "google_compute_instance_group_manager" "default" {
  name    = "${var.name}-mig"
  zone    = var.zone
  project = var.project_id

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }

  base_instance_name = "apache-vm"

  # ADDED: Auto-healing policy
  auto_healing_policies {
    health_check      = google_compute_health_check.apache_http_check.id
    initial_delay_sec = 300 # Give 5 mins for startup
  }
}

# --- 5. Autoscaler (for Autoscaling) ---
# This automatically adds/removes VMs based on load
resource "google_compute_autoscaler" "apache_autoscaler" {
  name    = "${var.name}-autoscaler"
  zone    = var.zone
  project = var.project_id

  # Point the autoscaler at the MIG
  target = google_compute_instance_group_manager.default.id

  # Define the scaling policy
  autoscaling_policy {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    # Scale up if CPU is over 60%
    cpu_utilization {
      target = var.cpu_target
    }

    # Time before scaling down
    cooldown_period = 60
  }
}



