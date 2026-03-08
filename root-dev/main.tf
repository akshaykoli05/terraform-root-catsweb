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
  version  = "1.0.0"
  rg_name  = "catsweb-dev-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "vm_vnet" {
  name                = "catsweb-dev-vnet"
  location            = module.rg.location
  resource_group_name = module.rg.rg_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "catsweb-dev-subnet"
  resource_group_name  = module.rg.rg_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "vmnic" {
  name                = "catsweb-dev-nic"
  location            = module.rg.location
  resource_group_name = module.rg.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


module "vm" {
  source   = "app.terraform.io/akshayInfra/terraform-module-vm/module"
  version  = "1.2.0"
  rg_name  = module.rg.rg_name
  vm_name  = "catsweb-dev-vm"   # hard-coded
  vm_size  = "Standard_B2s"    # hard-coded
  location = "eastus"          # hard-coded
  os_type  = "Linux"           # hard-coded
  nic_id   = "some-nic-id"     # placeholder until NIC module is added
}