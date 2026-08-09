module "resource_group" {
  source = "../child_module/azurerm_resourcegroup"
  rgs    = var.rgs
}
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../child_module/azurerm_vnet"
  vnets      = var.vnets
}
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../child_module/azurerm_subnet"
  subnets    = var.subnets
}

module "network_interface" {
  depends_on = [module.subnet]
  source     = "../child_module/azurerm_network_interface"
  nics       = var.nics
}

module "linux_virtual_machine" {
  depends_on = [module.network_interface]
  source     = "../child_module/azurerm_linux_virtual_machine"
  vms        = var.vms
}