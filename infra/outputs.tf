# infra/outputs.tf
# Exibe a URL do bucket como um output do Terraform.
output "site_url" {
  description = "URL do site estático hospedado no bucket GCS."
  value       = "http://storage.googleapis.com/${google_storage_bucket.static_site_bucket.name}/index.html"
}
