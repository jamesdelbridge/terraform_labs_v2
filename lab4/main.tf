module "network" {
  source                  = "./network"
  vnet_name               = var.vnet_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  vnet_address_space      = var.vnet_address_space
  subnets                 = var.subnets
}