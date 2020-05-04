provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
}

# module "windowsservers" {
#   source              = "Azure/compute/azurerm"
#   resource_group_name = azurerm_resource_group.example.name
#   is_windows_image    = true
#   vm_hostname         = "mywinvm" // line can be removed if only one VM module per resource group
#   admin_password      = "ComplxP@ssw0rd!"
#   vm_os_simple        = "WindowsServer"
#   public_ip_dns       = ["winsimplevmips"] // change to a unique name per datacenter region
#   vnet_subnet_id      = module.network.vnet_subnets[0]
# }

module "network" {
  source              = "Azure/network/azurerm"
  version             = "3.0.0"
  resource_group_name = azurerm_resource_group.example.name
  #allow_rdp_traffic   = "true"
  #allow_ssh_traffic   = "true"
  subnet_prefixes     = ["10.0.1.0/24"]

}

output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}

# output "windows_vm_public_name" {
#   value = module.windowsservers.public_ip_dns_name
# }


# terraform {
#   required_version = ">= 0.11.1"
# }

# variable "location" {
#   description = "Azure location in which to create resources"
#   default = "East US"
# }

# variable "windows_dns_prefix" {
#   description = "DNS prefix to add to to public IP address for Windows VM"
# }

# variable "admin_password" {
#   description = "admin password for Windows VM"
#   default = "pTFE1234!"
# }

# module "windowsserver" {
#   source              = "Azure/compute/azurerm"
#   version             = "1.1.5"
#   location            = "${var.location}"
#   resource_group_name = "${var.windows_dns_prefix}-rc"
#   vm_hostname         = "pwc-ptfe"
#   admin_password      = "${var.admin_password}"
#   vm_os_simple        = "WindowsServer"
#   public_ip_dns       = ["${var.windows_dns_prefix}"]
#   vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
# }

# module "network" {
#   source              = "Azure/network/azurerm"
#   version             = "1.1.1"
#   location            = "${var.location}"
#   resource_group_name = "${var.windows_dns_prefix}-rc"
#   allow_ssh_traffic   = true
# }

# output "windows_vm_public_name"{
#   value = "${module.windowsserver.public_ip_dns_name}"
# }
