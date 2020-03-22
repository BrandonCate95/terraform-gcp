terraform {
  backend "gcs" {
    bucket = "image-storage-3"
    prefix = "terraform/state"
  }
}
