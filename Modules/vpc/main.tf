resource "aws_vpc" "main" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 enable_dns_support = true
 tags = {
 Name = "${var.cluster_name}-vpc"
 "kubernetes.io/cluster/${var.cluster_name}" = "shared"
 }
 }
resource "aws_subnet" "private" {
 count = length(var.private_subnet_cidrs)
 vpc_id = aws_vpc.main.id
 cidr_block = var.private_subnet_cidrs[count.index]
 availability_zone = var.availability_zones[count.index]
 tags = {
 Name = "${var.cluster_name}-private-${count.index +
1}"
 "kubernetes.io/cluster/${var.cluster_name}" = "shared"
 "kubernetes.io/role/internal-elb" = "1"
 }
}
resource "aws_subnet" "public" {
 count = length(var.public_subnet_cidrs)
 vpc_id = aws_vpc.main.id
 cidr_block = var.public_subnet_cidrs[count.index]
 availability_zone = var.availability_zones[count.index]
 tags = {
 Name = "${var.cluster_name}-public-${count.index + 1}"
 "kubernetes.io/cluster/${var.cluster_name}" = "shared"
 "kubernetes.io/role/elb" = "1"
 }
}
# This Terraform module provisions a VPC with public and private subnets, an internet gateway, NAT gateways, and route tables.
# It is designed to be used as a module in a larger Terraform configuration for setting up an EKS cluster.
# The module takes in variables for VPC CIDR, availability zones, private and public subnet CIDRs, and the cluster name.
# The VPC is created with DNS support enabled, and the subnets are tagged for Kubernetes integration.
# The public subnets are associated with an internet gateway, while the private subnets use NAT gateways for outbound internet access.
# The route tables are configured to route traffic appropriately between public and private subnets, ensuring that the EKS cluster can function correctly.
# The module also ensures that the necessary tags are applied for Kubernetes integration, allowing the EKS cluster to recognize and utilize the VPC and subnets effectively.
# This module is a crucial part of the infrastructure setup for an EKS cluster, providing the necessary networking components to support the cluster's operation.
resource "aws_internet_gateway" "main" {
 vpc_id = aws_vpc.main.id
 tags = {
 Name = "${var.cluster_name}-igw"
 }
}
resource "aws_eip" "nat" {
 count = length(var.public_subnet_cidrs)
 domain = "vpc"
 tags = {
 Name = "${var.cluster_name}-nat-${count.index + 1}"
 }
}
resource "aws_nat_gateway" "main" {
 count = length(var.public_subnet_cidrs)
 allocation_id = aws_eip.nat[count.index].id
 subnet_id = aws_subnet.public[count.index].id
 tags = {
 Name = "${var.cluster_name}-nat-${count.index + 1}"
 }
}
resource "aws_route_table" "public" {
 vpc_id = aws_vpc.main.id
 route {
 cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.main.id
 }
 tags = {
 Name = "${var.cluster_name}-public"
 }
}
resource "aws_route_table" "private" {
 count = length(var.private_subnet_cidrs)
 vpc_id = aws_vpc.main.id
 route {
 cidr_block = "0.0.0.0/0"
 nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
 tags = {
 Name = "${var.cluster_name}-private-${count.index + 1}"
 }
}
resource "aws_route_table_association" "private" {
 count = length(var.private_subnet_cidrs)
 subnet_id = aws_subnet.private[count.index].id
 route_table_id = aws_route_table.private[count.index].id
}
resource "aws_route_table_association" "public" {
 count = length(var.public_subnet_cidrs)
 subnet_id = aws_subnet.public[count.index].id
 route_table_id = aws_route_table.public.id
}
