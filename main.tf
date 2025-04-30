provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

terraform {
  required_version = ">= 1.0" # Replace with your Terraform version
  backend "gcs" {
    bucket = "this-is-jayanta-bucket-for-testing"
    prefix = "terraform/state"
  }
}

module "gcp_autoscalling" {
  source = "./modules/gcp_autoscalling_module"
}

//module "gcp_vm" {
//  source = "./modules/gcp_vm_module"
//}

//module "gcp_vpc" {
//  source = "./modules/gcp_vpc_module"
//}

//module "gcp_website" {
//  source = "./modules/gcp_storage_website"
//}