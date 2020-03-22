data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

data "google_compute_instance" "appserver" {
    project = "${var.project_id}"
    name = "instance-1"
    zone = "us-east1-b"
}

# output "billing_account" {
#     value = "${data.google_billing_account.acct}"
# }

output "gcp_instance" {
    value = "${file("~/.ssh/gcloud_instance2.pub")}"
}