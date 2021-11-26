# Terraform AzureRM Policy Exemptions

Uses a Terraform [Resource Group Template Deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) for managing [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions?WT.mc_id=AZ-MVP-5004598).

Learn more about [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure?WT.mc_id=AZ-MVP-5004598)

> Note: Terraform v0.13 or greater is required to use this module. Download the latest Terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

# Example Usage

More examples can be found here: [terraform-azurerm-policy-exemptions/tree/main/examples](https://github.com/globalbao/terraform-azurerm-policy-exemptions/tree/main/examples)

#### Exemption1

* exemption **scope** is set to a virtual machine
* **policyAssignmentId** is a management group level assignment
* specific policies to be exempted are passed in via **policyDefinitionReferenceIds** array/list
* **metadata** key/value pairs are passed in providing additional exemption context
  
#### Exemption2

* exemption **scope** is set to a storage account
* **policyAssignmentId** is a subscription level assignment

#### Exemption3

* exemption **scope** is null so exemption is applied to resources in the RG passed in via resourceGroupName variable
* **policyAssignmentId** is a management group level assignment

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode               = "Incremental"
      name                         = "exemption1"
      scope                        = "/subscriptions/xxxx-xxxx-xxxx-xxxx-xxxx/resourcegroups/Insert-Your-RG-Name1/providers/Microsoft.Compute/virtualMachines/virtualmachine1"
      displayName                  = "exemption1 for virtualmachine1 in Insert-Your-RG-Name1"
      description                  = "exemption1 exempts policy compliance for virtualmachine1 in Insert-Your-RG-Name1"
      resourceGroupName            = "Insert-Your-RG-Name1"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = [
        "installLogAnalyticsAgentOnVmMonitoring",
        "installLogAnalyticsAgentOnVmssMonitoring",
        "windowsDefenderExploitGuardMonitoring",
        "useRbacRulesMonitoring"
      ]
      exemptionCategory            = "Waiver"
      expiresOn                    = "2027-12-30"
      metadata = {
        "requestedBy" : "RG team",
        "approvedBy" : "DrGovernance",
        "approvedOn" : "2021-07-26",
        "ticketRef" : "123456"
      }
    },
    exemption2 = {
      deploymentMode               = "Incremental"
      name                         = "exemption2"
      scope                        = "/subscriptions/xxxx-xxxx-xxxx-xxxx-xxxx/resourceGroups/Insert-Your-RG-Name2/providers/Microsoft.Storage/storageAccounts/storageaccountname2"
      displayName                  = "exemption2 for storageaccountname2 in Insert-Your-RG-Name2"
      description                  = "exemption2 exempts policy compliance for storageaccountname2 in Insert-Your-RG-Name2"
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