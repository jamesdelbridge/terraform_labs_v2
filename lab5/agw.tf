

###############################################################
### Do not create any other resources other than those below ##.
###############################################################

##############################################################################
## Uncomment the resource block below and populate                          ##
## Use values from network_module output and root variables file throughout ##
##############################################################################


#azurerm_application_gateway resource....#
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway#

resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = module.networking.rg_name
  location            = module.networking.rg_location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = module.networking.frontend_subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = module.networking.public_ip_address_id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }
}

#azurerm_network_interface_application_gateway_backend_address_pool_association#
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_gateway_backend_address_pool_association

# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "testconfiguration1"
#     subnet_id                     = azurerm_subnet.frontend.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic-assoc" {
  for_each = azurerm_network_interface.example
  network_interface_id    = each.value.id
  ip_configuration_name   = "${each.key}-ipconfig"#Wrong! each.value.name #"testconfiguration1"
  backend_address_pool_id = one(azurerm_application_gateway.network.backend_address_pool).id
}

#resource "azurerm_application_gateway" "network" {}

#resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic-assoc" {}

