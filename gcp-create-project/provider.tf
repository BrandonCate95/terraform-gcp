provider "google" {
  /* credentials = "${file("terraform.json")}" */
  project = "${var.project_name}"
  region  = "${var.project_region}"
  zone    = "${var.project_zone}"
}