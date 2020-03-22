data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "project" {
  name            = "${var.project_name}"
  project_id      = "${var.project_id}"
  billing_account = "${data.google_billing_account.acct.id}"
  labels = "${var.project_labels}"
}

resource "google_project_services" "project" {
  project = "${google_project.project.id}"
  services   = ["storage-api.googleapis.com"]
}

resource "google_storage_bucket" "image-store" {
  name     = "${var.gcs_name}"
  location = "${var.gcs_location}"
  project  = "${google_project.project.id}"

  versioning {
    enabled = "true"
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}