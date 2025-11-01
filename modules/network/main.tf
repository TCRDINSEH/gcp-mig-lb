resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnetwork_name
  project       = var.project_id
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "proxy_only_subnetwork" {
  name          = var.proxy_subnetwork_name
  project       = var.project_id
  ip_cidr_range = "10.10.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_firewall" "allow_health_check" {
  name      = "fw-allow-health-check"
  project   = var.project_id
  direction = "INGRESS"
  network   = google_compute_network.vpc_network.id
  priority  = 1000
  // Source ranges for GCP health checkers
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.health_check_target_tag]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name      = "fw-allow-ssh"
  project   = var.project_id
  direction = "INGRESS"
  network   = google_compute_network.vpc_network.id
  priority  = 1000
  // Source ranges from variable
  source_ranges = var.ssh_source_ip_range
  target_tags   = [var.ssh_target_tag]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}