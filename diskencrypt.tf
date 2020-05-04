module "diskencrypt" {
  source               = "Azure/diskencrypt/azurerm"
  resource_group_name = "${var.windows_dns_prefix}-rc"
  location            = "${var.location}"
  vm_name              = "pwc-ptfe"
  key_vault_name       = "testkeyvault123"
  encryption_algorithm = "RSA-OAEP"
  encryption_key_url   = "https://testkeyVault123.vault.azure.net:443/keys/ContosoFirstKey/9465333262aa49468c7f0dad5a167ee8"
  
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
