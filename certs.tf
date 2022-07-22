locals {
  certs_set = { for c in var.certs : c.secret_name => c }
}

# Chaves privadas e certificados.
resource "tls_private_key" "certs" {
  for_each = local.certs_set

  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "certs" {
  for_each = local.certs_set

  private_key_pem = tls_private_key.certs[each.key].private_key_pem
  dns_names       = each.value.dns_names
}

resource "tls_locally_signed_cert" "certs" {
  for_each = local.certs_set

  cert_request_pem   = tls_cert_request.certs[each.key].cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = each.value.validity
  allowed_uses          = each.value.allowed_uses
}

# GCP secrets para certificados adicionais.
resource "google_secret_manager_secret" "certs" {
  for_each = local.certs_set

  secret_id = "${each.key}-cert"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "certs" {
  for_each = local.certs_set

  secret      = google_secret_manager_secret.certs[each.key].id
  secret_data = tls_locally_signed_cert.certs[each.key].cert_pem
}

# GCP secrets para chave privada dos certificados adicionais.
resource "google_secret_manager_secret" "certs_keys" {
  for_each = local.certs_set

  secret_id = "${each.key}-key"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "certs_keys" {
  for_each = local.certs_set

  secret      = google_secret_manager_secret.certs_keys[each.key].id
  secret_data = tls_private_key.certs[each.key].private_key_pem
}
