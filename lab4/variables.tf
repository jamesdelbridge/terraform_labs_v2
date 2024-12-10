variable "resource_group_name" {
  type    = string
  default = "RG4"
}

variable "resource_group_location" {
  type    = string
  default = "westeurope"
}

variable "vnet_name" {
  type    = string
  default = "myVNet"
}

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_address_pool_name" {
  type = string
}

variable "app_gateway_sku_capacity" {
  type = string
}
variable "app_gateway_gateway_ip_configuration_name" {
  type = string
}

variable "app_gateway_sku_name" {
  type = string
}
variable "app_gateway_sku_tier" {
  type = string
}

# variable "azurerm_application_gateway" {
#   type = string
# }


variable "app_gateway_frontend_port_name" {
  type = string
}

variable "app_gateway_frontend_ip_configuration_name" {
  type = string
}

variable "vnet_address_space" {
  type = list
}

# variable "subnets" {
#   type = map(any)
# }

# variable "vnet_address_space" {
#   type = list(any)
#   #default = ["10.21.0.0/16"]
# }


# variable "app_gateway_settings" {
#   type = map(any)
# }