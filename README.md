# ACMP2400 Final Project

Containerized Django app with a full CI/CD pipeline that builds, scans, provisions infrastructure, deploys to Azure, and tears down on completion.

## Stack

Django · Docker · Terraform (azurerm) · Azure Container Registry · Azure Container Instances · GitHub Actions

## Pipeline

1. Build Docker image and smoke-test with `curl`
2. Generate SBOM (Syft) and scan for critical CVEs (Grype)
3. Provision Azure Container Registry — Terraform stage 1
4. Build, tag with commit SHA, and push image to ACR
5. Deploy to Azure Container Instances — Terraform stage 2
6. Destroy all Azure resources — Terraform stage 3

## Infrastructure

- **ACR** — stores Docker images
- **ACI** — hosts the running container
- **Pre-provisioned** resource group and Terraform state backend (storage account + blob container)

## Required GitHub Secrets

| Secret | Description |
|---|---|
| `ARM_CLIENT_ID` | Service principal app ID |
| `ARM_CLIENT_SECRET` | Service principal secret |
| `ARM_SUBSCRIPTION_ID` | Azure subscription ID |
| `ARM_TENANT_ID` | Azure tenant ID |
| `STATE_KEY` | Terraform state file key |
| `DJANGO_SECRET_KEY_PROD` | Django production secret key |

## Run

GitHub → Actions → **CI Pipeline** → **Run workflow**.
