terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
  }

  # Permite o uso de valores opicionais em variáveis do tipo object.
  experiments = [
    module_variable_optional_attrs,
  ]
}
