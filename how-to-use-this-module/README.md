# Template de módulo Terraform

## Dependências

Para realizar os testes localmente é necessário:

| Ferramentas | Versão   | Instalação |
| ----------- | -------- | ---------- |
| Terraform   | >= 1.0.0 | [Acesse](https://learn.hashicorp.com/tutorials/terraform/install-cli) |
| Project na GCP | N/A | [Acesse](console.cloud.google.com/) |

## Habilite a API do Secret Manager

Acesse o serviço de [Secret Manager](https://console.cloud.google.com/security/secret-manager) e habilite a API.

## Utilizando o módulo

Inicialize o Terraform

```console
terraform init
```

Aplique passando o ID do seu project como variável:

```console
terraform apply -var project=<PROJECT ID>
```
