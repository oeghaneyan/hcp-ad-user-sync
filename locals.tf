locals {
  ad_groups = {
    "CN=Engineering,OU=Groups,DC=company,DC=com" = "engineering-team",
    "CN=Operations,OU=Groups,DC=company,DC=com"  = "operations-team",
    "CN=Security,OU=Groups,DC=company,DC=com"    = "security-team"
  } # Mapping of AD Distinguished Names to HCP groups
}