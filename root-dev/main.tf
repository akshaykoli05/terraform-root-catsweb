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
  version = "1.1.0"
  rg_name  = "catsweb-dev-rg-01"
  location = "eastus"
}


# Create VNet
resource "azurerm_virtual_network" "vm_vnet" {
  name                = "catsweb-dev-vnet"
  location            = module.rg.location
  resource_group_name = module.rg.rg_name
  address_space       = ["10.0.0.0/16"]
}

# Create Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = "catsweb-dev-subnet"
  resource_group_name  = module.rg.rg_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create NIC
resource "azurerm_network_interface" "vmnic01" {
  name                = "azwacatsd01-nic"
  location            = module.rg.location
  resource_group_name = module.rg.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Call VM module
module "vm01" {
  source   = "app.terraform.io/akshayInfra/terraform-module-vm/module"
  version  = "1.4.1"

  rg_name   = module.rg.rg_name
  location  = module.rg.location
  vm_size   = "Standard_B2s"
  nic_id    = azurerm_network_interface.vmnic01.id
  vm_suffix = "01"
}