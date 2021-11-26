module "policy_exemptions" {
  source  = "globalbao/policy-exemptions/azurerm"
  version = "0.3.0"
  policyExemptions = {
    exemption1 = {
      deploymentMode     = "Incremental"
      name               = "exemption1"
      scope              = "/subscriptions/xxxx-xxxx-xxxx-xxxx-xxxx/resourceGroups/Insert-Your-RG-Name1/providers/Microsoft.Storage/storageAccounts/storageaccountname1"
      displayName        = "exemption1 for storageaccountname1 in Insert-Your-RG-Name1"
      description        = "exemption1 exempts policy assignment compliance for storageaccountname1 in Insert-Your-RG-Name1"
      resourceGroupName  = "Insert-Your-RG-Name1"
      policyAssignmentId = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = [
        "installLogAnalyticsAgentOnVmMonitoring",
        "installLogAnalyticsAgentOnVmssMonitoring",
        "windowsDefenderExploitGuardMonitoring",
        "useRbacRulesMonitoring"
      ]
      exemptionCategory = "Waiver"
      expiresOn         = "2027-12-30"
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
      description                  = "exemption2 exempts policy assignment compliance for storageaccountname2 in Insert-Your-RG-Name2"
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
      description                  = "exemption3 exempts policy assignment compliance for Insert-Your-RG-Name3"
      resourceGroupName            = "Insert-Your-RG-Name3"
      policyAssignmentId           = "/providers/Microsoft.Management/managementGroups/production/providers/Microsoft.Authorization/policyAssignments/2f97de7d41f348529e23d8ae"
      policyDefinitionReferenceIds = []
      exemptionCategory            = "Waiver"
      expiresOn                    = "2025-12-29"
      metadata                     = {}
    }
  }
}
