# data "aws_ssm_parameter" "eks_ami_release_version" {
#   name = "/aws/service/eks/optimized-ami/${module.eks.cluster_version}/amazon-linux-2/recommended/release_version"
# }

# module "eks_managed_node_group" {
#   source   = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
#   for_each = { for p in var.node_pools : p.name => p }

#   name            = each.value.name
#   cluster_name    = module.eks.cluster_name
#   cluster_version = module.eks.cluster_version

#   ami_release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

#   subnet_ids = module.vpc.private_subnets

#   cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id

#   min_size     = each.value.min_size
#   max_size     = each.value.max_size
#   desired_size = each.value.desired_size
#   disk_size    = each.value.disk_size

#   instance_types = each.value.instance_types
#   capacity_type  = "ON_DEMAND"

#   labels = each.value.labels
#   taints = each.value.taints

#   tags = var.tags
# }