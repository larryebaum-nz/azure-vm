module "network-security-group" {
  source  = "app.terraform.io/larryebaum-demo/network-security-group/azurerm"
  version = "3.0.1"
  resource_group_name = "${var.windows_dns_prefix}-rc"
  security_group_name   = "nsg"
  source_address_prefix = ["${module.windowsservers.public_ip_address}"]
  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
    },
    {
      name              = "LDAP"
      source_port_range = "1024-1026"
    }
  ]
  custom_rules = [
    {
      name                   = "myhttp"
      priority               = "200"
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      destination_port_range = "8080"
      description            = "description-myhttp"
    }
  ]
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
