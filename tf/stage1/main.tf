terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-acmp-final"
    storage_account_name = "acmp2400storageaccount"
    container_name       = "big-tf-state-acmp2400"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}

variable "state_key" {
  description = "My unique id for this deployment"
  type        = string
}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.state_key}acmp2400"
  resource_group_name = "rg-${var.state_key}"
  location            = "centralus"
  sku                 = "Basic"
  admin_enabled       = true
}

