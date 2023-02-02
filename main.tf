data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/release_version"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = var.enable_cluster_public_access

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    attach_cluster_primary_security_group = true
    vpc_security_group_ids                = [module.vpc.default_vpc_default_security_group_id]
    ami_release_version                   = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  }

  eks_managed_node_groups = { for p in var.node_pools : p.name => p }

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::034593935044:user/hamurabi-test-user"
      username = "hamurabi-test-user"
      groups   = ["system:masters"]
    },
  ]
  aws_auth_roles    = []
  aws_auth_accounts = []

  tags = var.tags
}

