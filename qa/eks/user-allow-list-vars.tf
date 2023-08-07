locals {
  eks_auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform"
      username = "terraform"
      groups   = ["system:masters"]
    }
  ]
  employees_ips = [

  ]
}
