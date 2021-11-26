# Terraform AzureRM Policy Exemptions

Uses a Terraform [Resource Group Template Deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) for managing [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions?WT.mc_id=AZ-MVP-5004598).

Learn more about [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure?WT.mc_id=AZ-MVP-5004598)

> Note: Terraform v0.13 or greater is required to use this module. Download the latest Terraform at [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

# Example Usage

* Use a count expression on a variable to determine if policy exemptions are created.
* Create 3 policy exemptions with only 'exemption1' referencing select policies to be exempted (via policyDefinitionReferenceIds).

> More examples can be found here: [terraform-azurerm-policy-exemptions/tree/main/examples](https://github.com/globalbao/terraform-azurerm-policy-exemptions/tree/main/examples)

```hcl
module "policy_exemptions" {
  count   = var.exemptions_required ? 1 : 0
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
      policyDefinitionReferenceIds = [
        "installLogAnalyticsAgentOnVmMonitoring",
        "installLogAnalyticsAgentOnVmssMonitoring",
        "windowsDefenderExploitGuardMonitoring",
        "useRbacRulesMonitoring"
      ]
      exemptionCategory = "Waiver"
      expiresOn         = "2025-12-30"
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
      scope                        = null
      displayName                  = "exemption2 for Insert-Your-RG-Name2"
      description                  = "exemption2 waives compliance on an resource group"
      resourceGroupName            = "Insert-Your-RG-Name2"
      policyAssignmentId           = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Mitigated"
      expiresOn                    = "2025-12-31"
      metadata                     = {}
    },
    exemption3 = {
      deploymentMode               = "Incremental"
      name                         = "exemption3"
      scope                        = null
      displayName                  = "exemption3 for Insert-Your-RG-Name3"
      description                  = "exemption3 waives compliance on an resource group"
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