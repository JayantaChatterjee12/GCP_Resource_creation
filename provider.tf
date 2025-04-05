provider "google" {
  //credentials = file(var.conection-file-name)
  project = var.gcp_project
  region  = var.gcp_region
}
