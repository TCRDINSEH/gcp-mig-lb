packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

# --- Variables ---
variable "project_id" {
  type    = string
  default = "applied-pager-476808-j5" # Set your default project ID
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "image_family" {
  type    = string
  default = "apache-base"
}

# --- Source Image ---
source "googlecompute" "apache" {
  project_id          = var.project_id
  zone                = var.zone
  source_image_family = "debian-11"
  ssh_username        = "packer"

  # --- Output Image ---
  image_name          = "apache-base-{{timestamp}}"
  image_family        = var.image_family
  image_description   = "Base Apache image with SSL enabled, built by Packer."
}

# --- Build ---
build {
  name = "build-apache-image"
  sources = [
    "source.googlecompute.apache"
  ]

  # --- Provisioner ---
  # This runs your script (with the placeholder we discussed)
  provisioner "shell" {
    inline = [
      "#!/bin/bash",
      "set -e",
      "echo 'Waiting for apt to be ready...'",
      "sleep 15",
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo a2ensite default-ssl",
      "sudo a2enmod ssl",
      "echo 'Apache installed and configured by Packer. Hostname will be added by startup-script.' | sudo tee /var/www/html/index.html",
      "sudo systemctl restart apache2"
    ]
  }
}
