output "ca_cert_pem" {
  description = "O certificado raiz da CA em formato PEM."
  value       = tls_self_signed_cert.ca.cert_pem
  sensitive   = true
}

output "ca_private_key_pem" {
  description = "A chave privada do certificado raiz da CA em formato PEM."
  value       = tls_private_key.ca.private_key_pem
  sensitive   = true
}

output "ca_cert_secret_id" {
  description = "O ID do segredo na GCP Secret Manager para o certificado raiz da CA."
  value       = google_secret_manager_secret.ca_cert.id
}

output "ca_cert_secret_version" {
  description = "O ID da versão do segredo na GCP Secret Manager para o certificado raiz da CA."
  value       = google_secret_manager_secret_version.ca_cert.id
}

output "certs_pem" {
  description = "Mapa com os certificados adicionais em formato PEM."
  value       = { for k, v in tls_locally_signed_cert.certs : k => v.cert_pem }
  sensitive   = true
}

output "certs_private_key_pem" {
  description = "Mapa com as chaves privadas dos certificados adicionais em formato PEM."
  value       = { for k, v in tls_private_key.certs : k => v.private_key_pem }
  sensitive   = true
}

output "certs_pem_secrets_ids" {
  description = "O ID dos segredos na GCP Secret Manager para os certificados adicionais."
  value       = { for k, v in google_secret_manager_secret.certs : k => v.id }
}

output "certs_pem_secrets_versions" {
  description = "Os IDs das versões dos segredos na GCP Secret Manager para os certificados adicionais."
  value       = { for k, v in google_secret_manager_secret_version.certs : k => v.id }
}
