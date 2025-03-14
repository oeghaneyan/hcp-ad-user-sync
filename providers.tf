terraform {
  required_providers {
    ldap = {
      source  = "terraform-providers/ldap"
      version = "~> 0.2.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.95.1"
    }
  }
}

provider "ldap" {
  host     = var.ad_host
  binddn   = var.ad_username
  password = var.ad_password
  insecure = false # Set to true if using plain LDAP instead of LDAPS
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}
