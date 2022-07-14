variable "ca_subject" {
  description = "Informações sobre o sujeito do certificado raiz da CA."

  type = object({
    common_name         = optional(string)
    country             = optional(string)
    locality            = optional(string)
    organization        = optional(string)
    organizational_unit = optional(string)
    postal_code         = optional(string)
    province            = optional(string)
    serial_number       = optional(string)
    street_address      = optional(list(string))
  })

  default = {
    common_name = "example.com"
  }
}

variable "ca_cert_validity" {
  description = "Tempo em horas da validade do certificado do certificado raiz da CA."
  type        = number
  default     = 5 * 365 * 24 # 5 anos.
}

variable "ca_allowed_uses" {
  description = "Usos permitidos para o certificado raiz da CA."
  type        = list(string)

  default = [
    "any_extended",
    "cert_signing",
    "client_auth",
    "code_signing",
    "content_commitment",
    "crl_signing",
    "data_encipherment",
    "decipher_only",
    "digital_signature",
    "email_protection",
    "encipher_only",
    "ipsec_end_system",
    "ipsec_tunnel",
    "ipsec_user",
    "key_agreement",
    "key_encipherment",
    "microsoft_commercial_code_signing",
    "microsoft_kernel_code_signing",
    "microsoft_server_gated_crypto",
    "netscape_server_gated_crypto",
    "ocsp_signing",
    "server_auth",
    "timestamping",
  ]
}

variable "ca_secret_name" {
  description = "Prefixo dos secrets para o certificado e a chave da CA que serão armazenados na GCP Secret Manager."
  type        = string
}

variable "certs" {
  description = "Lista de certificados adicionais a serem criados e assinados pela CA."

  type = list(object({
    secret_name  = string
    dns_names    = optional(list(string))
    validity     = number
    allowed_uses = list(string)
  }))

  default = []
}
