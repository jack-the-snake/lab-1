variable "public-access" {
  type    = bool
  default = false
}

variable "tags-to-ignore" {
  type    = list(string)
  default = ["department"]
}