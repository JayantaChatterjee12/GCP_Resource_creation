//module "gcp_website" {
//  source = "./modules/gcp_storage_website"
//}

//module "gcp_autoscalling" {
//  source = "./modules/gcp_autoscalling_module"}

module "gcp_vm" {
  source = "./modules/gcp_vm_module"
}

//module "gcp_vpc" {
//  source = "./modules/gcp_vpc_module"
//}