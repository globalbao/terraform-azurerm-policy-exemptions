# default provider block
provider "azurerm" {
  features {}
}

# new provider block for subscription A
provider "azurerm" {
  alias           = "subA"
  subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
  features {}
}

# new provider block for subscription B
provider "azurerm" {
  alias           = "subB"
  subscription_id = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
  features {}
}