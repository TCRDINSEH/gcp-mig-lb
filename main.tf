terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "network" {
  source                  = "./modules/network"
  project_id              = var.project_id
  region                  = var.region
  network_name            = var.network_name
  subnetwork_name         = var.subnetwork_name
  proxy_subnetwork_name   = var.proxy_subnetwork_name
  ssh_source_ip_range     = var.ssh_source_ip_range
  health_check_target_tag = "allow-health-check" // Tag used in compute_mig
  ssh_target_tag          = "allow-ssh"          // Tag used in compute_mig
}

module "compute_mig" {
  source = "./modules/compute_mig"

  # General
  name         = "${var.name}-mig"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  target_size  = var.target_size
  network_name = module.network.network_name

  # Instance Template
  instance_machine_type = var.instance_machine_type
  image_project         = var.image_project
  image_family          = var.image_family
  subnetwork_self_link  = module.network.subnetwork_self_link
  tags = [
    "allow-health-check", // From network module
    "allow-ssh"           // From network module
  ]

  depends_on = [module.network]
}

module "load_balancer" {
  source = "./modules/load_balancer"
  project_id = var.project_id
  region     = var.region
  instance_group_self_link = module.compute_mig.instance_group_self_link

  depends_on = [module.compute_mig]
}