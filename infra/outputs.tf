# infra/outputs.tf
# Este arquivo captura a saída do contêiner para que ela seja exibida
# nos logs do Terraform.
output "container_logs" {
  description = "Logs de saída do contêiner."
  value       = docker_container.python_app_container.logs
}
