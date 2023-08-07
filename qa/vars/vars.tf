variable "region" {
  type    = string
  default = "eu-central-1"
}

output "region" {
  value = var.region
}

variable "env" {
  type    = string
  default = "qa"
}

output "env" {
  value = var.env
}

variable "tags" {
  type = map(any)
  default = {
    Environment = "qa"
  }
}

output "tags" {
  value = var.tags
}
