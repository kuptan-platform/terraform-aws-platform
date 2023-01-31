### Can also be passed using the EKS module using "cluster_identity_providers" config
### source code: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/main.tf#L420

# resource "aws_eks_identity_provider_config" "oidc" {
#   cluster_name = module.eks.cluster_name

#   oidc {
#     client_id                     = "your client_id"
#     identity_provider_config_name = "example"
#     issuer_url                    = "your issuer_url"
#   }
# }