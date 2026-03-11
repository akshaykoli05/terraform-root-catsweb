module "network" {
  source  = "app.terraform.io/akshayInfra/terraform-module-vnet-subnet/module"
  version = "1.0.0"

  vnet_name              = "catsweb-vnet"
  vnet_address_space     = ["10.10.0.0/16"]
  location               = "eastus"
  resource_group_name    = "catsweb-rg"
  subnet_name            = "catsweb-subnet"
  subnet_address_prefixes = ["10.10.1.0/24"]
}