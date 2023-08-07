resource "aws_security_group" "additional" {
  name_prefix = "${module.modvars.env}-eks-terraform-managed-additional"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = flatten(["${data.aws_nat_gateway.nat_gateway.public_ip}/32", var.higher_env_ips])
    description = "Whitelist  ENVs IPs for HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = flatten(["${data.aws_nat_gateway.nat_gateway.public_ip}/32", var.higher_env_ips])
    description = "Whitelist  ENVs IPs for HTTPS"
  }

  tags = local.tags

}

resource "aws_security_group" "employees_ips" {
  name_prefix = "${module.modvars.env}-employees-ips"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.employees_ips
    description = "Whitelist Employess IPs"
  }
  tags = local.tags

}
