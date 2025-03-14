# HCP User Provisioning & Deprovisioning with Terraform and LDAP AD Data Source

## Overview
This repository automates the provisioning and de-provisioning of HashiCorp Cloud Platform (HCP) users based on Active Directory (AD) group membership. It uses Terraform to synchronize users from AD to HCP and runs on a GitHub Actions pipeline for automation.

## Features
- **Provision Users:** Automatically add new users from specified AD groups to HCP.
- **De-Provision Users:** Remove users from HCP when they are no longer in AD groups.
- **Role Mapping:** Assign users to existing HCP groups that match their AD groups.
- **Automated Execution:** GitHub Actions pipeline triggers periodic syncs.
- **Secure Configuration:** Uses GitHub Secrets for API credentials.

## Prerequisites
Ensure the following requirements are met before using this repository:

- **Active Directory (AD):** Self-managed AD servers with domain controllers.
- **HCP IAM Configuration:** Existing HCP groups matching AD groups.
- **Terraform Installed:** Ensure Terraform is installed for local testing.
- **GitHub Secrets:** Store the following sensitive credentials securely:
  - `HCP_CLIENT_ID`
  - `HCP_CLIENT_SECRET`
  - `AD_USERNAME`
  - `AD_PASSWORD`

## How It Works

### Terraform Configuration

- Queries AD for active users in specified groups.
- Maps users to existing HCP roles.
- Ensures users removed from AD are also removed from HCP.

### GitHub Actions Pipeline

- Scheduled to run every 6 hours.
- Uses GitHub Secrets for secure authentication.
- Executes Terraform to sync users.

## Security Considerations

- **Do not store credentials in the repository.** Use GitHub Secrets.
- **Limit AD account permissions** to read-only for querying users.
- **Monitor GitHub Actions logs** for any anomalies or unauthorized access.


## Repository Structure
```plaintext
hcp-user-sync/
│── .github/
│   └── workflows/
│       └── sync-users.yml      # GitHub Actions pipeline
│── main.tf                     # Main Terraform configuration
│── providers.tf                 # Providers configuration
│── variables.tf                 # Variables definition
│── outputs.tf                    # Outputs definition (if needed)
│── versions.tf                   # Required Terraform version
│── locals.tf                     # Local variables (AD groups)
│── terraform.tfvars              # Sensitive variable values (ignored in Git)
│── .gitignore                    # Ignore sensitive Terraform files
│── README.md                     # Documentation
```

## Setup & Usage
### 1. Clone the Repository
```plaintext
git clone https://github.com/your-org/hcp-user-sync.git
cd hcp-user-sync
```

### 2. Configure GitHub Secrets
In your GitHub repository, navigate to **Settings → Secrets and Variables → Actions** and add:

- ```HCP_CLIENT_ID```: Your HCP API client ID.
- ```HCP_CLIENT_SECRET```: Your HCP API client secret.
- ```AD_HOST```: AD LDAP server hostname or IP.
- ```AD_USERNAME```: AD service account username.
- ```AD_PASSWORD```: AD service account password.


### 3. Modify Terraform Variables
Edit ```locals.tf``` to update the AD groups being synced:

```
locals {
  ad_groups = ["Engineering", "Operations", "Security"]
}
```

### 4. Run Terraform Locally (Optional)
You can test synchronization locally before running it in GitHub Actions:

1. Modify the ```terraform.tfvars``` files with the required variables. 

2. Then run Terraform: 
```plaintext
terraform init
terraform plan
terraform apply -auto-approve
```

### 5. Enable GitHub Actions Workflow
The pipeline is configured to run every 6 hours and can also be triggered manually:

**To trigger manually:**
1. Go to **GitHub Actions** in your repository.
2. Select the **Sync AD Users to HCP** workflow.
3. Click **Run workflow**.

### 6. Monitor Synchronization
The pipeline logs will be available in GitHub Actions to verify:
- New users being added to HCP.
- Removed users being deprovisioned.
- Errors or permission issues.

## Troubleshooting

### Common Issues

| Issue                                             | Solution                                       |
| ------------------------------------------------- | ---------------------------------------------- |
| `terraform apply` fails with authentication error | Ensure GitHub Secrets are correctly configured |
| Users are not being removed from HCP              | Verify AD group membership and Terraform state |
| GitHub Actions fails due to permissions           | Ensure the runner has access to required APIs  |

## Contributions

Feel free to submit pull requests to enhance functionality.

## License

This project is licensed under the MIT License.

---

This README provides a structured guide for setting up, running, and maintaining the HCP user provisioning system.