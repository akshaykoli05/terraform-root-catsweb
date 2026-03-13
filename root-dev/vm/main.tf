#module "vm" {
#  source  = "app.terraform.io/akshayInfra/terraform-module-vm/module"
#  version = "1.5.0"
  # Example: "app.terraform.io/akshay-org/vm/1.0.0"

 # rg_name   = "catsweb-rg"          # existing RG name
 # location  = "eastus"              # existing RG location
 # vm_size   = var.vm_size
 # nic_id    = var.nic_id            # existing NIC ID in Azure
 # vm_suffix = var.vm_suffix
#}