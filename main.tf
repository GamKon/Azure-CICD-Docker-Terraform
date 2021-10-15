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

variable "imagebuild" {
  type        = string
  default     = "latest"
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "gk-resource-froup" {
  name     = "weather-rg"
  location = "Canada Central"
}

resource "azurerm_container_group" "gk-container-group" {
  name                = "weatherapi"
  location            = azurerm_resource_group.gk-resource-froup.location
  resource_group_name = azurerm_resource_group.gk-resource-froup.name

  ip_address_type = "public"
  dns_name_label  = "binarythistlewa"
  os_type         = "Linux"

  container {
    name  = "weatherapi"
    image = "gamkon61/gamkon-repo:${var.imagebuild}"
    //      image           = "gamkon61/gamkon-repo"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}