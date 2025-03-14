variable "ad_host" {
  description = "Active Directory LDAP server hostname or IP"
  type        = string
}

variable "ad_username" {
  description = "Active Directory service account DN (Distinguished Name)"
  type        = string
}

variable "ad_password" {
  description = "Active Directory service account password"
  type        = string
  sensitive   = true
}

variable "hcp_client_id" {
  description = "HCP API client ID"
  type        = string
  sensitive   = true
}

variable "hcp_client_secret" {
  description = "HCP API client secret"
  type        = string
  sensitive   = true
}
