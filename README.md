## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.27.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.27.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.ca_cert](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.ca_key](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.certs](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.certs_keys](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.ca_cert](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.ca_key](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.certs](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.certs_keys](https://registry.terraform.io/providers/hashicorp/google/4.27.0/docs/resources/secret_manager_secret_version) | resource |
| [tls_cert_request.certs](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.certs](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [tls_private_key.certs](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_allowed_uses"></a> [ca\_allowed\_uses](#input\_ca\_allowed\_uses) | Usos permitidos para o certificado raiz da CA. | `list(string)` | <pre>[<br>  "any_extended",<br>  "cert_signing",<br>  "client_auth",<br>  "code_signing",<br>  "content_commitment",<br>  "crl_signing",<br>  "data_encipherment",<br>  "decipher_only",<br>  "digital_signature",<br>  "email_protection",<br>  "encipher_only",<br>  "ipsec_end_system",<br>  "ipsec_tunnel",<br>  "ipsec_user",<br>  "key_agreement",<br>  "key_encipherment",<br>  "microsoft_commercial_code_signing",<br>  "microsoft_kernel_code_signing",<br>  "microsoft_server_gated_crypto",<br>  "netscape_server_gated_crypto",<br>  "ocsp_signing",<br>  "server_auth",<br>  "timestamping"<br>]</pre> | no |
| <a name="input_ca_cert_validity"></a> [ca\_cert\_validity](#input\_ca\_cert\_validity) | Tempo em horas da validade do certificado do certificado raiz da CA. | `number` | `43800` | no |
| <a name="input_ca_secret_name"></a> [ca\_secret\_name](#input\_ca\_secret\_name) | Prefixo dos secrets para o certificado e a chave da CA que serão armazenados na GCP Secret Manager. | `string` | n/a | yes |
| <a name="input_ca_subject"></a> [ca\_subject](#input\_ca\_subject) | Informações sobre o sujeito do certificado raiz da CA. | <pre>object({<br>    common_name         = optional(string)<br>    country             = optional(string)<br>    locality            = optional(string)<br>    organization        = optional(string)<br>    organizational_unit = optional(string)<br>    postal_code         = optional(string)<br>    province            = optional(string)<br>    serial_number       = optional(string)<br>    street_address      = optional(list(string))<br>  })</pre> | <pre>{<br>  "common_name": "example.com"<br>}</pre> | no |
| <a name="input_certs"></a> [certs](#input\_certs) | Lista de certificados adicionais a serem criados e assinados pela CA. | <pre>list(object({<br>    secret_name  = string<br>    dns_names    = optional(list(string))<br>    validity     = number<br>    allowed_uses = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_cert_pem"></a> [ca\_cert\_pem](#output\_ca\_cert\_pem) | O certificado raiz da CA em formato PEM. |
| <a name="output_ca_cert_secret_id"></a> [ca\_cert\_secret\_id](#output\_ca\_cert\_secret\_id) | O ID do segredo na GCP Secret Manager para o certificado raiz da CA. |
| <a name="output_ca_cert_secret_version"></a> [ca\_cert\_secret\_version](#output\_ca\_cert\_secret\_version) | O ID da versão do segredo na GCP Secret Manager para o certificado raiz da CA. |
| <a name="output_ca_private_key_pem"></a> [ca\_private\_key\_pem](#output\_ca\_private\_key\_pem) | A chave privada do certificado raiz da CA em formato PEM. |
| <a name="output_certs_pem"></a> [certs\_pem](#output\_certs\_pem) | Mapa com os certificados adicionais em formato PEM. |
| <a name="output_certs_pem_secrets_ids"></a> [certs\_pem\_secrets\_ids](#output\_certs\_pem\_secrets\_ids) | O ID dos segredos na GCP Secret Manager para os certificados adicionais. |
| <a name="output_certs_pem_secrets_versions"></a> [certs\_pem\_secrets\_versions](#output\_certs\_pem\_secrets\_versions) | Os IDs das versões dos segredos na GCP Secret Manager para os certificados adicionais. |
| <a name="output_certs_private_key_pem"></a> [certs\_private\_key\_pem](#output\_certs\_private\_key\_pem) | Mapa com as chaves privadas dos certificados adicionais em formato PEM. |

## Como usar esse módulo
[Acesse o passo-a-passo](how-to-use-this-module/README.md)
