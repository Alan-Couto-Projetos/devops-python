# infra/main.tf
# Define o provedor Terraform para interagir com o Docker.
# Isso remove a dependência da AWS.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20"
    }
  }
}

provider "docker" {}

# Recurso para construir a imagem Docker a partir do Dockerfile.
# Ele usa o contexto do diretório atual.
resource "docker_image" "python_app_image" {
  name         = "python-teorema-bayes:1.0.0"
  build {
    context    = "../" # O caminho para o diretório que contém o Dockerfile.
    dockerfile = "../Dockerfile"
    tag        = ["python-teorema-bayes:1.0.0"]
  }
}

# Recurso para criar e executar o contêiner Docker.
# O Terraform vai gerenciar o ciclo de vida do contêiner.
resource "docker_container" "python_app_container" {
  image = docker_image.python_app_image.name
  name  = "teorema-bayes-runner"

  # O comando para ser executado no contêiner.
  # Ele roda o script Python e exibe o resultado.
  # O Terraform captura a saída para o terminal.
  entrypoint = ["python", "devops/app/main.py"]

  # Remove o contêiner automaticamente quando a execução termina.
  # Isso garante a limpeza do ambiente.
  rm = true
}

# infra/outputs.tf
# Agora, não precisamos de um IP, mas podemos capturar a saída
# do contêiner para ter um output.
# No entanto, a execução do 'apply' já exibirá a saída do script,
# então um output explícito é opcional.

# infra/variables.tf
# Como não usamos a AWS, não precisamos mais das variáveis de acesso.
# Este arquivo pode ser removido, pois o provedor Docker não requer variáveis
# externas.