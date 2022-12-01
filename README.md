# **Update: Dec 2022**
Terraform AzureRM provider now has resources available for Policy Exemptions!
I recommend utilising these for the best experience:
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption

# Terraform AzureRM Policy Exemptions

Uses a Terraform [Resource Group Template Deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) for managing [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions?WT.mc_id=AZ-MVP-5004598).

Learn more about [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure?WT.mc_id=AZ-MVP-5004598)

> Note: Terraform v0.13 or greater is required to use this module. Download the latest Terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

# Example Usage

* Create 1 policy exemption for resources in an RG to be exempt from policies in an assignment.
* Create 1 policy exemption for a Virtual Machine to be exempt from policies in an assignment.
* Create 3 policy exemptions for resources in selected RGs to be exempt from policies in selected assignments.
* Create 2 policy exemptions targeting resources in 2 RGs in 2 subscriptions.
  
> Complete example code can be found here: [terraform-azurerm-policy-exemptions/tree/main/examples](https://github.com/globalbao/terraform-azurerm-policy-exemptions/tree/main/examples)

#### Create 1 policy exemption for resources in an RG to be exempt from policies in an assignment

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode     = "Incremental"
      name               = "exemption1"
      scope              = null
      displayName        = "exemption1 for Insert-Your-RG-Name1"
      description        = "exemption1 waives compliance on an resource group"
      resourceGroupName  = "Insert-Your-RG-Name1"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory = "Waiver"
      expiresOn         = "2025-12-29"
      metadata = {}
    }
  }
}
```

#### Create 1 policy exemption for a Virtual Machine to be exempt from policies in an assignment

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode     = "Incremental"
      name               = "exemption1"
      scope                        = "/subscriptions/xxxx-xxxx-xxxx-xxxx-xxxx/resourcegroups/Insert-Your-RG-Name1/providers/Microsoft.Compute/virtualMachines/virtualmachine1"
      displayName                  = "exemption1 for storageaccountname1 in Insert-Your-RG-Name1"
      description                  = "exemption1 exempts policy assignment compliance for storageaccountname1 in Insert-Your-RG-Name1"
      resourceGroupName  = "Insert-Your-RG-Name1"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory = "Waiver"
      expiresOn         = "2025-12-29"
      metadata = {}
    }
  }
}
```

#### Create 3 policy exemptions for resources in selected RGs to be exempt from policies in selected assignments

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
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
    },
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
    },
    exemption3 = {
      deploymentMode               = "Incremental"
      name                         = "exemption3"
      scope                        = null
      displayName                  = "exemption3 for Insert-Your-RG-Name3"
      description                  = "exemption3 exempts policy compliance for resources in Insert-Your-RG-Name3"
      resourceGroupName            = "Insert-Your-RG-Name3"
      policyAssignmentId           = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Waiver"
      expiresOn                    = "2025-12-29"
      metadata                     = {}
    }
  }
}
```

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
```

# Variables

```hcl
variable "policyExemptions" {
  type = map(object({
    deploymentMode               = string
    name                         = string
    scope                        = string
    displayName                  = string
    description                  = string
    resourceGroupName            = string
    policyAssignmentId           = string
    policyDefinitionReferenceIds = list(string)
    exemptionCategory            = string
    expiresOn                    = string
    metadata                     = any
  }))
  description = <<EOF
    ***For policyExemptions ARM template specs see https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions?tabs=json
    -deploymentMode: The Deployment Mode for this Resource Group Template Deployment. Possible values are Complete (where resources in the Resource Group not specified in the ARM Template will be destroyed) and Incremental (where resources are additive only). If deployment_mode is set to Complete then resources within this Resource Group which are not defined in the ARM Template will be deleted.
    -name: The name which should be used for this Resource Group Template Deployment and the name of the policy exemption. Changing this forces a new Resource Group Template Deployment to be created.
    -scope: The full resource ID (string) which you want to apply the policy exemption to. Example: "/subscriptions/xxxx-xxxx/resourceGroups/resourceGroupName/providers/Microsoft.Storage/storageAccounts/storageAccountName". Resource ID used must be in the same RG as the resourceGroupName variable value for this module. Pass in a null or "" value if not applicable to your usage.
    -displayName: The display name of the policy exemption.
    -description: The description of the policy exemption.
    -resourceGroupName: The name of the Resource Group where the Resource Group Template Deployment should exist. Changing this forces a new Resource Group Template Deployment to be created.
    -policyAssignmentId: The ID of the policy assignment that is being exempted.
    -policyDefinitionReferenceIds: The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition.
    -exemptionCategory: The policy exemption category. Possible values are Waiver and Mitigated.
    -expiresOn: The expiration date and time (in UTC ISO 8601 format yyyy-MM-ddTHH:mm:ssZ) of the policy exemption.
    -metadata: The policy exemption metadata. Metadata is an open ended object and is typically a collection of key value pairs
  EOF
  default     = {}
}
}
```

# Contact

* Twitter: [@coder_au](https://twitter.com/coder_au)
* LinkedIn: [@JesseLoudon](https://www.linkedin.com/in/jesseloudon/)
* Web: [jloudon.com](https://jloudon.com)
* GitHub: [@JesseLoudon](https://github.com/jesseloudon)
