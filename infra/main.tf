# Define o provedor 'local' para gerenciar arquivos, agindo como um substituto
# para um provedor de nuvem real.
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

# Cria um arquivo simulado para representar o site estático.
resource "local_file" "simulated_static_site" {
  filename = "dist/index.html"
  content  = "<html><body><h1>Site Fictício Implantado</h1></body></html>"
}

# Define uma variável de entrada que pode ser usada para simular o ID do projeto.
variable "project_id" {
  type        = string
  description = "Um ID de projeto fictício para o ambiente simulado."
  default     = "projeto-calculadora-bayes-simulado"
}