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
  source   = "app.terraform.io/akshayInfra/terraform-module-rg/azurerm"
  version  = "1.0.0"
  rg_name  = "catsweb-dev-rg"
  location = "eastus"
}

module "vm" {
  source   = "app.terraform.io/akshayInfra/terraform-module-vm/azurerm"
  version  = "1.0.0"
  rg_name  = module.rg.rg_name
  vm_name  = "catsweb-dev-vm"   # hard-coded
  vm_size  = "Standard_B2s"    # hard-coded
  location = "eastus"          # hard-coded
  os_type  = "Linux"           # hard-coded
  nic_id   = "some-nic-id"     # placeholder until NIC module is added
}