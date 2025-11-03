project_id            = "applied-pager-476808-j5"
region                = "us-central1"
zone                  = "us-central1-c"
network_name          = "apache-mig-network"
subnetwork_name       = "apache-mig-subnetwork"
proxy_subnetwork_name = "apache-mig-proxy-subnet"
ssh_source_ip_range   = ["0.0.0.0/0"]
target_size           = 2
instance_machine_type = "e2-micro"
image_family          = "apache-base"
image_project         = "applied-pager-476808-j5"
credentials_file      = ""
name                  = "apache"

