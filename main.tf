provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

module "gcp_autoscalling" {
  source = "./modules/gcp_autoscalling_module"
}


terraform {
  required_version = ">= 1.0"  # Replace with your Terraform version
  backend "gcs" {
    bucket = "tf_lock_file_storing_bucket_for_gcp"
    prefix  = "terraform/state"
    //region   = "your-region"   # Optional, but recommended
    # Configure your GCS credentials if not using Google Cloud IAM
  }
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