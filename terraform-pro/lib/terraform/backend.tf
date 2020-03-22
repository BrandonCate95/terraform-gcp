terraform {
  backend "gcs" {
    bucket = "cate95-tf"
    prefix = "terraform/state"
  }
}
