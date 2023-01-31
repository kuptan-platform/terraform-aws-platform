variable "region" {
  description = "the region where AWS resources will be created"
  type        = string
}

variable "vpc_name" {
  description = "the VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "the VPC cidr range"
  type        = string
}

variable "azs" {
  description = "a list of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "a list of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "a list of private subnets"
  type        = list(string)
}

variable "cluster_name" {
  description = "the EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "the EKS Kubernetes version"
  type        = string
}

variable "enable_cluster_public_access" {
  description = "a flag to make the API server accessable through internet"
  type        = bool

  default = false
}

variable "node_pools" {
  description = "a set of EKS node groups to be created"
  type = list(object({
    name           = string
    desired_size   = number
    min_size       = number
    max_size       = number
    disk_size      = optional(number, 20)
    instance_types = list(string)
    labels         = map(string)
    taints = map(object({
      key    = string
      value  = string
      effect = optional(string, "NO_SCHEDULE")
    }))
  }))

  default = []
}

variable "enable_custom_eks_oidc_issuer" {
  description = "a flag to enable custom identity provider configuration"
  type        = bool

  default = false
}

variable "oidc_identity_providers" {
  description = "Manages an EKS Identity Provider Configuration"
  sensitive   = true
  type = map(object({
    client_id     = string
    client_secret = string
    issuer_url    = string
  }))

  default = {}
}

variable "tags" {
  description = "tags to be attached to resources create by this module"
  type        = map(string)

  default = {}
}