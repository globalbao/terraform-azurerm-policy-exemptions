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
      policyAssignmentId           = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Waiver"
      expiresOn                    = "2027-12-30"
      metadata                     = {}
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