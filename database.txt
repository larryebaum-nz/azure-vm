module "database" {
  source = "app.terraform.io/larryebaum-demo/database/azurerm"
  version = "1.1.0"
  resource_group_name = "myapp"
  location = "eastus"
  db_name = "mydatabase"
  sql_admin_username = "mradministrator"
  sql_password = "P@ssw0rd12345!"  
  tags = {
    environment = "dev"
    costcenter  = "it"
   }  
}
