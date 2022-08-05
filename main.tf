resource "azurerm_resource_group_template_deployment" "this" {
  for_each = var.policyExemptions

  name                = each.value.name
  resource_group_name = each.value.resourceGroupName
  deployment_mode     = each.value.deploymentMode
  template_content    = (file("${path.module}/policyExemptions.json"))
  parameters_content = jsonencode({
    name                         = { value = each.value.name }
    scope                        = { value = each.value.scope == null ? "" : each.value.scope }
    policyAssignmentId           = { value = each.value.policyAssignmentId }
    policyDefinitionReferenceIds = { value = each.value.policyDefinitionReferenceIds }
    exemptionCategory            = { value = each.value.exemptionCategory }
    expiresOn                    = { value = each.value.expiresOn }
    displayName                  = { value = each.value.displayName }
    description                  = { value = each.value.description }
    metadata                     = { value = each.value.metadata }
  })
  lifecycle {
    ignore_changes = [
      parameters_content,
    ]
  }
}
