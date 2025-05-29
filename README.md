# Projeto Terraform: Criação de Instância EC2 (Máquina Virtual) na AWS

Este projeto Terraform provisiona uma máquina virtual (instância EC2) na Amazon Web Services (AWS) usando uma imagem de servidor (AMI) e configura um Security Group para permitir acesso SSH e HTTP.

## 🚀 Funcionalidades

* Criação de uma instância EC2.
* Associação de uma chave SSH para acesso seguro.
* Criação e configuração de um Security Group para controle de tráfego (portas 22 e 80 abertas).
* Execução de um script de inicialização (`user_data`) para instalar um servidor web Apache básico e uma página de teste.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter o seguinte instalado e configurado:

1.  **Terraform:**
    * Instale o Terraform (versão 1.x.x ou superior).
    * No Linux (Ubuntu/Debian), você pode usar `snap`:
        ```bash
        sudo snap install terraform --classic
        ```
    * Verifique a instalação:
        ```bash
        terraform --version
        ```
2.  **Conta AWS:**
    * Uma conta ativa na Amazon Web Services.
    * **Importante:** A AWS oferece um [Nível Gratuito](https://aws.amazon.com/free/) que permite usar a instância `t2.micro` (definida neste projeto) gratuitamente por um ano, o que é ótimo para testes.
3.  **Credenciais AWS Configuradas:**
    * O Terraform precisa de credenciais para interagir com sua conta AWS. A forma mais comum é configurar o AWS CLI:
        ```bash
        sudo apt install awscli # Para Ubuntu/Debian
        aws configure
        ```
        Siga as instruções para inserir seu `AWS Access Key ID`, `AWS Secret Access Key`, região padrão (ex: `sa-east-1`) e formato de saída padrão.
4.  **Par de Chaves SSH:**
    * Você precisará de um par de chaves SSH (pública e privada) na sua máquina local para acessar a instância EC2. Se não tiver um, pode gerar um:
        ```bash
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/minha_chave_terraform
        ```
    * Certifique-se de lembrar o caminho para o arquivo `.pub` (chave pública), como `~/.ssh/minha_chave_terraform.pub`.

## 📁 Estrutura do Projeto