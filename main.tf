data "ad_group" "selected" {
  for_each = toset(local.ad_groups)
  group_id = each.value  # Uses AD Distinguished Name
}

# Query users within the selected AD groups
resource "hcp_user" "hcp_org_members" {
  for_each = merge([for group in local.ad_groups : {
    for user in data.ad_group.selected[group].members : user.sam_account_name => group
  }]...)

  email = "${each.key}@company.com"  # Adjust email format as needed
  role  = each.value  # Assumes HCP groups match AD groups
}