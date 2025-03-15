terraform {
  required_providers {
    ad = {
      source  = "hashicorp/ad"
      version = "~> 0.3.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.95.1"
    }
  }
}

provider "ad" {
  winrm_hostname = var.ad_host
  winrm_username = var.ad_username
  winrm_password = var.ad_password
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}
