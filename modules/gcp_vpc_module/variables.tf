variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default = "my-firstworking-vpc"
}

variable "ip_cidr_range" {
  description = "The IP CIDR range of the VPC"
  type        = string
  default = "10.0.0.0/24"
}

variable "gcp_region" {
  description = "The GCP region"
  type        = string
  default = "us-east1"
}