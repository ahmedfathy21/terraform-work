# Configure the Azure provider
provider "azurerm" {
  features {}
   subscription_id = "8cc83d3e-87c0-48c8-89e2-e5906b67ff9f"
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# Create a Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Network Interface (NIC)
resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Create a Public IP Address
resource "azurerm_public_ip" "pip" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"  # Standard SKU requires static IP
}

# Create a Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "myVM"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = "azureuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Create a Storage Account (similar to S3)
resource "azurerm_storage_account" "storage" {
  name                     = "mystoragekakashi"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Blob Container in the Storage Account
resource "azurerm_storage_container" "container" {
  name                  = "mycontainerkakashi"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
resource "azurerm_container_group" "container" {
  name                = "kakashi"
  location            = "East US"
  resource_group_name = "myResourceGroup"
  ip_address_type     = "Public"
  os_type            = "Linux"  # or "Windows"

  container {
    name   = "kakashi"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}