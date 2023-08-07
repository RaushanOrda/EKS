module "eks" {
  source                      = "../../modules/terraform-aws-eks"
  cluster_name                = "${module.modvars.env}-eks-terraform"
  cluster_version             = 1.23
  control_plane_subnet_ids    = [data.aws_subnets.private.ids[0], data.aws_subnets.private.ids[2]]
  subnet_ids                  = data.aws_subnets.private.ids
  vpc_id                      = data.aws_vpc.vpc.id
  create_iam_role             = true
  create_cloudwatch_log_group = false
  cluster_enabled_log_types   = []
  manage_aws_auth_configmap   = true
  cluster_addons = {
    coredns = {

      resolve_conflicts = "OVERWRITE"
      # configuration_values = "{\"nodeSelector\":kubernetes.io/os: linux,\"replicaCount\":2,\"resources\":{\"limits\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"},\"requests\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"}}}"
    }


    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }


  eks_managed_node_groups = {
    main_node_group = {
      min_size            = 0
      max_size            = 3
      desired_size        = 1
      autoscaling_enabled = true
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 75
            volume_type           = "gp3"
            encrypted             = false
            delete_on_termination = true
          }
        }
      }
      capacity_type  = "ONDEMAND"
      instance_types = "${var.instance_type}"
      taints = {
        dedicated = {
          key      = "dedicated"
          value    = "group"
          operator = "Equal"
          effect   = "NO_EXECUTE"
        }
      }
      labels = {
        # services-private = "true"
        group = "true"
      }
      additional_tags = merge(local.tags, local.eks_node_tags)
      tags = {
        "k8s.io/cluster-autoscaler/node-template/label/env" = "main_node_group"
      }
    }

  }
  aws_auth_users = local.eks_auth_users
  tags           = local.tags
}
resource "aws_eks_addon" "aws-ebs-csi-driver" {
  depends_on               = [module.eks.cluster_id]
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn
  tags                     = local.tags
}
