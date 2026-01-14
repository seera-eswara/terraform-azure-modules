App Team Repo
 └── Terraform Root Module
      ├── Calls Landing Zone modules (read-only)
      ├── Uses approved policies automatically
      └── Deploys only into its subscription

GitHub Actions
 ├── Unit tests
 ├── Policy tests (OPA)
 ├── Security scans
 ├── Integration tests
 ├── Approval gates
 └── Apply
