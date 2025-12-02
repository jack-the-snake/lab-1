variable "server-name" {
  type        = string
  default     = "kot"
  description = "Name of a server to provision"
}

locals {
  minNumberOfServer = 1
  maxNumberOfServer = 10
}

variable "number-of-servers" {
  type        = number
  description = "Required number of servers"
  default     = 2
  validation {
    condition     = var.number-of-servers >= local.minNumberOfServer && var.number-of-servers < local.maxNumberOfServer
    error_message = "Not supported number of server, it should be from the range ${local.minNumberOfServer} <= ${var.number-of-servers} < ${local.maxNumberOfServer}"
  }
}

variable "nubmer-of-disks" {
  type = number
}

variable "list-of-names" {
  type = list(string)
}

output "result" {
  value = "${var.server-name} x ${var.number-of-servers}"
}

output "number-of-resources" {
  value = var.nubmer-of-disks + var.number-of-servers
}

output "list-of-names" {
  value = "${join(", ",var.list-of-names)}"
}