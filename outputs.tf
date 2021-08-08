output "variables" {
  value = var.policyExemptions
}

output "template_deployment" {
  value = {
    for k, v in try(azurerm_resource_group_template_deployment.this.*, {}) :
    k => try(jsondecode(v), v)
  }
}