variable "server-name" {
  type        = string
  description = "Name of a server to provision"
}

output "out" {
  value = var.server-name
}