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

├── .gitignore
├── .terraform.lock.hcl
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── terraform.tfvars.example
└── variables.tf

* **`.gitignore`**: Define arquivos e diretórios a serem ignorados pelo Git (ex: credenciais, arquivos de estado do Terraform).
* **`.terraform.lock.hcl`**: Mantém as versões dos provedores fixas para garantir reprodutibilidade.
* **`main.tf`**: Contém a definição dos recursos AWS (instância EC2, Security Group, Key Pair).
* **`outputs.tf`**: Define os valores de saída após a aplicação do Terraform (ex: IP público da instância).
* **`terraform.tfvars`**: **(Seu arquivo de configuração local)** Onde você personaliza as variáveis do projeto (AMI ID, VPC ID, etc.). **Este arquivo NÃO deve ser versionado no Git por conter informações sensíveis.**
* **`terraform.tfvars.example`**: Um modelo para `terraform.tfvars`.
* **`variables.tf`**: Declaração das variáveis usadas no projeto.

## ⚙️ Configuração

1.  **Copie o arquivo de exemplo de variáveis:**
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```

2.  **Edite `terraform.tfvars`:**
    Abra `terraform.tfvars` em seu editor de texto e preencha os valores com as informações da sua conta AWS:

    ```terraform
    # terraform.tfvars (Exemplo)
    aws_region      = "sa-east-1" # Sua região da AWS (ex: "sa-east-1" para São Paulo)
    ami_id          = "ami-xxxxxxxxxxxxxxxxx" # ID da AMI para sua região e OS (Verifique no Console AWS EC2)
    instance_type   = "t2.micro" # Tipo da instância (t2.micro é free tier)
    key_pair_name   = "minha-chave-terraform" # Nome da chave SSH que será criada na AWS
    public_key_path = "/home/seu_usuario/.ssh/minha_chave_terraform.pub" # Caminho ABSOLUTO da sua chave pública SSH
    vpc_id          = "vpc-yyyyyyyyyyyyyyyyy" # ID da sua VPC (Verifique no Console AWS VPC -> Your VPCs)
    ```
    * **AMI ID:** Encontre o ID da AMI mais recente e adequada para a sua região e sistema operacional (ex: Ubuntu Server 22.04 LTS) no console AWS EC2 (ao tentar "Launch instance").
    * **VPC ID:** Encontre o ID da sua VPC padrão ou de uma VPC existente no console AWS VPC (em "Your VPCs").
    * **`public_key_path`**: Certifique-se de usar o caminho absoluto para o seu arquivo `.pub`.

## 🚀 Como Usar

1.  **Navegue até o diretório do projeto:**
    ```bash
    cd terraform-aws-server-image
    ```

2.  **Inicialize o Terraform:**
    Isso baixará os plugins necessários para o provedor AWS.
    ```bash
    terraform init
    ```

3.  **Planeje a execução:**
    Visualize as mudanças que o Terraform fará na sua infraestrutura sem aplicá-las. **Revise cuidadosamente este output!**
    ```bash
    terraform plan
    ```

4.  **Aplique as mudanças:**
    Se o plano estiver correto, aplique as mudanças. Digite `yes` quando solicitado.
    ```bash
    terraform apply
    ```

5.  **Acesse a Instância:**
    Após a aplicação bem-sucedida, o Terraform exibirá o IP público da sua instância na seção `Outputs`. Você pode acessá-la via SSH:
    ```bash
    ssh -i ~/.ssh/minha_chave_terraform ubuntu@<IP_PÚBLICO_DA_INSTANCIA>
    ```
    (Substitua `ubuntu` pelo usuário padrão da sua AMI, ex: `ec2-user` para Amazon Linux).
    Se o `user_data` foi executado, você poderá acessar o IP público da instância em um navegador web para ver a página "Olá do Terraform!".

## 🧹 Limpeza (Destruição dos Recursos)

Para remover todos os recursos provisionados por este projeto e evitar cobranças desnecessárias na AWS, execute:

```bash
terraform destroy

⚠️ Segurança

* Security Group: As regras de ingress (entrada) neste projeto (0.0.0.0/0 para SSH e HTTP) são muito permissivas e NÃO SÃO RECOMENDADAS para ambientes de produção. Para maior segurança, limite o acesso aos seus IPs de origem ou IPs específicos da sua rede.

* Credenciais AWS: Mantenha suas credenciais AWS seguras e nunca as exponha em arquivos de código ou repositórios públicos.

🤝 Contribuição
Sinta-se à vontade para abrir issues ou pull requests se tiver sugestões de melhoria!
