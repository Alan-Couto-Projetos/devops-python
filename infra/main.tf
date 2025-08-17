provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  token                       = var.aws_session_token
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
              set -e

              # Atualiza os pacotes e instala as dependências como root
              apt-get update -y
              apt-get install -y python3 python3-pip git
                          
              # Cria um diretório de trabalho no diretório temporário
              cd /tmp
                          
              # Clona o repositório como root
              git clone https://github.com/Alan-Couto-Projetos/devops-python
                          
              # Instala as dependências do Python
              pip3 install -r devops-python/requirements.txt
                          
              # Executa o script Python com o caminho corrigido
              python3 devops-python/devops/app/main.py > /tmp/resultado.txt
                          
              # (Opcional) Limpa os arquivos temporários após a execução
              rm -rf devops-python
EOF
}