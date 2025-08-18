# Exibe a localização do arquivo simulado como a URL do site.
output "site_url" {
  description = "A localização do site implantado no ambiente simulado."
  value       = local_file.simulated_static_site.filename
}