provider "azurerm" {
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "Terraform_remotestate_storage"
        storage_account_name = "tfremotestategamkon"
        container_name       = "kg-tf-state"
        key                  = "Azure-CICD-Docker-Terraform/terraform.tfstate"
    }
}

resource "azurerm_resource_group" "gk-resource-froup" {
  name = "weather-rg"
  location = "Canada Central"
}