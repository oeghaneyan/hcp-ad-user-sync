data "ad_group" "selected" {
  for_each = local.ad_groups
  group_id = each.key  # Uses AD Distinguished Name
}

# Manage HCP group members based on AD group users
resource "hcp_group_members" "hcp_org_groups" {
  for_each = local.ad_groups
  group = each.value  # Maps to the corresponding HCP group
  members = [for user in data.ad_group.selected[each.key].members : "${user.sam_account_name}@company.com"]
}