/*module "gcp_storage" {
  source = "../gcp_storage_module"
}

resource "google_storage_bucket_object" "static_website" {
  name = "index.html"
  source = "website-files/index.html"
  bucket = module.gcp_storage.bucket_name
}

resource "google_storage_object_access_control" "object_public" {
    object = google_storage_bucket_object.static_website.name
    bucket = module.gcp_storage.bucket_name
    role = "READER"
    entity = "allUsers"
}*/