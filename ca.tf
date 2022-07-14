# Chave privada e certificado.
resource "tls_private_key" "ca" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem       = tls_private_key.ca.private_key_pem
  validity_period_hours = var.ca_cert_validity
  allowed_uses          = var.ca_allowed_uses
  is_ca_certificate     = true

  subject {
    common_name         = var.ca_subject.common_name
    country             = var.ca_subject.country
    locality            = var.ca_subject.locality
    organization        = var.ca_subject.organization
    organizational_unit = var.ca_subject.organizational_unit
    postal_code         = var.ca_subject.postal_code
    province            = var.ca_subject.province
    serial_number       = var.ca_subject.serial_number
    street_address      = var.ca_subject.street_address
  }
}

# GCP secret para certificado raiz.
resource "google_secret_manager_secret" "ca_cert" {
  secret_id = "${var.ca_secret_name}-cert"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "ca_cert" {
  secret      = google_secret_manager_secret.ca_cert.id
  secret_data = tls_self_signed_cert.ca.cert_pem
}

# GCP secret para chave privada do certificado raiz.
resource "google_secret_manager_secret" "ca_key" {
  secret_id = "${var.ca_secret_name}-key"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "ca_key" {
  secret      = google_secret_manager_secret.ca_key.id
  secret_data = tls_private_key.ca.private_key_pem
}
