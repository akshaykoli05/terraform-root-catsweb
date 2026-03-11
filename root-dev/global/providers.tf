terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  cloud {
    organization = "akshayInfra"
    workspaces {
      name = "root-dev"
    }
  }
}

provider "azurerm" {
  features {}
}