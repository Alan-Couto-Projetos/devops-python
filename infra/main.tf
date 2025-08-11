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
              apt-get update -y
              apt-get install -y python3 python3-pip git
              cd /home/ubuntu
              git clone https://github.com/Alan-Couto-Projetos/devops-python-ci
              cd devops-python-ci
              pip3 install -r requirements.txt
              python3 app/main.py > resultado.txt
              EOF
}
