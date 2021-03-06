variable "project_name" {
    type = "string"
    default = "cate95-tf"
} /* cate95-tf */
variable "billing_account" {
    type = "string"
    default = "01DA1E-2FB8F6-1B4AD4"
} /* 01DA1E-2FB8F6-1B4AD4 */
variable "org_id" {
    default = 0
} /* 0 */
variable "region" {
    type = "string"
    default = "us-central1"
} /* us-central1 */

provider "google" {
  region = "${var.region}"
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name}-"
}

resource "google_project" "project" {
  name            = "${var.project_name}"
  project_id      = "${random_id.id.hex}"
  billing_account = "${var.billing_account}"
  /* org_id          = "${var.org_id}" */
}

resource "google_project_services" "project" {
  project = "${google_project.project.project_id}"
  services = [
    "compute.googleapis.com"
  ]
}

output "project_id" {
  value = "${google_project.project.project_id}"
}
