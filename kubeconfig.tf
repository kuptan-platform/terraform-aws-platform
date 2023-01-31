# locals {
#   kubeconfig = replace(yamlencode({
#     apiVersion      = "v1"
#     kind            = "Config"
#     current-context = var.cluster_name
#     clusters = [{
#       name = var.cluster_name
#       cluster = {
#         certificate-authority-data = module.eks.cluster_certificate_authority_data
#         server                     = module.eks.cluster_endpoint
#       }
#     }]
#     contexts = [{
#       name = var.cluster_name
#       context = {
#         cluster = var.cluster_name
#         user    = var.cluster_name
#       }
#     }]
#     users = [{
#       name = var.cluster_name
#       user = {
#         exec = {
#           apiVersion = "client.authentication.k8s.io/v1beta1"
#           args = [
#             "get-token",
#             "--oidc-issuer-url=${var.oidc_issuer_url}",
#             "--oidc-client-id=${var.oidc_client_id}",
#             "--oidc-client-secret=${var.oidc_client_secret}",
#           ]
#           command = "kubelogin"
#         }
#       }
#     }]
#   }), "\"", "")
# }