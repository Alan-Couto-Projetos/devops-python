# infra/main.tf
# Define o provedor Terraform para o Google Cloud.
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
}

# Cria um bucket no Google Cloud Storage para hospedagem do site estático.
resource "google_storage_bucket" "static_site_bucket" {
  name          = "${var.gcp_project_id}-site"
  location      = "US"
  force_destroy = true

  # Habilita a hospedagem de site estático e define o arquivo principal.
  website {
    main_page_suffix = "index.html"
  }
}

# Define uma variável para o ID do projeto GCP.
variable "gcp_project_id" {
  type        = string
  description = "ID do projeto GCP onde os recursos serão criados."
}
