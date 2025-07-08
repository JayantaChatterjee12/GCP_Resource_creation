# Basic sample GCP_Resource_creation with Terraform with Github action

 A basic terraform file will trigger to create GCP resources on Push action, when any changes pushed in github main branch. 
 This proverss follows the CI/ CD process of applying terraform for creating resources in GCP cloud

# 🚀 GCP Resource Deployment using GitHub Actions

This repository provides a simple example of how to automate GCP resource creation using GitHub Actions and Terraform.

## 🔧 Project Structure

```bash
.
├── .github
│   └── workflows
│       └── terraform.yml         # GitHub Actions workflow
├── terraform
│   ├── main.tf                # Terraform config file
│   ├── variables.tf           # Input variables
└── README.md

To follow DevSecOps process, used "Github Secrets" for authentiation

To use the project, need to update the Github Secrets with your own credentials and create and update the main.tf file with a new GCP Storage bucket for storing remote state file of Terraform.
