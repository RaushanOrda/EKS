variable "instance_type" {
  type = list(any)
  default = [
    "c5.9xlarge",
    "c5a.8xlarge",
    "c5ad.8xlarge",
    "c5n.4xlarge",
    "c5n.9xlarge",
    "c5ad.12xlarge",
    "m4.10xlarge",
    "m5.8xlarge",
    "m5a.2xlarge",
    "m5a.4xlarge",
    "m5a.8xlarge",
    "m5ad.12xlarge",
    "m5ad.8xlarge",
    "m5d.4xlarge",
    "m5d.8xlarge",
    "m5dn.4xlarge",
    "m5dn.8xlarge",
    "m5n.4xlarge",
    "m5n.8xlarge",
    "m5zn.2xlarge",
    "m5zn.3xlarge",
    "r4.4xlarge",
    "r4.8xlarge",
    "r5.12xlarge",
    "r5.4xlarge",
    "r5.8xlarge",
    "r5a.4xlarge",
    "r5a.8xlarge",
    "r5ad.12xlarge",
    "r5ad.4xlarge",
    "r5b.2xlarge",
    "r5b.4xlarge",
    "r5b.8xlarge",
    "r5d.12xlarge",
    "r5d.2xlarge",
    "r5d.4xlarge",
    "r5dn.4xlarge",
    "r5dn.8xlarge",
    "r5n.4xlarge",
    "r5n.8xlarge",
  ]
}

variable "higher_env_ips" {
  type = list(string)
  default = [
  ]
}

variable "tags" {
  type = map(any)
  default = {
    service = "eks"
  }
}
