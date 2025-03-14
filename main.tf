# Query users only from specific AD groups
data "ad_users" "active" {
  for_each = toset(local.ad_groups)
  search {
    name  = "memberOf"
    value = "CN=${each.value},OU=Groups,DC=company,DC=com"
  }
}

# Provision active users in HCP and assign them to their respective groups
resource "hcp_user" "hcp_org_members" {
  for_each = merge([for group in local.ad_groups : { for user in data.ad_users.active[group].users : user.mail => group } ]...)
  email    = each.key
  role     = each.value  # Assumes HCP groups match AD groups
}
