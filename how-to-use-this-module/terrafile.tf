variable "project" {
  type = string
}

provider "google" {
  project = var.project
}

module "nomad_mtls" {
  source = "../"

  ca_secret_name   = "nomad-ca"
  ca_cert_validity = 10 * 365 * 24

  ca_subject = {
    common_name  = "root.nomad.cluster.local"
    country      = "BR"
    organization = "Mentoria IaC"
  }

  ca_allowed_uses = [
    "cert_signing",
    "client_auth",
    "server_auth",
  ]

  certs = [
    {
      secret_name = "nomad-server"
      dns_names = [
        "server.global.nomad",
        "localhost",
        "127.0.0.1",
      ]
      validity = 87600
      allowed_uses = [
        "cert_signing",
        "key_encipherment",
        "server_auth",
        "client_auth",
      ]
    },
    {
      secret_name = "nomad-client",
      dns_names = [
        "client.global.nomad",
        "localhost",
        "127.0.0.1",
      ]
      validity = 87600
      allowed_uses = [
        "cert_signing",
        "key_encipherment",
        "server_auth",
        "client_auth",
      ]
    },
    {
      secret_name = "nomad-cli",
      dns_names   = []
      validity    = 87600
      allowed_uses = [
        "client_auth",
      ]
    }
  ]
}

output "ca_cert_secret_version" {
  value = module.nomad_mtls.ca_cert_secret_version
}

output "cli_cert" {
  value     = module.nomad_mtls.certs_pem["nomad-cli"]
  sensitive = true
}
