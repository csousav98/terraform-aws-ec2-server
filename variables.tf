variable "aws_region" {
  description = "Região da AWS onde os recursos serão provisionados."
  type        = string
  default     = "us-east-1" # Exemplo: Virginia - Pode mudar para 'sa-east-1' para São Paulo
}

variable "ami_id" {
  description = "ID da AMI (Amazon Machine Image) a ser usada para a instância."
  type        = string
  # Exemplo de AMI para Ubuntu Server 22.04 LTS (HVM, SSD Volume Type) na us-east-1.
  # Você DEVE buscar a AMI mais recente e correta para a sua região e SO desejado.
  # Para 'sa-east-1' (São Paulo), um exemplo de AMI de Ubuntu 22.04 pode ser 'ami-0e1d0f507b57b98a3'
  # Sempre verifique o console AWS para a AMI mais atualizada para sua região.
  default     = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "Tipo de instância EC2 (ex: t2.micro, m5.large)."
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Nome da chave SSH a ser criada na AWS."
  type        = string
  default     = "terraform-key"
}

variable "public_key_path" {
  description = "Caminho para o arquivo da chave pública SSH (.pub)."
  type        = string
  default     = "~/.ssh/id_rsa.pub" # Altere para o caminho da sua chave pública REAL
}

variable "vpc_id" {
  description = "ID da VPC onde a instância será criada."
  type        = string
  # Você pode obter este valor da sua conta AWS (Console -> VPCs -> Your VPCs)
  # ou criar uma nova VPC com Terraform (mais avançado).
  # Substitua pelo ID da sua VPC padrão ou de uma VPC existente.
  default     = "vpc-0abc123def4567890" # Exemplo. Mude para o ID da sua VPC real.
}