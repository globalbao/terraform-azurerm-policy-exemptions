# Terraform AzureRM Policy Exemptions

Leverges Terraform's [resource group template deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) for managing [policy exemptions](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/policyexemptions).

Learn more about [Azure Policy Exemptions](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure)

# Example Usage

* Create 1 policy exemption with a RG exempt from all policies in an assignment.

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.1.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode     = "Incremental"
      name               = "exemption1"
      displayName        = "exemption1 for Insert-Your-RG-Name3"
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

* Create 3 policy exemptions with only 'exemption1' referencing select policies to be exempted (via policyDefinitionReferenceIds).

```hcl
module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.1.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode     = "Incremental"
      name               = "exemption1"
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
      deploymentMode     = "Incremental"
      name               = "exemption2"
      displayName        = "exemption2 for Insert-Your-RG-Name2"
      description        = "exemption2 waives compliance on an resource group"
      resourceGroupName  = "Insert-Your-RG-Name2"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory = "Mitigated"
      expiresOn         = "2025-12-31"
      metadata = {}
    },
    exemption3 = {
      deploymentMode     = "Incremental"
      name               = "exemption3"
      displayName        = "exemption3 for Insert-Your-RG-Name3"
      description        = "exemption3 waives compliance on an resource group"
      resourceGroupName  = "Insert-Your-RG-Name3"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory = "Waiver"
      expiresOn         = "2025-12-29"
      metadata = {}
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
```

# Contact

* Twitter: [@coder_au](https://twitter.com/coder_au)
* LinkedIn: [@JesseLoudon](https://www.linkedin.com/in/jesseloudon/)
* Web: [jloudon.com](https://jloudon.com)
* GitHub: [@JesseLoudon](https://github.com/jesseloudon)