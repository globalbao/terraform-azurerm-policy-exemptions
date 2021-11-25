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
    -scope: Use when creating an extension resource at a scope that is different than the deployment scope. Set the value to the full name of the resource to apply the extension resource to.
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
