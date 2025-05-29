# Configura o provedor AWS
provider "aws" {
  region = var.aws_region
}

# Cria uma chave SSH para acesso à instância
resource "aws_key_pair" "minha_chave_ssh" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

# Cria um Security Group para a instância (define regras de firewall)
resource "aws_security_group" "minha_sg" {
  name        = "minha-sg-terraform"
  description = "Security Group para instância EC2 criada com Terraform"
  vpc_id      = var.vpc_id # Substitua pelo ID da sua VPC ou crie uma nova

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso SSH de qualquer IP (MUITO ABERTO PARA PRODUÇÃO)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso HTTP de qualquer IP (MUITO ABERTO PARA PRODUÇÃO)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permite todo o tráfego de saída
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Minha-SG-Terraform"
  }
}

# Cria a instância EC2
resource "aws_instance" "minha_instancia_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.minha_chave_ssh.key_name
  security_groups = [aws_security_group.minha_sg.name]

  # Exemplo de User Data (script que roda na primeira inicialização da instância)
  # Este script instala o Apache2 e cria uma página web simples no Ubuntu.
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Olá do Terraform!</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "Minha-Instancia-Server-Terraform"
  }
}