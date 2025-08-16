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
              
              # Troca para o usuário 'ubuntu' para operações de clonagem e execução
              # isso garante as permissões corretas
              su - ubuntu -c "
                echo 'Iniciando script user_data' > /home/ubuntu/user_data.log
                
                # Navega para o diretório de usuário
                cd /home/ubuntu
                
                # Clona o repositório e instala dependências
                git clone https://github.com/Alan-Couto-Projetos/devops-python
                echo 'Repositório clonado.' >> /home/ubuntu/user_data.log
                
                cd devops-python
                
                pip3 install -r requirements.txt
                echo 'Dependências do Python instaladas.' >> /home/ubuntu/user_data.log
                
                # Executa o script Python
                python3 devops/app/main.py > resultado.txt
                echo 'Script Python executado com sucesso.' >> /home/ubuntu/user_data.log
              "
              
              echo "Script user_data finalizado com sucesso." >> /home/ubuntu/user_data.log
              EOF
}