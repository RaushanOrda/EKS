data "aws_caller_identity" "current" {}

# data "aws_eks_cluster" "eks" {
#   name = "${module.modvars.env}-eks-terraform"
# }

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["main-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${module.modvars.env}-vpc-private-*"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${module.modvars.env}-vpc-public-*"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

# data "aws_acm_certificate" "issued" {
#   domain   = "*.qa.com"
#   statuses = ["ISSUED"]
# }

data "aws_nat_gateway" "nat_gateway" {
  tags = {
    Name = "${module.modvars.env}-vpc-${module.modvars.region}a"
  }
}