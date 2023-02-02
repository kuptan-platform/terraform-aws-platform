region          = "eu-west-1"
vpc_name        = "test-local"
vpc_cidr        = "10.1.0.0/19"
azs             = ["eu-west-1a", "eu-west-1b"]
private_subnets = ["10.1.16.0/22", "10.1.20.0/22"]
public_subnets  = ["10.1.24.0/22", "10.1.28.0/22"]

enable_nat_gateway   = true
enable_dns_hostnames = true

cluster_name                 = "test-local"
cluster_version              = "1.24"
enable_cluster_public_access = true

node_pools = [{
  name           = "dev-cluster"
  desired_size   = 1
  min_size       = 1
  max_size       = 2
  disk_size      = 20
  instance_types = ["t2.medium"]
  labels = {
    "role" : "general-purpose"
  }
  taints = {}
}]

tags = {
  "Environment" = "local"
  "Terraform"   = "true"
}
