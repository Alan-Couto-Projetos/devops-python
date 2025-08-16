#infra\main.tf
provider "aws" {
  region                  = var.aws_region
  access_key              = var.aws_access_key
  secret_key              = var.aws_secret_key
  token                   = var.aws_session_token
}

resource "aws_instance" "teorema_bayes_ec2" {
  ami                         = "ami-0c02fb55956c7d316" # Ubuntu 22.04 LTS us-east-1
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "TeoremaBayesInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e  # O 'set -e' faz o script parar em caso de erro

              # Log de inicialização para depuração
              echo "Iniciando script user_data" > /tmp/user_data.log

              # Atualiza os pacotes e instala as dependências
              apt-get update -y
              apt-get install -y python3 python3-pip git
              echo "Dependências instaladas." >> /tmp/user_data.log

              # Navega para o diretório de destino e clona o repositório
              cd /home/ubuntu
              git clone https://github.com/Alan-Couto-Projetos/devops-python
              echo "Repositório clonado." >> /tmp/user_data.log

              # Navega para o diretório do repositório
              cd devops-python
              
              # Instala as dependências do Python
              pip3 install -r requirements.txt
              echo "Dependências do Python instaladas." >> /tmp/user_data.log

              # Executa o script Python
              python3 app/main.py > resultado.txt
              echo "Script Python executado com sucesso." >> /tmp/user_data.log

              echo "Script user_data finalizado." >> /tmp/user_data.log
              EOF
}

