variable "server-name" {
  type        = string
  description = "Name of a server to provision"
}

locals {
  minNumberOfServer = 1
  maxNumberOfServer = 10
}

variable "number-of-servers" {
  type = number
  description = "Required number of servers"
  validation {
    condition = var.number-of-servers >= local.minNumberOfServer && var.number-of-servers < local.maxNumberOfServer
    error_message = "Not supported number of server, it should be from the range ${local.minNumberOfServer} <= ${var.number-of-servers} < ${local.maxNumberOfServer}" 
  }
}

output "out" {
  value = var.server-name
}