// Configure AWS VPC, Subnets, and Routes

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "1.66.0"

  name = "${ var.AWS_vpc_name }"
  cidr = "${ var.AWS_vpc_subnet }"

  azs            = "${ var.AWS_azs }"
  public_subnets = "${ var.AWS_public_subnets }"

  enable_nat_gateway                = false
  propagate_public_route_tables_vgw = true
  enable_dns_hostnames              = true
  
  tags = "${merge(
    "${var.AWS_tags}",
    map(
        "kubernetes.io/role/elb", "1"
    )
  )}"
}


