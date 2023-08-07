locals {
  eks_node_tags = {
    "k8s.io/cluster-autoscaler/${module.modvars.env}-eks-terraform-managed" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                                     = "true"
  }
  eks_cluster_tags = {
    "eks_cluster" = "${module.modvars.env}-eks-terraform-managed"
  }
  tags = merge(module.modvars.tags, local.eks_cluster_tags, var.tags)
}
