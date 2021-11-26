# Terraform AzureRM Policy Exemptions

Uses a Terraform [Resource Group Template Deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) for managing [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions?WT.mc_id=AZ-MVP-5004598).

Learn more about [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure?WT.mc_id=AZ-MVP-5004598)

> Note: Terraform v0.13 or greater is required to use this module. Download the latest Terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

# Example Usage

More examples can be found here: [terraform-azurerm-policy-exemptions/tree/main/examples](https://github.com/globalbao/terraform-azurerm-policy-exemptions/tree/main/examples)

#### Create 2 policy exemptions targeting resources in 2 RGs in 2 subscriptions

> For documentation on using provider blocks and aliases see [https://www.terraform.io/docs/language/modules/develop/providers.html](https://www.terraform.io/docs/language/modules/develop/providers.html)

```hcl
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

# exemption module for subscription A
module "policy_exemptions_subA" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  providers = {
    azurerm = azurerm.subA
  }
  policyExemptions = {
    exemption1 = {
      deploymentMode               = "Incremental"
      name                         = "exemption1"
      scope                        = null
      displayName                  = "exemption1 for Insert-Your-RG-Name1"
      description                  = "exemption1 exempts policy compliance for resources in Insert-Your-RG-Name1"
      resourceGroupName            = "Insert-Your-RG-Name1"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Waiver"
      expiresOn                    = "2027-12-30"
      metadata = {}
    }
  }
}

# exemption module for subscription B
module "policy_exemptions_subB" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  providers = {
    azurerm = azurerm.subB
  }
  policyExemptions = {
    exemption2 = {
      deploymentMode               = "Incremental"
      name                         = "exemption2"
      scope                        = null
      displayName                  = "exemption2 for Insert-Your-RG-Name2"
      description                  = "exemption2 exempts policy compliance for resources in Insert-Your-RG-Name2"
      resourceGroupName            = "Insert-Your-RG-Name2"
      policyAssignmentId           = "/subscriptions/xxxx-xxxx-xxxx-xxxx-xxxx/providers/Microsoft.Authorization/policyAssignments/SecurityCenterBuiltIn"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Mitigated"
      expiresOn                    = "2026-12-31"
      metadata                     = {}
    }
  }
}