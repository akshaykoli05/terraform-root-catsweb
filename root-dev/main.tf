terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source   = "app.terraform.io/akshayInfra/terraform-module-rg/module"
  version  = "1.1.0"
  rg_name  = "catsweb-dev-rg-01"
  location = "eastus"
}

