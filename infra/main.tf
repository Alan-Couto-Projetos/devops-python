# infra/main.tf

# Provedor Terraform para interagir com o Docker.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20"
    }
  }
}

provider "docker" {}

# Constrói a imagem Docker com o Dockerfile.
resource "docker_image" "python_app_image" {
  name = "python-teorema-bayes:1.0.0"
  build {
    context    = "../"
    dockerfile = "../Dockerfile"
  }
}

# Cria e executa o contêiner Docker.
resource "docker_container" "python_app_container" {
  name  = "teorema-bayes-runner"
  image = docker_image.python_app_image.name

  # O comando executado no contêiner.
  entrypoint = ["python", "devops/app/main.py"]

  # A saída do script capturada pelo Terraform.
  logs         = true
  # Saída do script enviada para o stdout.
  log_stdout   = true
}
