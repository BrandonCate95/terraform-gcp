terraform {
  backend "remote" {
    organization = "Brandon-Cate-Test-1"

    workspaces {
      name = "DEV-TEST-1"
    }
  }
}

provider "google" {
  project = "terraform-testing-1"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance"
    machine_type = "f1-micro"

    tags = ["ssh","http"]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script = "sudo apt-get update; sudo apt-get install nginx -y; sudo apt-get install openssl; mkdir ssl-certs; cd ssl-certs; openssl genrsa -out example.key 2048; openssl rsa -in example.key -out example.key; openssl req -new -key example.key -out example.csr; openssl x509 -req -days 365 -in example.csr -signkey example.key -out example.crt -subj \"/C=US/ST=Georgia/L=Atlanta/O=None/OU=None/CN=example.com\"; "

    network_interface {
        network = "${google_compute_network.vpc_network.self_link}"
        access_config {}
    }
}

resource "google_compute_firewall" "nginx-app-firewall" {
 name    = "nginx-app-firewall"
 network = "${google_compute_network.vpc_network.self_link}"

 allow {
   protocol = "tcp"
   ports    = ["80"]
 }
 target_tags = ["http"]
}

resource "google_compute_firewall" "terraform-default-ssh-firewall" {
 name    = "terraform-default-ssh-firewall"
 network = "${google_compute_network.vpc_network.self_link}"

 allow {
   protocol = "tcp"
   ports    = ["22"]
 }
 target_tags = ["ssh"]
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
    auto_create_subnetworks = "true"
}

