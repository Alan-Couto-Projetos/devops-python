# infra/main.tf
# Define o provedor Terraform para interagir com o Docker.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20"
    }
  }
}

provider "docker" {}

# Constrói a imagem Docker a partir do Dockerfile na raiz do projeto.
# O Terraform gerencia o ciclo de vida dessa imagem.
resource "docker_image" "python_app_image" {
  name = "python-teorema-bayes:1.0.0"
  build {
    context    = "../"
    dockerfile = "../Dockerfile"
  }
}

# Cria e executa o contêiner Docker a partir da imagem.
# A flag 'rm = true' foi removida para permitir que o Terraform gerencie
# o estado do contêiner e capture sua saída.
resource "docker_container" "python_app_container" {
  name  = "teorema-bayes-runner"
  image = docker_image.python_app_image.name

  # O comando que será executado no contêiner.
  entrypoint = ["python", "devops/app/main.py"]

  # A saída do script será capturada pelo Terraform.
  logs         = true
  # Garante que a saída do script seja enviada para o stdout (saída padrão).
  log_stdout   = true
}
