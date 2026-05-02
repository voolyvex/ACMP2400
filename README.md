# ACMP2400 Final Project

Containerized Django app with a full CI/CD pipeline that builds, scans, provisions infrastructure, deploys to Azure, and tears down on completion.

### Stack

Django · Docker · Terraform (azurerm) · Azure Container Registry · Azure Container Instances · GitHub Actions

### Pipeline

1. Build Docker image and smoke-test with `curl`
2. Generate SBOM (Syft) and scan for critical CVEs (Grype)
3. Provision Azure Container Registry — Terraform stage 1
4. Build, tag with commit SHA, and push image to ACR
5. Deploy to Azure Container Instances — Terraform stage 2
6. Verify the live deployment via its public DNS
7. Destroy all Azure resources — Terraform stage 3

### Project structure

- `final_app/` — Django project
- `hello_final/` — Django app
- `tf/` — Terraform configs, one folder per stage (`stage1`, `stage2`, `stage3`)
- `.github/` — GitHub Actions workflow (`workflows/main.yml`) and composite actions (`actions/terraform`, `actions/sbom-scan`)

### Infrastructure

- **ACR** — stores Docker images
- **ACI** — hosts the running container
- **Pre-provisioned** resource group and Terraform state backend (storage account + blob container) 
  

### GitHub Secrets needed

| Secret | Description |
|---|---|
| `ARM_CLIENT_ID` | Service principal app ID |
| `ARM_CLIENT_SECRET` | Service principal secret |
| `ARM_SUBSCRIPTION_ID` | Azure subscription ID |
| `ARM_TENANT_ID` | Azure tenant ID |
| `STATE_KEY` | unique identifier used to provision each individual slice of backend state |
| `DJANGO_SECRET_KEY_PROD` | Django production secret key |

### Run

GitHub → Actions → **Build, Scan, Deploy, Verify, Teardown** → **Run workflow**.
